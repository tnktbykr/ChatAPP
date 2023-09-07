//
//  ChatController.swift
//  ChatApp
//
//

import Foundation
import UIKit
import PureLayout
import SwiftyUserDefaults

class ChatViewController: UIViewController {
    
    
    private var chatView: ChatView?
    
    var participatorName = ""
    var newMessage = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.chatBackgroundColor

        chatView = ChatView.newAutoLayout()
        chatView?.setupViews(title: participatorName)
        insertChatView(chatView)
        
        chatView?.sendMessageAction = sendNewMessage
        chatView?.goBackAction = goBackToConversations
        
        //self.chatHideKeyboardWhenTappedAround()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        chatView?.messageField.becomeFirstResponder()
    }
    
    // MARK: - Chat
    private var configureChat: UIView?
    func insertChatView(_ configureChat: UIView?) {
        self.configureChat = configureChat
        
        guard let configureChat = configureChat else {
            return
        }
       
        view.addSubview(configureChat)
        
        configureChat.autoPinEdge(toSuperviewSafeArea: .top)
        configureChat.autoPinEdge(.left, to: .left, of: view)
        configureChat.autoPinEdge(.right, to: .right, of: view)
        configureChat.autoPinEdge(toSuperviewSafeArea: .bottom)
    
    }
    
    private func sendNewMessage() {
        debugPrint("sendNewMessage ACTION")
      
        if chatView?.messageField.text != "" {
            var messageID = UUID()
            
            newMessage = (chatView?.messageField.text)!
            
            DataManager.shared.messages.append(MessageModel(conversationID: UUID(),
                                                            senderID: UUID(),
                                                            messageID: messageID,
                                                            messageTxt: (chatView?.messageField.text)!))
            
            CoreDatamanager.shared.saveMessage(convsID: UUID(), senderID: UUID(), messageID: UUID(), messageTxt: (chatView?.messageField.text)!)
            
            chatView?.messageField.text = ""
            
            chatView?.chatCollectionView.reloadData()
            
            for message in DataManager.shared.messages {
                
                debugPrint("MESSAGE INFO : \(message.messageID) + \(message.messageTxt) + \(message.messageID)")
                
                
            }
        }
    }
    
    private func goBackToConversations() {
        debugPrint("goBackToConversations ACTION")
        CoreDatamanager.shared.fetchMessages()
        navigationController?.popViewController(animated: true)
    }
}

extension ChatViewController {
    
    func chatHideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    @objc func chatDismissKeyboard() {
       
        view.endEditing(true)
        
 
        debugPrint("KEYBOARD DISMISSED")
    }

}

