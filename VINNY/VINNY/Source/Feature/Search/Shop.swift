//
//  Shop.swift
//  VINNY
//
//  Created by 소민준 on 7/19/25.
//
import SwiftUI

struct Shop: Identifiable {
    let id = UUID()
    let name: String
    let address: String

    static let dummyList: [Shop] = [
        Shop(name: "망원빈티지", address: "서울특별시 마포구 망원동 376-6"),
        Shop(name: "홍대빈티지", address: "서울 마포구 와우산로 21길 16"),
    ]
}
