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
        VStack {
            ForEach(viewModel.quickNotes) { note in
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
                .onTapGesture {
                    // Handle tap gesture
                    withAnimation {
                        print("Note tapped: \(note.title)")
                    }
                }
                .onLongPressGesture {
                    // Handle long press gesture
                    withAnimation {
                        viewModel.deleteQuickNote(note: note)
                    }
                }
                .animation(.easeInOut(duration: Constants.noteAnimationDuration), value: note)
            }
        }
    }
}

#Preview {
    QuickNoteView(viewModel: QuickNoteViewModel())
}
