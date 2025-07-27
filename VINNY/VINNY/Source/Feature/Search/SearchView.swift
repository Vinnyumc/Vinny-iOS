//
//  SearchView.swift
//  VINNY
//
//  Created by 소민준 on 7/19/25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var container: DIContainer
    init(container : DIContainer){
        
    }
   
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
        HStack(spacing: 8) {
            Image("magnifier")
                .resizable()
                .frame(width: 24, height: 24)
            
            TextField("빈티지샵, 게시글 검색하기", text: $viewModel.searchText)
                .foregroundColor(.white)
                .font(.suit(.regular, size: 16))
                .onTapGesture {
                    viewModel.state = .searching(viewModel.searchText)
                }

            Spacer()

            if !viewModel.searchText.isEmpty {
                Button(action: {
                    viewModel.searchText = ""
                }) {
                    Image("close")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.backFillRegular)
        )
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("카테고리로 모아보기")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(CategoryItem.sampleList) { category in
                    CategoryItemView(categoryItem: category)
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
    let container = DIContainer()
    SearchView(container: container)
        .environmentObject(container)
}
