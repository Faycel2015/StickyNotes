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
    
    func searchNotes(notes: [StickyNote]) {
        searchResults = notes.filter {
            $0.title.contains(searchText) || $0.content.contains(searchText)
        }
    }
}
