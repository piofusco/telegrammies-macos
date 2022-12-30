//
//  TelegramParserApp.swift
//  TelegramParser
//
//  Created by Michael Pace on 12/29/22.
//

import SwiftUI

@main
struct TelegramParserApp: App {
    private let chatParser = TelegramParser(decoder: JSONDecoder())

    private let debate: TGChat
    private let fashion: TGChat
    private let food: TGChat
    private let main: TGChat
    private let media: TGChat
    private let music: TGChat

    init() {
        debate = chatParser.parse("debate")
        fashion = chatParser.parse("fashion")
        food = chatParser.parse("food")
        main = chatParser.parse("main")
        media = chatParser.parse("media")
        music = chatParser.parse("music")

        print("Debate - \(debate.mostUsedEmojiAndCount.0): \(debate.mostUsedEmojiAndCount.1)")
        print("Fashion - \(fashion.mostUsedEmojiAndCount.0): \(fashion.mostUsedEmojiAndCount.1)")
        print("Food - \(food.mostUsedEmojiAndCount.0): \(food.mostUsedEmojiAndCount.1)")
        print("Main - \(main.mostUsedEmojiAndCount.0): \(main.mostUsedEmojiAndCount.1)")
        print("Media - \(media.mostUsedEmojiAndCount.0): \(media.mostUsedEmojiAndCount.1)")
        print("Music - \(music.mostUsedEmojiAndCount.0): \(music.mostUsedEmojiAndCount.1)")
    }

    var body: some Scene {
        WindowGroup {
            
        }
    }
}


