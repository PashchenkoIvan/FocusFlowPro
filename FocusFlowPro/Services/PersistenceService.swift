//
//  PersistenceService.swift
//  FocusFlowPro
//
//  Created by Пащенко Иван on 04.02.2026.
//


import Foundation

enum PersistenceService {

    static func save<T: Codable>(_ object: T, to file: String) {
        let url = documentsURL.appendingPathComponent(file)
        if let data = try? JSONEncoder().encode(object) {
            try? data.write(to: url)
        }
    }

    static func load<T: Codable>(_ type: T.Type, from file: String) -> T? {
        let url = documentsURL.appendingPathComponent(file)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }

    private static var documentsURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}