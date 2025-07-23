//
//  SearchView.swift
//  VINNY
//
//  Created by 소민준 on 7/19/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(spacing: 0) {
            header
            searchBar
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    switch viewModel.state {
                    case .showingDefault:
                        recentKeywordSection
                        categorySection
                    case .searching:
                        searchResultSection
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
        }
        .background(Color.black.ignoresSafeArea())
    }

    private var header: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }
            Spacer()
            Text("검색하기")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.left").opacity(0)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("빈티지샵, 게시글 검색하기", text: $viewModel.searchText)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color("searchFieldBackground"))
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }

    private var recentKeywordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("최근 검색어")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Button("모두 삭제") {
                    viewModel.clearAllKeywords()
                }
                .font(.system(size: 13))
                .foregroundColor(.gray)
            }

            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(viewModel.recentKeywords, id: \.self) { keyword in
                    HStack {
                        Text(keyword)
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            viewModel.removeKeyword(keyword)
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                        }
                    }
                }
            }
        }
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("카테고리로 모아보기")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(Category.sampleList) { category in
                    CategoryItemView(category: category)
                }
            }
        }
    }

    private var searchResultSection: some View {
        LazyVStack(spacing: 12) {
            ForEach(viewModel.searchResults) { shop in
                SearchResultCell(shop: shop)
            }
        }
    }
}
#Preview {
    NavigationStack {
        SearchView()
    }
}
