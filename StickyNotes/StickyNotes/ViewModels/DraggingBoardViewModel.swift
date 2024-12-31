//
//  DraggingBoardViewModel.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation
import Combine
import CoreGraphics
import AVFoundation

class DraggingBoardViewModel: ObservableObject {
    @Published var draggedNotes: [DraggedNote] = []
    private var audioPlayer: AVAudioPlayer?

    func startDragging(note: StickyNote, offset: CGSize) {
        let draggedNote = DraggedNote(id: note.id, offset: offset)
        draggedNotes.append(draggedNote)
    }

    func updateDragging(noteID: UUID, offset: CGSize) {
        if let index = draggedNotes.firstIndex(where: { $0.id == noteID }) {
            draggedNotes[index].offset = offset
        }
    }

    func endDragging(noteID: UUID) {
        draggedNotes.removeAll { $0.id == noteID }
        playSound(named: Constants.soundFileNames["drag_drop_note"]!)
    }

    private func playSound(named soundName: String) {
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}
