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
        GeometryReader { geometry in
            ZStack {
                ForEach(viewModel.notes) { note in
                    StickyNoteCard(note: note, viewModel: viewModel)
                        .position(note.position)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    withAnimation {
                                        let newPosition = CGPoint(
                                            x: min(max(note.position.x + value.translation.width, 0), geometry.size.width),
                                            y: min(max(note.position.y + value.translation.height, 0), geometry.size.height)
                                        )
                                        viewModel.updateNotePosition(note: note, position: newPosition)
                                    }
                                }
                                .onEnded { value in
                                    withAnimation {
                                        let newPosition = CGPoint(
                                            x: min(max(note.position.x + value.translation.width, 0), geometry.size.width),
                                            y: min(max(note.position.y + value.translation.height, 0), geometry.size.height)
                                        )
                                        viewModel.updateNotePosition(note: note, position: newPosition)
                                    }
                                }
                        )
                }
            }
        }
    }
}

struct StickyNoteCard: View {
    @State var note: StickyNote
    @ObservedObject var viewModel: StickyNoteViewModel

    var body: some View {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    TextField("Title", text: Binding(
                        get: { note.title },
                        set: { newTitle in viewModel.updateNoteTitle(note: note, title: newTitle) }
                    ))
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .padding(5)

                    TextEditor(text: Binding(
                        get: { note.content },
                        set: { newContent in viewModel.updateNoteContent(note: note, content: newContent) }
                    ))
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .frame(height: geometry.size.height * 0.6)
                    .padding(5)

                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.deleteNote(note: note)
                        }) {
                            Text("Delete")
                                .foregroundColor(.red)
                        }
                        .padding(5)
                    }
                }
                .padding()
                .background(Color(note.color))
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3)
        }
    }

#Preview {
    StickyNoteView(viewModel: StickyNoteViewModel())
}
