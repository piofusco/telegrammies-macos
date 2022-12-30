//
//  TGMessageAction.swift
//  TelegramParser
//
//  Created by Michael Pace on 12/30/22.
//

import Foundation

enum TGMessageAction: String, Decodable {
    case createGroup = "create_group"
    case editGroupPhoto = "edit_group_photo"
    case editGroupTitle = "edit_group_title"
    case joinGroupByLink = "join_group_by_link"
    case groupCall = "group_call"
    case inviteMembers = "invite_members"
    case pinMessage = "pin_message"
    case removeMembers = "remove_members"
}
