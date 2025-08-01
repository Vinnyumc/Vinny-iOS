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
        case .BrandView:
            BrandView(container: container)
                .environmentObject(container)
        case .CategoryView:
            CategoryView(container: container)
                .environmentObject(container)
        case .ClothTypeView:
            ClothTypeView(container: container)
                .environmentObject(container)
        case .LocationView:
            LocationView(container: container)
                .environmentObject(container)
        case .SettingView:
            SettingView(container: container)
                .environmentObject(container)
        case .TopsideProfileView:
            TopsideProfileView(container: container)
                .environmentObject(container)
        case .MyProfileView:
            MyProfileView(container: container)
                .environmentObject(container)
        case .TasteResetView:
            TasteResetView(container: container)
                .environmentObject(container)
        }
    }
    
}
