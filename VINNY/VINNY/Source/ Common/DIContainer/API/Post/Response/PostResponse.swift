//
//  PostResponse.swift
//  VINNY
//
//  Created by 소민준 on 8/15/25.
//


import Foundation

// MARK: - GET /api/post (Paged list)
struct PostListResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PostListResultDTO
    let timestamp: String
}

struct PostListResultDTO: Decodable {
    let posts: [PostItemDTO]
    let pageInfo: PageInfoDTO
}

struct PageInfoDTO: Decodable {
    let page: Int
    let size: Int
    let totalPages: Int
    let totalElements: Int
}

struct PostItemDTO: Decodable, Hashable {
    let postId: Int
    let author: PostAuthorDTO
    let title: String
    let content: String
    let images: [String]
    let createdAt: String
    let createdAtRelative: String
    let likesCount: Int
    let bookmarkedByMe: Bool
    let shop: PostShopMiniDTO?
    let styles: [PostStyleMiniDTO]
    let brands: [PostBrandMiniDTO]
    let likedByMe: Bool
}

// MARK: - GET /api/post/popular (Popular list)
// 서버 응답 스키마가 /api/post 와 동일하므로 기존 리스트 DTO를 그대로 재사용합니다.
// 가독성을 위해 typealias 를 제공해 둡니다.
typealias PopularPostListResponseDTO = PostListResponseDTO
typealias PopularPostListResultDTO = PostListResultDTO
typealias PopularPostItemDTO = PostItemDTO

struct PostAuthorDTO: Decodable, Hashable {
    let userId: Int
    let nickname: String
    let profileImageUrl: String?
    let comment: String?
}

struct PostShopMiniDTO: Decodable, Hashable {
    let shopId: Int
    let shopName: String
}

struct PostStyleMiniDTO: Decodable, Hashable {
    let styleId: Int
    let styleName: String
}


struct PostBrandMiniDTO: Decodable, Hashable {
    let brandId: Int
    let brandName: String
}


// MARK: - GET /api/post/{postId} (Detail)
struct PostDetailResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PostDetailDTO
    let timestamp: String
}

struct PostDetailDTO: Decodable, Hashable {
    let postId: Int
    let title: String
    let author: PostAuthorDTO
    let content: String
    let images: [String]
    let createdAt: String
    let createdAtRelative: String
    let likesCount: Int
    let bookmarkedByMe: Bool
    let shop: PostShopMiniDTO?
    let styles: [PostStyleMiniDTO]
    let brands: [PostBrandMiniDTO]
    let myPost: Bool
    let likedByMe: Bool
}


// MARK: - POST /api/post (Create)


struct CreatePostResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CreatePostResultDTO
    let timestamp: String
}

struct CreatePostResultDTO: Decodable {
    let postId: Int
}

// MARK: - PUT /api/post/{postId} (Update)


struct UpdatePostResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CreatePostResultDTO   // server returns { postId }, same shape as create
    let timestamp: String
}

//게시글 좋아요 누르기
struct PostLikeDTO: Decodable {
    let isSuccess : Bool
    let code : String
    let message: String
    let result : String
    let timestamp :String
}

// 게시글 좋아요 취소
struct PostLikeDelete: Decodable {
    let isSuccess : Bool
    let code : String
    let message: String
    let result : String
    let timestamp :String
    
}


//게시글 북마크 추가


struct PostBookMarkDTO: Decodable {
    let isSuccess : Bool
    let code : String
    let message: String
    let result : String
    let timestamp :String
}
