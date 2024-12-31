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
                StickyNoteCard(note: note, viewModel: viewModel)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation {
                                    viewModel.updateNotePosition(note: note, position: value.location)
                                }
                            }
                    )
            }
        }
    }
}

struct StickyNoteCard: View {
    @State var note: StickyNote
    @ObservedObject var viewModel: StickyNoteViewModel

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Title", text: Binding(
                get: { note.title },
                set: { newTitle in updateNoteTitle(newTitle) }
            ))
            .font(.system(size: Constants.noteTitleFontSize, weight: .bold))
            .foregroundColor(.black)

            TextEditor(text: Binding(
                get: { note.content },
                set: { newContent in updateNoteContent(newContent) }
            ))
            .font(.system(size: Constants.noteContentFontSize))
            .foregroundColor(.black)
            .frame(height: 100)
            .background(Color.clear)
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

    private func updateNoteTitle(_ newTitle: String) {
        viewModel.updateNoteTitle(note: note, title: newTitle)
        note.title = newTitle
    }

    private func updateNoteContent(_ newContent: String) {
        viewModel.updateNoteContent(note: note, content: newContent)
        note.content = newContent
    }
}

#Preview {
    StickyNoteView(viewModel: StickyNoteViewModel())
}
