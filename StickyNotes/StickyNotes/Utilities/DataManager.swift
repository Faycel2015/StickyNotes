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
    
    func save<T: Codable>(_ data: T, with fileName: String) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            try data.write(to: url)
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    func load<T: Codable>(_ fileName: String) -> T? {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
