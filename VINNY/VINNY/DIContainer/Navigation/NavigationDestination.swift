//
//  NavigationDestination.swift
//  VINNY
//
//  Created by 홍지우 on 6/25/25.
//

import Foundation

enum NavigationDestination: Hashable {
    
    case secondView(text: String)
    
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.secondView(let lhsText), .secondView(let rhsText)):
              return lhsText == rhsText
//        case (.secondView2, secondView2):
//            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .secondView(text: let text):
            hasher.combine("secondView")
            hasher.combine(text)
        }
    }
}
