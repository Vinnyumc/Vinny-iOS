//  서버 주소 및 각 API의 Endpoint 경로를 한 곳에서 관리하는 파일.
//  API 경로가 분산되지 않도록 중앙 집중화하여 유지보수성을 높이기 위한 목적.

import Foundation

public struct API {
    
    /// 전체 서버의 공통 Base URL
    /// 각 Feature API의 path는 이 baseURL에 붙여서 구성
    public static let baseURL = "https://example.com"

    // MARK: - 주요 기능별 Endpoint 경로
    
    /// 로그인 관련 API
    static let loginURL = "\(baseURL)/auth/login"
    
    /// 유저 정보 관련 API
    static let userURL = "\(baseURL)/users"
    
    /// 게시글 관련 API
    static let postURL = "\(baseURL)/posts"
    
    static let courseURL = "\(baseURL)/courses"
}

