//
//  ChatController.swift
//  ChatApp
//
//

import Foundation
import UIKit
import PureLayout
class ChatViewController: UIViewController {
    
    private var chatHeader: StandartChatViewHeader?
    var participatorName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.chatBackgroundColor

        chatHeader = StandartChatViewHeader.newAutoLayout()
        chatHeader?.setupViews(title: participatorName)
        insertHeader(chatHeader)
    }
    
    // MARK: - Header
    private var headerView: UIView?
    func insertHeader(_ header: UIView?) {
        headerView = header
        
        guard let headerView = headerView else {
            return
        }
       
        view.addSubview(headerView)
        
        headerView.autoPinEdge(.left, to: .left, of: view)
        headerView.autoPinEdge(.right, to: .right, of: view)
        headerView.autoPinEdge(.top, to: .top, of: view)
        headerView.autoSetDimension(.height, toSize: 75)

    }
    
    
    
    
    
}
