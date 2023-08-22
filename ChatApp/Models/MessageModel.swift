
import Foundation

struct MessageModel: ConversationModel  {
    var conversationID: UUID
    
    
    let messageID: String
    let messageTxt: String
    let messageDate: String
    let didMessageSeen: Bool
    let didMessageSent: Bool
    
}
 
