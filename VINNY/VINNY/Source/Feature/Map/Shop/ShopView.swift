//
//  ShopView.swift
//  VINNY
//
//  Created by 홍지우 on 7/16/25.
//

import SwiftUI

struct ShopView: View {
    private var shopName: String = "샵 이름"
    private var shopAddress: String = "샵 주소"
    private var shopIG: String = "vintageplus_trendy"
    private var shopTime: String = "12:00 ~ 23:00"
    private var categories: [String] = ["카테고리1", "카테고리2", "카테고리3"]
    
    @State var selectedFilter: Int = 0
    private var filters: [String] = ["후기 작성", "길 찾기"]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 상단 고정 바
            ZStack {
                HStack {
                    Button (action: {
                        print("뒤로 가기")
                    }) {
                        Image("arrowBack")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    Spacer()
                }
                Text("빈티지샵 보기")
                    .font(.suit(.regular, size: 18))
                    .foregroundStyle(Color.contentBase)
            }
            .padding(16)
            
            Divider()
            
            // MARK: - 스크롤뷰
            ScrollView {
                LazyVStack(spacing: 0) {
                    Image("emptyBigImage") // 샵 사진
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    
                    HStack(spacing: 8) {
                        Image("emptyImage")
                            .resizable()
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(shopName)")
                                .font(.system(size: 18))
                                .foregroundStyle(Color.contentBase)
                            Text("\(shopAddress)")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.contentAdditive)
                        }
                        Spacer()
                        Image("like")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    
                    HStack(spacing: 2) {
                        Image("instargram")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("인스타그램")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.contentAssistive)
                            .padding(.horizontal, 4)
                            .frame(maxWidth: 82, alignment: .leading)
                        Text("\(shopIG)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.contentAdditive)
                            .padding(.horizontal, 4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    
                    HStack(spacing: 2) {
                        Image("time")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("영업 시간")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.contentAssistive)
                            .padding(.horizontal, 4)
                            .frame(maxWidth: 82, alignment: .leading)
                        Text("\(shopTime)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.contentAdditive)
                            .padding(.horizontal, 4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                    
                    HStack {
                        HStack(spacing: 4) {
                            Image("mapPin")
                                .resizable()
                                .frame(width: 16, height: 16)
                            Text("지역")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.contentAdditive)
                        }
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(Color.backFillRegular)
                        )
                        
                        ForEach(categories, id: \.self) { category in
                            TagComponent(tag: category)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("소개글 제목")
                                .font(.system(size: 18))
                                .foregroundStyle(Color.contentBase)
                            Text("소개글 내용")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.contentAdditive)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    
                    CustomTabView()
                }
            }
            
            // MARK: - 고정 버튼
            HStack(spacing: 0) {
                ForEach(filters.indices, id: \.self) { index in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            selectedFilter = index
                        }
                    }) {
                        HStack {
                            Text(filters[index])
                                .font(selectedFilter == index ? .suit(.bold, size: 16) : .suit(.light, size: 16))
                                .foregroundStyle(selectedFilter == index ? Color.contentInverted : Color.contentBase)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(selectedFilter == index ? Color.backFillInverted : Color.backFillRegular)
                        )
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        .background(Color.backFillStatic)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ShopView()
}
