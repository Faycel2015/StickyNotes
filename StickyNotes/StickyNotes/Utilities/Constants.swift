//
//  Constants.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import SwiftUI

struct Constants {
    // Default colors for sticky notes (defined as color names)
    static let noteColors: [String] = ["customYellow", "customBlue", "customGreen", "customPink"]
    
    // Default color for new sticky notes
    static let defaultNoteColor: String = "customYellow"
    
    // Default position for new notes
    static let defaultNotePosition = CGPoint(x: 50, y: 50)
    
    // Default timer duration (in seconds)
    static let defaultTimerDuration: TimeInterval = 60
    
    // Minimum and maximum durations for timers (in seconds)
    static let minTimerDuration: TimeInterval = 10
    static let maxTimerDuration: TimeInterval = 3600
    
    // Default size for sticky notes
    static let defaultNoteSize = CGSize(width: 200, height: 200)
    
    // Animation durations
    static let noteAnimationDuration: TimeInterval = 0.3
    static let draggingAnimationDuration: TimeInterval = 0.2
    
    // Default font sizes
    static let noteTitleFontSize: CGFloat = 18
    static let noteContentFontSize: CGFloat = 14
    
    // Default padding for notes
    static let notePadding: CGFloat = 10
    
    // Maximum number of notes allowed
    static let maxNotesAllowed = 100
    
    // File names for data persistence
    static let stickyNotesFileName = "StickyNotes"
    static let quickNotesFileName = "QuickNotes"
    static let timerBoardFileName = "TimerBoardData"
    
    // Search settings
    static let searchPlaceholderText = "Search notes..."
    
    // Quick note settings
    static let quickNoteBackgroundColor: String = "customLightBlue"
    
    // Timer board settings
    static let timerBoardBackgroundColor: String = "customLightGray"
    
    // Other UI constants
    static let defaultCornerRadius: CGFloat = 10
    static let defaultShadowRadius: CGFloat = 5
    static let defaultShadowOpacity: Float = 0.3
    static let defaultShadowOffset = CGSize(width: 0, height: 2)
    
    // Sound file names
    static let soundFileNames = [
        "add_note": "add_note_sound",
        "delete_note": "delete_note_sound",
        "drag_drop_note": "drag_drop_note_sound",
        "timer_start": "timer_start_sound",
        "timer_end": "timer_end_sound"
    ]
}
