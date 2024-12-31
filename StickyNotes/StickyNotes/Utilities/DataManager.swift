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

    func save<T: Encodable>(_ object: T, with fileName: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            guard let url = getURL(for: fileName) else { return }
            try data.write(to: url)
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }

    func load<T: Decodable>(_ fileName: String) -> T? {
        guard let url = getURL(for: fileName), let data = try? Data(contentsOf: url) else { return nil }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
            return nil
        }
    }

    private func getURL(for fileName: String) -> URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDirectory?.appendingPathComponent(fileName)
    }
}
