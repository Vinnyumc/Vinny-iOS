//
//  MapTopView.swift
//  VINNY
//
//  Created by 홍지우 on 7/15/25.
//

import SwiftUI

struct MapTopView: View {
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Text("지도")
                    .font(.suit(.bold, size: 24))
                    .foregroundStyle(Color.contentBase)
                
                Spacer()
                
                Image("notifications")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
            
            HStack(spacing: 8) {
                Image("magnifier")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text("빈티지샵, 게시글 검색하기")
                    .font(.suit(.regular, size: 16))
                    .foregroundStyle(Color.contentAssistive)
                
                Spacer()
                
                Image("close")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color.backFillRegular)
            )
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            HStack(spacing: 8) {
                Image("star")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(Color.backFillRegular)
                    )
                
                HStack(spacing: 2) {
                    Image("reset")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("현 위치에서 검색")
                        .font(.suit(.medium, size: 14))
                        .foregroundStyle(Color.contentBase)
                }
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(Color.backFillRegular)
                )
                
                Image("icon")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(Color.backFillRegular)
                    )
            }
            .padding(.horizontal)
            .padding(.bottom, 14)
        }
        .background(Color.backFillStatic)
        .ignoresSafeArea()
    }
}

#Preview {
    MapTopView()
}
