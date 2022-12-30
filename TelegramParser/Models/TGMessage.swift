//
//  TGMessage.swift
//  TelegramParser
//
//  Created by Michael Pace on 12/29/22.
//

import Foundation

public struct TGMessage: Decodable {
    private let id: Int
    private let type: TGMessageType
    private let textEntities: [TGTextEntity]

    private var from: TGFrom?
    private var actor: String?
    private var action: String?

    init(
        id: Int,
        type: TGMessageType,
        textEntities: [TGTextEntity],
        from: TGFrom? = nil,
        actor: String? = nil,
        action: String? = nil
    ) {
        self.id = id
        self.type = type
        self.textEntities = textEntities
        self.from = from
        self.actor = actor
        self.action = action
    }

    var author: String {
        if let from = from {
            return from.rawValue
        } else if let actor = actor {
            return actor
        } else {
            return "Unknown"
        }
    }

    func allText(_ exclude: Set<String> = Set<String>()) -> String {
        var result = ""

        for textEntity in textEntities {
            guard !exclude.contains(textEntity.text) else {
                continue
            }

            result += textEntity.text
        }

        return result
    }
}
