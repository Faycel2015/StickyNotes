//
//  ContentView.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var stickyNoteViewModel = StickyNoteViewModel()
    @StateObject var draggingBoardViewModel = DraggingBoardViewModel()
    @StateObject var timerBoardViewModel = TimerBoardViewModel()
    @StateObject var quickNoteViewModel = QuickNoteViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            StickyNoteView(viewModel: stickyNoteViewModel)
            DraggingBoardView(viewModel: draggingBoardViewModel)
            TimerBoardView(viewModel: timerBoardViewModel)
            QuickNoteView(viewModel: quickNoteViewModel)
            SearchView(viewModel: searchViewModel)
        }
    }
}

#Preview {
    ContentView()
}
