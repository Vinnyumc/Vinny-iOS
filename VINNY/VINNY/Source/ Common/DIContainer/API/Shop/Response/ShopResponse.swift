//
//  ShopResponse.swift
//  VINNY
//
//  Created by 소민준 on 8/12/25.
//

import Foundation

//가게 상세조회 api

struct ShopInfoResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ShopResultDTO      //
    let timestamp: String
}

struct ShopResultDTO: Decodable {
    let reviewId: Int
    let title: String
    let content: String
    let userName: String
    let elapsedTime: String        // ← 철자 'elapsed'로 통일
    let imageUrls: [String]?
}

//홈뷰에서 랭킹으로 가게 조회 

struct ShopByRankingDTO: Decodable {
    let isSuccess : Bool
    let code : String
    let message: String
    let result : [ShopByRankingResultDTO]
    let timestamp: String
}

struct ShopByRankingResultDTO: Decodable {
    
    let shopId : Int
    let name : String
    let address : String
    let region : String
    let tags : [String]
    let thumbnailUrl:String
}

struct ShopInfoResultDTO: Decodable{
    
    let reviewID : Int
    let title : String
    let content :String
    let userName :String
    let elaspedTime: String
    let imageUrls :[String]?
    
}
// MARK: - Shop Detail (GET /api/shop/{shopId})

struct ShopImageDTO: Decodable {
    let url: String
    let main: Bool
}

struct ShopDetailResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ShopDetailDTO
    let timestamp: String
}

struct ShopDetailDTO: Decodable {
    let id: Int
    let name: String
    let intro: String?
    let description: String?
    let status: String?
    let openTime: String?
    let closeTime: String?
    let instagram: String?
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let region: String?
    let images: [ShopImageDTO]?
    let logoImage: String
    let shopVintageStyleList: [VintageStyleDTO]?

    private enum CodingKeys: String, CodingKey {
        case id, name, intro, description, status, openTime, closeTime, instagram, address, latitude, longitude, region, images, shopVintageStyleList
    }

    private struct ImageObj: Decodable {
        let url: String
        private enum CodingKeys: String, CodingKey { case url, imageUrl, src }
        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            if let v = try c.decodeIfPresent(String.self, forKey: .url) { url = v; return }
            if let v = try c.decodeIfPresent(String.self, forKey: .imageUrl) { url = v; return }
            if let v = try c.decodeIfPresent(String.self, forKey: .src) { url = v; return }
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath,
                debugDescription: "No url/imageUrl/src in image object"))
        }
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(Int.self, forKey: .id)
        name = try c.decode(String.self, forKey: .name)
        intro = try c.decodeIfPresent(String.self, forKey: .intro)
        description = try c.decodeIfPresent(String.self, forKey: .description)
        status = try c.decodeIfPresent(String.self, forKey: .status)
        openTime = try c.decodeIfPresent(String.self, forKey: .openTime)
        closeTime = try c.decodeIfPresent(String.self, forKey: .closeTime)
        instagram = try c.decodeIfPresent(String.self, forKey: .instagram)
        address = try c.decodeIfPresent(String.self, forKey: .address)
        latitude = try c.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try c.decodeIfPresent(Double.self, forKey: .longitude)
        region = try c.decodeIfPresent(String.self, forKey: .region)

        if let strings = try? c.decode([String].self, forKey: .images) {
            images = strings
        } else if let objs = try? c.decode([ImageObj].self, forKey: .images) {
            images = objs.map { $0.url }
        } else {
            images = nil
        }

        shopVintageStyleList = try c.decodeIfPresent([VintageStyleDTO].self, forKey: .shopVintageStyleList)
    }
}

struct VintageStyleDTO: Decodable, Hashable {
    let id: Int
    let vintageStyleName: String
}

//홈에 취향 저격 가게 
struct ShopForYouResponseDTO: Decodable {
    let id: Int
    let name: String
    let openTime: String?
    let closeTime: String?
    let instagram: String?
    let address: String?
    let logoImage: String
    let images: ShopImageDTO       // single image object
    let shopVintageStyleList: [VintageStyleDTO]?
}


// 가게 찜
struct ShopLoveResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ShopResultDTO?
    let timestamp: String
}


struct ShopLoveCancelResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String?             // ← 문자열!
    let timestamp: String
}
