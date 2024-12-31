//
//  QuickNoteViewModel.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation
import SwiftUI

class QuickNoteViewModel: ObservableObject {
    @Published var quickNotes: [StickyNote] = []

    init() {
        loadNotes()
    }

    func loadNotes() {
        if let loadedNotes: [StickyNote] = DataManager.shared.load(Constants.quickNotesFileName) {
            quickNotes = loadedNotes
        } else {
            quickNotes = []
        }
    }

    func saveNotes() {
        DataManager.shared.save(quickNotes, with: Constants.quickNotesFileName)
    }

    func addQuickNote() {
        let newNote = StickyNote(
            id: UUID(),
            title: "New Quick Note",
            content: "This is a new quick note.",
            position: Constants.defaultNotePosition,
            color: Constants.noteColors.randomElement() ?? Constants.defaultNoteColor
        )
        quickNotes.append(newNote)
        saveNotes()
    }

    func deleteQuickNote(note: StickyNote) {
        quickNotes.removeAll { $0.id == note.id }
        saveNotes()
    }
}
