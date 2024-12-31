//
//  SearchView.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: StickyNoteViewModel
    @State private var searchText = ""

    var body: some View {
        VStack {
            TextField("Search...", text: $searchText)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)

            List {
                ForEach(viewModel.notes.filter { $0.title.contains(searchText) || $0.content.contains(searchText) }) { note in
                    VStack(alignment: .leading) {
                        Text(note.title)
                            .font(.headline)
                        Text(note.content)
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color(note.color))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .onTapGesture {
                        // Handle tap gesture
                        withAnimation {
                            print("Note tapped: \(note.title)")
                        }
                    }
                    .onLongPressGesture {
                        // Handle long press gesture
                        withAnimation {
                            viewModel.deleteNote(note: note)
                        }
                    }
                    .animation(.easeInOut(duration: Constants.noteAnimationDuration), value: note)
                }
            }
        }
    }
}

#Preview {
    SearchView(viewModel: StickyNoteViewModel())
}
