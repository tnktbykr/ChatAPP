
import Foundation
import UIKit

struct Images {
    
    enum ImageNames: String {
       
        case newChat = "newChat.png"
        case blueArrow = "arrow.png"
    }


    static func getImage(_ imageName: ImageNames) -> UIImage? {
        guard let image = UIImage(named: imageName.rawValue) else { return nil }
        return image
    }
}
