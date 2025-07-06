//
//  NavigationRoutingView.swift
//  VINNY
//
//  Created by 홍지우 on 6/25/25.
//

import Foundation
import SwiftUI

struct NavigationRoutingView: View {
    
    @EnvironmentObject var container: DIContainer
    
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .VinnyTabView:
            VinnyTabView(container: container)
                .environmentObject(container)
        case .LoginView:
            LoginView(container: container)
                .environmentObject(container)
        }
    }
    
}
