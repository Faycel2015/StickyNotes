//
//  ContentView.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var stickyNoteViewModel = StickyNoteViewModel()
    @StateObject var quickNoteViewModel = QuickNoteViewModel()
    @StateObject var timerBoardViewModel = TimerBoardViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(stickyNoteViewModel.notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(note.content)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color(note.color))
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
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
                            .cornerRadius(10)
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
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                // Add TimerBoardView to ContentView
                TimerBoardView(viewModel: timerBoardViewModel)
                    .padding()
            }
            .background(Color(Constants.timerBoardBackgroundColor)) // Ensure background is set to custom light gray
            .navigationTitle("Sticky Notes")
        }
    }
}

#Preview {
    ContentView()
}
