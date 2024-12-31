//
//  StickyNoteView.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import SwiftUI

struct StickyNoteView: View {
    @ObservedObject var viewModel: StickyNoteViewModel
    
    var body: some View {
        ZStack {
            ForEach(viewModel.notes) { note in
                VStack(alignment: .leading) {
                    Text(note.title)
                        .font(.system(size: Constants.noteTitleFontSize, weight: .bold))
                    Text(note.content)
                        .font(.system(size: Constants.noteContentFontSize))
                }
                .padding(Constants.notePadding)
                .background(Color(note.color))
                .cornerRadius(Constants.defaultCornerRadius)
                .shadow(color: Color.black.opacity(Double(Constants.defaultShadowOpacity)), radius: Constants.defaultShadowRadius, x: Constants.defaultShadowOffset.width, y: Constants.defaultShadowOffset.height)
                .position(note.position)
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
                .animation(.easeInOut(duration: Constants.noteAnimationDuration), value: note.position)
            }
        }
    }
}

#Preview {
    StickyNoteView(viewModel: StickyNoteViewModel())
}
