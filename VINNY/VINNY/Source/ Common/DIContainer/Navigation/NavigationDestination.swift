//
//  NavigationDestination.swift
//  VINNY
//
//  Created by 홍지우 on 6/25/25.
//

import Foundation

enum NavigationDestination: Hashable {
    
    case VinnyTabView
    case LoginView
    case SearchView
    
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.VinnyTabView, .VinnyTabView):
              return true
        case (.LoginView, .LoginView):
              return true
        case (.SearchView, .SearchView):
                return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .VinnyTabView:
            hasher.combine("VinnyTabView")
        case .LoginView:
            hasher.combine("LoginView")
        case .SearchView:
            hasher.combine("SearchView")
        }
    }
}
