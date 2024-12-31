//
//  SearchViewModel.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [StickyNote] = []
    var allNotes: [StickyNote] = []

    init(allNotes: [StickyNote]) {
        self.allNotes = allNotes
        self.searchResults = allNotes
    }
    
    func searchNotes() {
        if searchText.isEmpty {
            searchResults = allNotes
        } else {
            searchResults = allNotes.filter {
                $0.title.contains(searchText) || $0.content.contains(searchText)
            }
        }
    }
}
