//
//  SearchResultCell 2.swift
//  VINNY
//
//  Created by 소민준 on 7/19/25.
//


import SwiftUI

struct SearchResultCell: View {
    let shop: Shop

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                // 썸네일 이미지 (없으면 placeholder)
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                VStack(alignment: .leading, spacing: 4) {
                    Text(shop.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)

                    Text(shop.address)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }

            // 태그들
            HStack(spacing: 6) {
                Label("지역", systemImage: "mappin.and.ellipse")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .labelStyle(.titleOnly)

                Text("카테고리1")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)

                Text("카테고리2")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)

                Text("카테고리3")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding()
       // .background(Color(black))
        .cornerRadius(12)
    }
}
