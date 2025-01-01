//
//  DataManager.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    private init() {}

    // Generic save method
    func save<T: Encodable>(_ object: T, with fileName: String) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            try data.write(to: url, options: .atomicWrite)
        } catch {
            print("Failed to save \(fileName): \(error.localizedDescription)")
        }
    }

    // Generic load method
    func load<T: Decodable>(_ fileName: String) -> T? {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }

    // Method to clear all saved notes
    func clearAllNotes() {
        let fileNames = [Constants.stickyNotesFileName, Constants.quickNotesFileName, Constants.timerBoardFileName]
        for fileName in fileNames {
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            do {
                try FileManager.default.removeItem(at: url)
                print("\(fileName) cleared successfully.")
            } catch {
                print("Failed to clear \(fileName): \(error.localizedDescription)")
            }
        }
    }

    // Helper method to get documents directory
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
