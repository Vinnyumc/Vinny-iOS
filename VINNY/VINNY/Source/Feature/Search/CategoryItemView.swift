//
//  CategoryItemView.swift
//  VINNY
//
//  Created by 소민준 on 7/19/25.
//


import SwiftUI

struct CategoryItemView: View {
    let categoryItem: CategoryItem

    private let hPadding: CGFloat = 16
    private let gap: CGFloat = 8

    private var itemWidth: CGFloat {
        let totalWidth: CGFloat = UIScreen.main.bounds.width
        return (totalWidth - (hPadding * 2) - (gap * 2)) / 3.0
    }
    
    var body: some View {
        ZStack {
            Image(categoryItem.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: itemWidth, height: itemWidth)
                .clipped()
                .overlay(
                    Color.black.opacity(0.32)
                )

            Text("\(categoryItem.emoji) \(categoryItem.name)")
                .font(.suit(.semibold, size: 13))
                .foregroundStyle(.white)
                .shadow(radius: 1)
                .multilineTextAlignment(.center)
        }
        .frame(width: itemWidth, height: itemWidth)
        .cornerRadius(8)
    }
}
