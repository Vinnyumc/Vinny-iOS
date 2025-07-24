//
//  MapView.swift
//  VINNY
//
//  Created by 홍지우 on 7/10/25.
//

/// Map을 띄우고, ViewModel의 바인딩 상태를 보여주는 역할
/// ViewModel의 데이터를 바인딩 해 뷰를 자동 업데이트 함.
import SwiftUI
import MapKit
import UIKit

struct MapView: View {
    
    @Bindable private var locationManager = LocationManager.shared
    @State private var viewModel: MapViewModel = .init()

    var body: some View {
        ZStack(alignment: .top) {
            UIKitDarkMapView(viewModel: viewModel)
            
            MapTopView()
        }
        .sheet(item: $viewModel.selectedMarker) { marker in
            ShopInfoSheet(shopName: marker.title)
                .presentationDetents([.height(300)])
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .background(Color.backFillStatic)
    }
}

#Preview {
    MapView()
}
