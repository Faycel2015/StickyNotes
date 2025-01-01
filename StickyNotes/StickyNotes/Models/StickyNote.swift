//
//  StickyNote.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation
import SwiftUI

struct StickyNote: Identifiable, Codable, Equatable {
    var id: UUID
    var title: String
    var content: String
    var position: CGPoint
    var color: String
}

extension String {
    var toColor: Color {
        switch self.lowercased() {
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "purple":
            return .purple
        // Add more colors as needed
        default:
            return .gray // Default color if no match is found
        }
    }
}
