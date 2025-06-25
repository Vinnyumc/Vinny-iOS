import Foundation

protocol UseCaseProtocol {
    
    var courseUseCase: DefaultNetworkManager<CoursesAPITarget> { get set }
    
    //var reviewUseCase: DefaultNetworkManager<ReviewAPITarget> { get set }
    
}

class UseCaseProvider: UseCaseProtocol{
    var courseUseCase: DefaultNetworkManager<CoursesAPITarget>
    
//    var reviewUseCase: DefaultNetworkManager<ReviewAPITarget>
    
    init() {
        courseUseCase = DefaultNetworkManager<CoursesAPITarget>(stub: true) //stub: true 적으면 더미 데이터로 가져옴
//        reviewUseCase = DefaultNetworkManager<ReviewAPITarget>()
    }
}

