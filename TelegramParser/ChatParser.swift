//
//  ChatParser.swift
//  TelegramParser
//
//  Created by Michael Pace on 12/29/22.
//

import Foundation

protocol ChatParser {
    func parse(_ filename: String) throws -> TGChat
}

public class TelegramParser: ChatParser {
    private let decoder: JSONDecoder

    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    func parse(_ filename: String) -> TGChat  {
        guard !filename.isEmpty else {
            return TGChat(id: 0, name: "", messages: [])
        }

        guard let filepath = Bundle.main.path(forResource: filename, ofType: "json") else {
            return TGChat(id: 0, name: "", messages: [])
        }

        guard let data = FileManager.default.contents(atPath: filepath) else {
            return TGChat(id: 0, name: "", messages: [])
        }

        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let jsonData = try decoder.decode(TGChat.self, from: data)
            return jsonData
        } catch {
            print("Uh oh: \(error)")
        }

        return TGChat(id: 0, name: "", messages: []) 
    }
}

fileprivate enum FileUtilError: Error {
    case filenameEmpty
    case fileNotFound
    case noData
    case parsingError
}
