//
//  SearchView.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            TextField("Search...", text: $viewModel.searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            List(viewModel.searchResults) { note in
                VStack(alignment: .leading) {
                    Text(note.title)
                        .font(.headline)
                    Text(note.content)
                        .font(.subheadline)
                }
                .padding()
                .background(note.color.toColor) // Use the toColor computed property
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
    }
}

//#Preview {
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide some sample notes for preview
        let sampleNotes = [
            StickyNote(id: UUID(), title: "Note 1", content: "This is the first note", position: .zero, color: "yellow"),
            StickyNote(id: UUID(), title: "Note 2", content: "This is the second note", position: .zero, color: "blue"),
        ]
        SearchView(viewModel: SearchViewModel(allNotes: sampleNotes))
    }
}

