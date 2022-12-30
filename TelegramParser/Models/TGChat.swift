//
//  TGChat.swift
//  TelegramParser
//
//  Created by Michael Pace on 12/29/22.
//

import Foundation

/**
 No Context messages per person (do bonus if we want)
 EXPLORE MUSIC
 EXPLORE letterbox reviews in MEDIA

 Who writes the longest messages (on avg)(per chat?)
 Shortest messages (on avg) (per chat?)

 Cuss of the year

 Who misspells the most
 Here are all the non-word words!

 Word Cloud: https://www.freewordcloudgenerator.com/generatewordcloud
 */
public struct TGChat: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case messages
    }

    private let exclusions: Set<String> = [
        "http"
    ]
    private var _authorWithMostMessagesAndCount = ("", 0)
    private var _authorAndLongestMessage = ("", "")
    private var _mostUsedEmojiAndCount: (Character, Int) = (" ", 0)
    private var _wordCloudString = ""


    private let id: Int
    private let name: String
    private let messages: [TGMessage]

    public init(
        id: Int,
        name: String,
        messages: [TGMessage]
    ) {
        self.id = id
        self.name = name
        self.messages = messages
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: CodingKeys.id)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        messages = try container.decode([TGMessage].self, forKey: CodingKeys.messages)

        processMessages()
    }

    var authorAndLongestMessage: (String, String) {
        return _authorAndLongestMessage
    }

    var authorWithMostMessagesAndCount: (String, Int) {
        return _authorWithMostMessagesAndCount
    }

    var wordCloudString: String {
        return _wordCloudString
    }

    var mostUsedEmojiAndCount: (Character, Int) {
        return _mostUsedEmojiAndCount
    }

    private mutating func processMessages() {
        var wordCloud = ""

        var maximumNumberOfMessages = Int.min
        var authorWithMostMessages = ""
        var authorToMessageCount = [String: Int]()

        var authorWithLongestMessage = ""
        var longestMessage = ""

        var emojiCount = [Character: Int]()
        var maximumNumberOfEmojis = Int.min
        var mostUsedEmoji: Character = "A"

        for message in messages {
            authorToMessageCount[message.author, default: 0] += 1

            if maximumNumberOfMessages < authorToMessageCount[message.author, default: 0] {
                maximumNumberOfMessages = authorToMessageCount[message.author, default: 0]
                authorWithMostMessages = message.author
            }

            if message.allText().count > longestMessage.count {
                longestMessage = message.allText()
                authorWithLongestMessage = message.author
            }

            wordCloud += message.allText(exclusions) + " "

            for scalar in message.allText().unicodeScalars where scalar.isAnEmoji {
                emojiCount[Character(scalar.description), default: 0] += 1

                if emojiCount[Character(scalar.description), default: 0] > maximumNumberOfEmojis {
                    maximumNumberOfEmojis = emojiCount[Character(scalar.description), default: 0]
                    mostUsedEmoji = Character(scalar.description)
                }
            }
        }

        self._authorWithMostMessagesAndCount = (authorWithMostMessages, maximumNumberOfMessages)
        self._authorAndLongestMessage = (authorWithLongestMessage, longestMessage)
        self._mostUsedEmojiAndCount = (mostUsedEmoji, maximumNumberOfEmojis)
        self._wordCloudString = wordCloud
    }
}

fileprivate extension UnicodeScalar {
    var isAnEmoji: Bool {
        return properties.isEmoji && properties.isEmojiPresentation
    }
}
