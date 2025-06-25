//
//  SecondViewModel.swift
//  VINNY
//
//  Created by 홍지우 on 6/25/25.
//

import Foundation
import SwiftUI

class SecondViewModel: ObservableObject {
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    @Published var placeList: [PlaceInfo] = []
    
    @Published var isLoading: Bool = false
}

//api 함수는 걍 따로 빼는게 좋음
extension SecondViewModel {
    
    // 이거 밑에거 어케 하냐면 option+command+/
    /// 코드 상세정보 API
    /// - Parameter courseId: 요청할 코스 ID
    func getCourseDetail(courseId: Int) {
        
        isLoading = true
        
        let request = CourseDetailRequest(courseId: courseId)
        container.useCaseProvider.courseUseCase.request(target: .getCourseDetail(Request: request), decodingType: CourseDetailResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.placeList = response.placeInfos
                print("성공")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            isLoading = false
        }
    }
}
