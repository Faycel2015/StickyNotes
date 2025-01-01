//
//  StickyNoteViewModel.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation
import SwiftUI
import AVFoundation

class StickyNoteViewModel: ObservableObject {
    @Published var notes: [StickyNote] = []
    private var audioPlayer: AVAudioPlayer?

    init() {
        loadNotes()
    }

    func loadNotes() {
        if let loadedNotes: [StickyNote] = DataManager.shared.load(Constants.stickyNotesFileName) {
            notes = loadedNotes
        }
    }

    func saveNotes() {
        DataManager.shared.save(notes, with: Constants.stickyNotesFileName)
    }

    func addNote() {
        let content = "This is a new note."
        let title = createTitle(from: content)
        let newNote = StickyNote(
            id: UUID(),
            title: title,
            content: content,
            position: calculateNewNotePosition(),
            color: Constants.noteColors.randomElement() ?? "gray"
        )
        notes.append(newNote)
        saveNotes()
        playSound(named: Constants.soundFileNames["add_note"]!)
    }

    private func calculateNewNotePosition() -> CGPoint {
        let xOffset: CGFloat = 30
        let yOffset: CGFloat = 30
        var newPosition = Constants.defaultNotePosition

        // Calculate a new position to avoid overlap
        for _ in notes {
            newPosition.x += xOffset
            newPosition.y += yOffset
            if newPosition.x + Constants.defaultNoteSize.width > UIScreen.main.bounds.width {
                newPosition.x = Constants.defaultNotePosition.x
            }
            if newPosition.y + Constants.defaultNoteSize.height > UIScreen.main.bounds.height {
                newPosition.y = Constants.defaultNotePosition.y
            }
        }

        return newPosition
    }

    func updateNoteTitle(note: StickyNote, title: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].title = title
            saveNotes()
        }
    }

    func updateNoteContent(note: StickyNote, content: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].content = content
            notes[index].title = createTitle(from: content)
            saveNotes()
        }
    }

    func updateNotePosition(note: StickyNote, position: CGPoint) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].position = position
            saveNotes()
            playSound(named: Constants.soundFileNames["drag_drop_note"]!)
        }
    }

    func deleteNote(note: StickyNote) {
        notes.removeAll { $0.id == note.id }
        saveNotes()
        playSound(named: Constants.soundFileNames["delete_note"]!)
    }

    func clearAllNotes() {
        notes.removeAll()
        DataManager.shared.clearAllNotes()
        playSound(named: Constants.soundFileNames["delete_note"]!)
    }

    private func createTitle(from content: String) -> String {
        let words = content.split(separator: " ")
        return words.prefix(5).joined(separator: " ")
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
