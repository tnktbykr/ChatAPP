//
//  GroupConversationModel.swift
//  ChatApp


import Foundation

struct GroupConversationModel: Codable {
    
    let conversationID: String
    let conversationTitle: String
    let didMessageSeen: Bool
    let didMessageSent: Bool
    let messageID: String
    let messageTxt: String
    let messageDate: String
    let members: Model

    struct Model: Codable {
        let memberList: [UserModel]
    }
    
}
