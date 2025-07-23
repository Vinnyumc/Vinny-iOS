//
//  SearchViewModel.swift
//  VINNY
//
//  Created by 소민준 on 7/19/25.
//

import Foundation
import Combine

enum SearchViewState {
    case showingDefault
    case searching(String)
}

class SearchViewModel: ObservableObject {
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                state = .showingDefault
            } else {
                state = .searching(searchText)
                performSearch(for: searchText)
            }
        }
    }

    @Published var state: SearchViewState = .showingDefault
    @Published var recentKeywords: [String] = ["최근 검색어1", "최근 검색어2", "최근 검색어3"]
    @Published var searchResults: [Shop] = []

    func removeKeyword(_ keyword: String) {
        recentKeywords.removeAll { $0 == keyword }
    }

    func clearAllKeywords() {
        recentKeywords.removeAll()
    }

    func performSearch(for keyword: String) {
        searchResults = Shop.dummyList.filter {
            $0.name.localizedCaseInsensitiveContains(keyword)
        }
    }
}
