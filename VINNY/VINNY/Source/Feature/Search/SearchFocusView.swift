//
//  SearchFocusView.swift
//  VINNY
//
//  Created by 소민준 on 7/26/25.
//


import SwiftUI

struct SearchFocusView: View {
    let recommendedKeywords: [String]
    let recentKeywords: [String]
    let onTapKeyword: (String) -> Void
    let onDeleteKeyword: (String) -> Void
    let onClearAll: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // 추천 검색어
                VStack(alignment: .leading, spacing: 12) {
                    Text("추천 검색어")
                        .font(.suit(.semibold, size: 16))
                        .foregroundColor(.white)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(recommendedKeywords, id: \.self) { keyword in
                                Button(action: {
                                    onTapKeyword(keyword)
                                }) {
                                    Text(keyword)
                                        .font(.suit(.medium, size: 14))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color.backFillRegular)
                                        )
                                        .foregroundStyle(Color.contentBase)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                // 최근 검색어
                if !recentKeywords.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("최근 검색어")
                                .font(.suit(.semibold, size: 16))
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: onClearAll) {
                                Text("전체 삭제")
                                    .font(.suit(.regular, size: 14))
                                    .foregroundColor(.gray)
                            }
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(recentKeywords, id: \.self) { keyword in
                                HStack {
                                    Button(action: {
                                        onTapKeyword(keyword)
                                    }) {
                                        Text(keyword)
                                            .font(.suit(.medium, size: 14))
                                            .foregroundStyle(Color.contentBase)
                                    }
                                    Spacer()
                                    Button(action: {
                                        onDeleteKeyword(keyword)
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.backFillRegular)
                                )
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 32)
        }
        .background(Color.backRootRegular)
    }
}
#Preview {
    SearchFocusView(
        recommendedKeywords: ["밀리터리", "스트릿", "레더"],
        recentKeywords: ["아메카지", "빈티지"],
        onTapKeyword: { _ in },
        onDeleteKeyword: { _ in },
        onClearAll: {}
    )
}

