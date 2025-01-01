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
    @StateObject var searchViewModel: SearchViewModel
    @StateObject var timerBoardViewModel = TimerBoardViewModel()

    init() {
        // Initialize the search view model with all notes from the sticky note view model
        let stickyNoteViewModel = StickyNoteViewModel()
        _searchViewModel = StateObject(wrappedValue: SearchViewModel(allNotes: stickyNoteViewModel.notes))
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color(Constants.timerBoardBackgroundColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    VStack {
                        SearchView(viewModel: searchViewModel)
                            .padding(.top)

                        TimerBoardView(viewModel: timerBoardViewModel)
                            .padding(.top)

                        StickyNoteView(viewModel: stickyNoteViewModel)
                        DraggingBoardView(viewModel: draggingBoardViewModel)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                HStack(spacing: 20) {
                    Button(action: {
                        withAnimation {
                            stickyNoteViewModel.addNote()
                        }
                    }) {
                        Text("Add Sticky Note")
                            .padding()
                            .background(Color(Constants.noteColors[1])) // Using customBlue
                            .foregroundColor(.white)
                            .cornerRadius(Constants.defaultCornerRadius)
                    }

                    Button(action: {
                        withAnimation {
                            stickyNoteViewModel.clearAllNotes()
                        }
                    }) {
                        Text("Clear All Notes")
                            .padding()
                            .background(Color.red) // Using red for the clear button
                            .foregroundColor(.white)
                            .cornerRadius(Constants.defaultCornerRadius)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
            }
            .navigationTitle("Sticky Notes")
        }
    }
}

#Preview {
    ContentView()
}
