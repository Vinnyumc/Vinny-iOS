//
//  PostUploadViewModel.swift
//  VINNY
//
//  Created by 홍지우 on 7/20/25.
//

import Foundation

final class PostUploadViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var brand: String = ""
    @Published var shoptag: String = ""
}
