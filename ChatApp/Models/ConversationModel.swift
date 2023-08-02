
//  ConversationListModel.swift

import Foundation


struct ConversationModel: Codable {
    
    let conversationID: String
    let participatorName: String
    let participatorImage: String
    
    let isGroupChat: Bool
    let conversationTitle: String
    
    let isSeen: Bool
    let isSent: Bool
    
    let messageID: String
    let messageTxt: String
    let messageDate: String
}
