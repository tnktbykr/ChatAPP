

import Foundation
import SwiftyUserDefaults


extension DefaultsKeys {
   
    static let userID = DefaultsKey<String>("userID", defaultValue: "")
    static let userName = DefaultsKey<String>("userName", defaultValue: "")
    static let userLoggedIn = DefaultsKey<Bool>("userLoggedIn", defaultValue: false)
}
