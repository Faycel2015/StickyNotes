//
//  QuickNoteView.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import SwiftUI

struct QuickNoteView: View {
    @ObservedObject var viewModel: QuickNoteViewModel
    
    var body: some View {
        List(viewModel.quickNotes) { note in
            noteView(for: note)
        }
        .navigationTitle("Quick Notes")
        .toolbar {
            Button(action: {
                withAnimation(.easeInOut(duration: Constants.noteAnimationDuration)) {
                    viewModel.addQuickNote()
                }
            }) {
                Image(systemName: "plus")
            }
        }
        .animation(.easeInOut(duration: Constants.noteAnimationDuration), value: viewModel.quickNotes)
    }
    
    private func noteView(for note: StickyNote) -> some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.headline)
            Text(note.content)
                .font(.subheadline)
        }
        .padding()
        .background(Color(Constants.quickNoteBackgroundColor))
        .cornerRadius(Constants.defaultCornerRadius)
        .shadow(radius: Constants.defaultShadowRadius)
        .onTapGesture {
            // Handle tap gesture
            withAnimation {
                print("Quick note tapped: \(note.title)")
            }
        }
        .onLongPressGesture {
            // Handle long press gesture
            withAnimation {
                viewModel.deleteQuickNote(note: note)
            }
        }
    }
}

#Preview {
    QuickNoteView(viewModel: QuickNoteViewModel())
}
