//
//  DraggedNote.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation
import CoreGraphics

struct DraggedNote: Identifiable {
    var id: UUID
    var offset: CGSize
}
