//
//  TimerBoardViewModel.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation
import Combine
import AVFoundation

class TimerBoardViewModel: ObservableObject {
    @Published var timers: [TimerBoardData] = []
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        loadTimers()
    }
    
    func loadTimers() {
        if let loadedTimers: [TimerBoardData] = DataManager.shared.load(Constants.timerBoardFileName) {
            timers = loadedTimers
        } else {
            timers = [] // Initialize with empty array if no saved timers
        }
    }
    
    func saveTimers() {
        DataManager.shared.save(timers, with: Constants.timerBoardFileName)
    }
    
    func addTimer() {
        let newTimer = TimerBoardData(
            id: UUID(),
            timerTitle: "New Timer",
            duration: Constants.defaultTimerDuration,
            isRunning: false)
        timers.append(newTimer)
        saveTimers()
        playSound(named: Constants.soundFileNames["timer_start"]!)
    }
    
    func deleteTimer(timer: TimerBoardData) {
        timers.removeAll { $0.id == timer.id }
        saveTimers()
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
