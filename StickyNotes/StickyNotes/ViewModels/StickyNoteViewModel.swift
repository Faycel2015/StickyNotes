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
        } else {
            notes = [] // Initialize with empty array if no saved notes
        }
    }

    func saveNotes() {
        DataManager.shared.save(notes, with: Constants.stickyNotesFileName)
    }

    func addNote() {
        let newNote = StickyNote(
            id: UUID(),
            title: "New Note",
            content: "This is a new note.",
            position: Constants.defaultNotePosition,
            color: Constants.noteColors.randomElement() ?? Constants.defaultNoteColor
        )
        notes.append(newNote)
        saveNotes()
        playSound(named: Constants.soundFileNames["add_note"]!)
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
