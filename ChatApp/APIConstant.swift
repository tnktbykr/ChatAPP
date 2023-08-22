import Foundation


struct APIConstant {
    static let baseURL = "aaaa/api/"
    static let alertURL = "aaaalerts/"
    static let authURL = "aaaauth/"
    static let tradingPairURL = "aaatradingpairs/"
    static let userURL = "aaausers/"
    static let contactUsURL = "aaacontactusmessages/"
    static let websocketURL = "aaa"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
