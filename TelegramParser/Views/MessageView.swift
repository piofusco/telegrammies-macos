//
//  MessageView.swift
//  TelegramParser
//
//  Created by Michael Pace on 12/29/22.
//

import SwiftUI

struct MessageView: View {
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMMd, YYYY HH:mm ssa" // December 31, 20XX 12:23 31PM
        return dateFormatter
    }()

    private let message: TGMessage

    init(message: TGMessage) {
        self.message = message
    }

    var body: some View {
        HStack {
            Text(message.author)
//            Text(message.allText)
        }.padding()
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(
            message: TGMessage(
                id: 0,
                type: .message,
                textEntities: [
                    TGTextEntity(text: "The first "),
                    TGTextEntity(text: "message is "),
                    TGTextEntity(text: "always the most "),
                    TGTextEntity(text: "important!")
                ],
                from: .allie
            )
        )
    }
}
