//
//  MapViewModel.swift
//  VINNY
//
//  Created by 홍지우 on 7/12/25.
//

/// 지도에서 보여줄 위치를 결정하는 MapCameraPosition, MKCoordinateRegion 등을 관리 함
import SwiftUI
import MapKit
import Observation

@MainActor
@Observable
final class MapViewModel {
    
    /// func updateCamera(to coordinate: CLLocationCoordinate2D) : 지도 카메라 위치를 특정 좌표로 이동시키는 매서드
    /// func updateFromLocation(_ location: CLLocation?) : CLLocation 객체가 전달되었을 때, 안전하게 좌표를 추출해서 카메라 위치를 업데이트 함
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var currentMapCenter: CLLocationCoordinate2D?
    
    // 마커
    var makers: [Marker] = [
        .init(coordinate: .init(latitude: 37.5551033, longitude: 126.9221464), title: "루트 홍대", category: .casual),
        .init(coordinate: .init(latitude: 37.5521997, longitude: 126.9209760), title: "도조&만쥬 빈티지샵", category: .street)
    ]
    
    var selectedMarker: Marker? = nil
    
    
    init() {
        if let location = LocationManager.shared.currentLocation {
            self.currentMapCenter = location.coordinate
        }
    }
}
