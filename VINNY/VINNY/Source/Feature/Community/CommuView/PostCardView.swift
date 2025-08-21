//
//  PostCardView.swift
//  VINNY
//
//  Created by 홍지우 on 7/20/25.
//

import SwiftUI

struct PostCardView: View {
    @EnvironmentObject var container: DIContainer


    let item: PostItemDTO


    @State private var currentIndex: Int = 0
    @State private var isLiked: Bool = false
    @State private var isBookmarked: Bool = false
    @State private var likeCount: Int = 0
    
    private var imageTopShape: UnevenRoundedRectangle {
        UnevenRoundedRectangle(
            topLeadingRadius: 16,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: 0,
            topTrailingRadius: 16,
            style: .continuous
        )
    }

    var body: some View {
        let headerShape = UnevenRoundedRectangle(
            topLeadingRadius: 16, bottomLeadingRadius: 0,
            bottomTrailingRadius: 0, topTrailingRadius: 16,
            style: .continuous
        )
        
        let card = VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .top) {
                    // Images: page style
                    VStack(spacing: 0) {
                        if item.images.isEmpty {
                            Image("emptyBigImage")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipped()
                        } else {
                            TabView(selection: $currentIndex) {
                                ForEach(Array(item.images.enumerated()), id: \.offset) { pair in
                                    let urlString = pair.element
                                    URLImageView(urlString)
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        .tag(pair.offset)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .clipShape(imageTopShape)
                            
                            // custom indicators
                            HStack(spacing: 4) {
                                ForEach(0 ..< max(item.images.count, 1), id: \.self) { index in
                                    Circle()
                                        .fill(index == currentIndex ? Color.gray : Color.gray.opacity(0.3))
                                        .frame(width: 4, height: 4)
                                }
                            }
                            .animation(.easeInOut, value: currentIndex)
                            .padding(.top, 8)
                        }
                    }
                    
                    // Header: author
                    Button {
                        container.navigationRouter.push(to: .YourProfileView(userId: item.author.userId))
                    } label: {
                        HStack(spacing: 8) {
                            URLImageView(item.author.profileImageUrl ?? "")
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            VStack(alignment: .leading, spacing: 2) {
                                Text(item.author.nickname)
                                    .font(.suit(.medium, size: 16))
                                    .foregroundStyle(Color.contentBase)
                                Text(item.author.comment ?? "")
                                    .font(.suit(.light, size: 12))
                                    .foregroundStyle(Color.contentAdditive)
                            }
                            .padding(.horizontal, 4)
                            Spacer()
                            
                            Image("chevron.right")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(.plain) // 기본 버튼 효과 제거 (클릭 UI 안 바뀌게)
                    .background{
                        Rectangle()
                            .fill(.regularMaterial)
                            .blendMode(.multiply)
                        Rectangle()
                            .fill(Color.backFillStatic.opacity(0.82))
                    }
                }
                .clipShape(imageTopShape)
                .padding(.vertical, 10)

                // tags row (shop/style/brand)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 6) {
                        if let shop = item.shop {
                            HStack(spacing: 4) {
                                Image("mapPinFill")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text(shop.shopName)
                                    .font(.suit(.medium, size: 12))
                                    .foregroundStyle(Color.contentAdditive)
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundStyle(Color.backFillRegular)
                            )
                        }

                        ForEach(item.styles, id: \.self) { st in
                            TagComponent(tag: "\(st.styleName)")
                        }
                        ForEach(item.brands, id: \.self) { br in
                            TagComponent(tag: "# \(br.brandName)")
                        }
                    }
                    .padding(.horizontal, 16)
//                    .padding(.vertical, 10)
                }
                .padding(.vertical, 10)
                
                // meta + title + content
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.createdAtRelative)
                        .font(.suit(.medium, size: 12))
                        .foregroundStyle(Color.contentAssistive)
                    Text(item.title)
                        .font(.suit(.bold, size: 18))
                        .foregroundStyle(Color.contentBase)
                    if !item.content.isEmpty {
                        Text(item.content)
                            .font(.suit(.light, size: 14))
                            .foregroundStyle(Color.contentAdditive)
                    }
                }
                .padding(.horizontal, 20)
//                .padding(.vertical, 10)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                container.navigationRouter.push(to: .PostView(id: item.postId))
            }
            .simultaneousGesture(TapGesture())

            HStack(spacing: 6) {
                Button(action: {
                    Task {
                        do {
                            _ = try await PostAPITarget.performLike(postId: item.postId, isCurrentLiked: isLiked)
                            if isLiked {
                                isLiked = false
                                likeCount -= 1
                            } else {
                                isLiked = true
                                likeCount += 1
                            }
                        } catch {
                            print("like failed:", error)
                        }
                    }
                }) {
                    Image(isLiked ? "likeFill" : "like")
                        .resizable()
                        .frame(width: 20, height: 20)
                }

                Text("\(likeCount)개")
                    .font(.suit(.medium, size: 14))
                    .foregroundStyle(Color.contentAdditive)
                Spacer()

                Button(action: {
                    Task {
                        do {
                            _ = try await PostAPITarget.performBookmark(postId: item.postId, isCurrentBookmarked: isBookmarked)
                            if isBookmarked {
                                isBookmarked = false
                            } else {
                                isBookmarked = true
                            }
                        } catch {
                            print("bookmark failed:", error)
                        }
                    }
                }) {
                    Image(isBookmarked ? "bookmarkFill" : "bookmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.backFillRegular)
        )
        .onAppear {
            // 초기 상태를 서버 값으로 동기화
            self.isLiked = item.likedByMe
            self.isBookmarked = item.bookmarkedByMe
            self.likeCount = item.likesCount
        }
        
        card
            .frame(maxHeight: .infinity, alignment: .top)
    }
}

private struct URLImageView: View {
    private let urlString: String
    init(_ urlString: String) { self.urlString = urlString }

    var body: some View {
        Group {
            if let url = URL(string: urlString), !urlString.isEmpty {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ZStack { Color.clear; ProgressView() }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image("emptyBigImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    @unknown default:
                        Image("emptyBigImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
            } else {
                Image("emptyBigImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
