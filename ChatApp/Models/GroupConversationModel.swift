//
//  GroupConversationModel.swift
//  ChatApp


import Foundation

struct GroupConversationModel: ConversationModel {
   
    var conversationID: String
    var conversationTitle: String

    let members: Model

    struct Model: Codable {
        let memberList: [UserModel]
    }
    
}
