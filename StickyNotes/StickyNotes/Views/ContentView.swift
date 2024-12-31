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
    
    var body: some View {
        NavigationView {
            VStack {
                SearchView(viewModel: SearchViewModel(allNotes: stickyNoteViewModel.notes))
                    .padding()
                    .background(Color("lightgray")) // Use the custom color from the asset catalog
                    .cornerRadius(8)
                    .shadow(radius: 4)
                ScrollView {
                    StickyNoteView(viewModel: stickyNoteViewModel)
                    DraggingBoardView(viewModel: draggingBoardViewModel)
                    TimerBoardView(viewModel: timerBoardViewModel)
                    QuickNoteView(viewModel: quickNoteViewModel)
                }
                .padding()
                HStack {
                    Button(action: {
                        withAnimation {
                            stickyNoteViewModel.addNote()
                        }
                    }) {
                        Text("Add Sticky Note")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        withAnimation {
                            quickNoteViewModel.addQuickNote()
                        }
                    }) {
                        Text("Add Quick Note")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .background(Color("lightgray"))
            .navigationTitle("Sticky Notes")
        }
    }
}

#Preview {
    ContentView()
}
