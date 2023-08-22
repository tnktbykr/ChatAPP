
import Foundation

struct UserModel: Codable, ConversationModel {
    var conversationID: UUID
    
    
    let participatorID: UUID
    let participatorName: String
    let participatorImage: String

}
