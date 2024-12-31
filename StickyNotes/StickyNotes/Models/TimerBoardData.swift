//
//  TimerBoardData.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation

struct TimerBoardData: Identifiable, Codable, Equatable {
    var id: UUID
    var timerTitle: String
    var duration: TimeInterval
    var isRunning: Bool
}
