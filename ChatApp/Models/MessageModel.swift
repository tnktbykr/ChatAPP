
import Foundation

struct MessageModel: ConversationModel {
    var conversationID: UUID
    
    let senderID: UUID
    let messageID: UUID
    let messageTxt: String
//    let messageDate: String
//    let didMessageSeen: Bool
//    let didMessageSent: Bool
    
}
 
