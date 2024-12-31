//
//  DraggingBoardView.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import SwiftUI

struct DraggingBoardView: View {
    @ObservedObject var viewModel: DraggingBoardViewModel

    var body: some View {
        ZStack {
            ForEach(viewModel.draggedNotes) { draggedNote in
                Text("Dragging Note")
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(Constants.defaultCornerRadius)
                    .offset(draggedNote.offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                viewModel.updateDragging(noteID: draggedNote.id, offset: gesture.translation)
                            }
                            .onEnded { _ in
                                viewModel.endDragging(noteID: draggedNote.id)
                            }
                    )
                    .animation(.easeInOut(duration: Constants.draggingAnimationDuration), value: draggedNote.offset)
            }
        }
    }
}

#Preview {
    DraggingBoardView(viewModel: DraggingBoardViewModel())
}
