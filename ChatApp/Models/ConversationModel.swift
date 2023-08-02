
//  ConversationListModel.swift

import Foundation


struct ConversationModel: Codable {
    
    let conversationID: String
    let conversationTitle: String
    let didMessageSeen: Bool
    let didMessageSent: Bool
    let messageID: String
    let messageTxt: String
    let messageDate: String
}
