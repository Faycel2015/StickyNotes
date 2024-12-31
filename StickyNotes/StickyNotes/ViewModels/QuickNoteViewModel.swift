//
//  QuickNoteViewModel.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation
import Combine
import AVFoundation

class QuickNoteViewModel: ObservableObject {
    @Published var quickNotes: [StickyNote] = []
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        loadQuickNotes()
    }
    
    func loadQuickNotes() {
        if let loadedQuickNotes: [StickyNote] = DataManager.shared.load(Constants.quickNotesFileName) {
            quickNotes = loadedQuickNotes
        } else {
            quickNotes = []
        }
    }
    
    func saveQuickNotes() {
        DataManager.shared.save(quickNotes, with: Constants.quickNotesFileName)
    }
    
    func addQuickNote() {
        let newQuickNote = StickyNote(
            id: UUID(),
            title: "Quick Note",
            content: "",
            position: Constants.defaultNotePosition,
            color: Constants.quickNoteBackgroundColor.description)
        quickNotes.append(newQuickNote)
        saveQuickNotes()
        playSound(named: Constants.soundFileNames["add_note"]!)
    }
    
    func deleteQuickNote(note: StickyNote) {
        quickNotes.removeAll { $0.id == note.id }
        saveQuickNotes()
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
