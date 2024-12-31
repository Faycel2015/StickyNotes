//
//  DataManager.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    func save<T: Encodable>(_ object: T, with fileName: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent(fileName)
                try data.write(to: fileURL)
            }
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func load<T: Decodable>(_ fileName: String) -> T? {
        let decoder = JSONDecoder()
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            if let data = try? Data(contentsOf: fileURL) {
                do {
                    let object = try decoder.decode(T.self, from: data)
                    return object
                } catch {
                    print("Error loading data: \(error.localizedDescription)")
                }
            }
        }
        return nil
    }
}
