//
//  DIContainer.swift
//  VINNY
//
//  Created by 홍지우 on 6/25/25.
//

import SwiftUI

class DIContainer: ObservableObject {
    var navigationRouter: NavigationRoutable
    
    var useCaseProvider: UseCaseProvider
    
    init() {
        self.navigationRouter = NavigationRouter()
        self.useCaseProvider = UseCaseProvider()
    }
}
