//
//  StickyNote.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation

struct StickyNote: Identifiable, Codable, Equatable {
    var id: UUID
    var title: String
    var content: String
    var position: CGPoint
    var color: String
}
