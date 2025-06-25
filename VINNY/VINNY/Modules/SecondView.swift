//
//  SecondView.swift
//  VINNY
//
//  Created by 홍지우 on 6/25/25.
//

import SwiftUI

struct SecondView: View {
    
    @EnvironmentObject var container: DIContainer
    
    @StateObject var viewModel: SecondViewModel
    
    let text: String
    
    init(container: DIContainer, text: String) {
        self.text = text
        self._viewModel = .init(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack{
            Text(text)
                .fontWeight(.bold)
            
            if viewModel.isLoading {
                ProgressView()
                    .tint(.blue)
            } else {
                scrollView
            }
        }
        .task {
            viewModel.getCourseDetail(courseId: 1)
        }
        .toolbar(.hidden) //자동으로 생성되는 네비게이션 바 사라짐
    }
    
    private var scrollView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.placeList, id: \.id) { place in
                    Text(place.placeName)
                }
            }
        }
    }
}
