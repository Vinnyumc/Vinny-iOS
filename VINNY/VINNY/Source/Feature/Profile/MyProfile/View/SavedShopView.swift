//
//  SavedShopView\.swift
//  VINNY
//
//  Created by 한태빈 on 7/24/25.
//

import SwiftUI
import Kingfisher

struct SavedShopView: View {
    @EnvironmentObject var viewModel: MypageViewModel

    var body: some View {
        if viewModel.savedShops.isEmpty {
            EmptyView()
        } else {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.savedShops, id: \.shopId) { shop in
                        ShopCardView(shop: shop)
                    }
                }
                .padding(.top, 8)
                .padding(.horizontal, 16)
            }
        }
    }
}

struct ShopCardView: View {
    @EnvironmentObject var container: DIContainer
    let shop: MypageSavedShopsResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 상단 프로필 + 상호명 + 버튼
            HStack(spacing: 8) {
                KFImage(URL(string: shop.thumbnailUrl))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text(shop.name)
                        .font(.suit(.medium, size: 18))
                        .foregroundStyle(Color.contentBase)
                    Text(shop.address)
                        .font(.suit(.light, size: 12))
                        .foregroundStyle(Color.contentAdditive)
                }

                Spacer()

                Image("chevron.right")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .padding(.vertical, 8)

            // 지역명 + 태그
            HStack(spacing: 6) {
                HStack(spacing: 4) {
                    Image("mapPin")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(shop.regionName)
                        .font(.suit(.medium, size: 12))
                        .foregroundStyle(Color.contentAdditive)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(Color.backFillRegular)
                )

                ForEach(shop.vintageStyles, id: \.self) { style in
                    TagComponent(tag: "#\(style)")
                }
            }
            .padding(.vertical, 8)

            // 썸네일 이미지
            KFImage(URL(string: shop.thumbnailUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 104)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.vertical, 8)

            Divider()
                .padding(.bottom, 12)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("전체 VStack 클릭됨")
            container.navigationRouter.push(to: .ShopView(id: shop.shopId))
        }
    }
}


