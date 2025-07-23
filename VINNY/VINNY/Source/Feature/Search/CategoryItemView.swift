//
//  CategoryItemView.swift
//  VINNY
//
//  Created by 소민준 on 7/19/25.
//


import SwiftUI

struct CategoryItemView: View {
    let category: Category

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(category.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .clipped()
                .cornerRadius(10)

            Text("\(category.emoji) \(category.name)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 8)
                .padding(.leading, 8)
        }
    }
}