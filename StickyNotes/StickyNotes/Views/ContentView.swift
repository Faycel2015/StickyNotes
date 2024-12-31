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
    @StateObject var draggingBoardViewModel = DraggingBoardViewModel()

    var body: some View {
        NavigationView {
            VStack {
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
                            quickNoteViewModel.addQuickNote()
                        }
                    }) {
                        Text("Add Quick Note")
                            .padding()
                            .background(Color(Constants.noteColors[2])) // Using customGreen
                            .foregroundColor(.white)
                            .cornerRadius(Constants.defaultCornerRadius)
                    }
                }
                .padding()

                ZStack {
                    Color(Constants.timerBoardBackgroundColor)
                        .edgesIgnoringSafeArea(.all)

                    StickyNoteView(viewModel: stickyNoteViewModel)
                    QuickNoteView(viewModel: quickNoteViewModel)
                    DraggingBoardView(viewModel: draggingBoardViewModel)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Sticky Notes")
        }
    }
}

#Preview {
    ContentView()
}
