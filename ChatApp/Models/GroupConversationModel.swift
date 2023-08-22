
import Foundation

struct GroupConversationModel: ConversationModel {
    var conversationID: UUID
    var conversationTitle: String
    let groupConversationImage: String
    
    let members: Model

    struct Model: Codable {
        let memberList: [UserModel]
    }
    
}
