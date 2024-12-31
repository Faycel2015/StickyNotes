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
            ZStack {
                Color("customLightGray")
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack(spacing: 20) {
                        Button(action: {
                            withAnimation {
                                stickyNoteViewModel.addNote()
                            }
                        }) {
                            Text("Add Sticky Note")
                                .padding()
                                .background(Color("customBlue"))
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
                                .background(Color("customGreen"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()

                    StickyNoteView(viewModel: stickyNoteViewModel)
                        .padding()

                    TimerBoardView(viewModel: timerBoardViewModel)
                        .padding()
                }
                .navigationTitle("Sticky Notes")
            }
        }
    }
}

#Preview {
    ContentView()
}
