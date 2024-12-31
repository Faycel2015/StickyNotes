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
            TextField(Constants.searchPlaceholderText, text: $viewModel.searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: viewModel.searchText) { newValue, oldValue in
                    withAnimation(.easeInOut(duration: Constants.noteAnimationDuration)) {
                        viewModel.searchNotes()
                    }
            }
            
            List(viewModel.searchResults) { note in
                VStack(alignment: .leading) {
                    Text(note.title)
                        .font(.headline)
                    Text(note.content)
                        .font(.subheadline)
                }
                .padding()
                .background(Color(note.color))
                .cornerRadius(Constants.defaultCornerRadius)
                .shadow(radius: Constants.defaultShadowRadius)
            }
        }
        .padding()
        .animation(.easeInOut(duration: Constants.noteAnimationDuration), value: viewModel.searchResults)
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(allNotes: [StickyNote]()))
}
