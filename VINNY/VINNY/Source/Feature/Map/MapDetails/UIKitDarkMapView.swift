//
//  UIKitDarkMapView.swift
//  VINNY
//
//  Created by 홍지우 on 7/19/25.
//

import SwiftUI
import MapKit

struct UIKitDarkMapView: UIViewRepresentable {
    @Bindable var viewModel: MapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.overrideUserInterfaceStyle = .dark
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        
        // 카메라 초기 위치 설정
        if let center = viewModel.currentMapCenter {
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: false)
        }
        
        // 마커 추가
        for marker in viewModel.makers {
            let annotation = MKPointAnnotation()
            annotation.coordinate = marker.coordinate
            annotation.title = marker.title
            mapView.addAnnotation(annotation)
        }
        
        return mapView
    }
    
    // 마커 업데이트
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations.filter { !($0 is MKUserLocation) })
        
        for marker in viewModel.makers {
            let annotation = MKPointAnnotation()
            annotation.coordinate = marker.coordinate
            annotation.title = marker.title
            uiView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: viewModel)
    }

    // marker 또는 커스텀 annotation 처리
    class Coordinator: NSObject, MKMapViewDelegate {
        var viewModel: MapViewModel
        
        init(viewModel: MapViewModel) {
            self.viewModel = viewModel
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation else { return }

            if let matched = viewModel.makers.first(where: {
                $0.coordinate.latitude == annotation.coordinate.latitude &&
                $0.coordinate.longitude == annotation.coordinate.longitude
            }) {
                DispatchQueue.main.async {
                    print("✅ Marker selected: \(matched.title)")
                    self.viewModel.selectedMarker = matched
                }
            }
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let identifier = "CustomMarker"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            } else {
                annotationView?.annotation = annotation
            }
            
            // 해당 annotation에 맞는 Marker 찾기
            guard let matched = viewModel.makers.first(where: {
                $0.coordinate.latitude == annotation.coordinate.latitude &&
                $0.coordinate.longitude == annotation.coordinate.longitude
            }) else {
                return nil
            }

            // SwiftUI View 생성
            let hosting = UIHostingController(rootView: LocationMapAnnotationView(category: matched.category))
            hosting.view.backgroundColor = .clear
            
            let targetSize = hosting.view.intrinsicContentSize
            hosting.view.bounds = CGRect(origin: .zero, size: targetSize)
            
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            let image = renderer.image { _ in
                hosting.view.drawHierarchy(in: hosting.view.bounds, afterScreenUpdates: true)
            }
            
            annotationView?.image = image
            annotationView?.canShowCallout = false
            
            return annotationView
        }

    }
}

