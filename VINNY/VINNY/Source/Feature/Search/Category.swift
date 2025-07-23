//
//  Category.swift
//  VINNY
//
//  Created by 소민준 on 7/19/25.
//


struct Category: Identifiable {
    let id: String
    let name: String
    let emoji: String
    let imageName: String

    static let sampleList: [Category] = [
        Category(id: "military", name: "밀리터리", emoji: "🪖", imageName: "military"),
        Category(id: "amekaji", name: "아메카지", emoji: "🇺🇸", imageName: "amekaji"),
        Category(id: "street", name: "스트릿", emoji: "🧢", imageName: "street"),
        Category(id: "outdoor", name: "아웃도어", emoji: "🥾", imageName: "outdoor"),
        Category(id: "casual", name: "캐주얼", emoji: "👕", imageName: "casual"),
        Category(id: "denim", name: "데님", emoji: "👖", imageName: "denim"),
        Category(id: "highend", name: "하이엔드", emoji: "🎩", imageName: "highend"),
        Category(id: "workwear", name: "워크웨어", emoji: "🏗️", imageName: "workwear"),
        Category(id: "leather", name: "레더", emoji: "🧥", imageName: "leather"),
        Category(id: "sporty", name: "스포티", emoji: "🎾", imageName: "sporty"),
        Category(id: "western", name: "웨스턴", emoji: "🤠", imageName: "western")
    ]
}
