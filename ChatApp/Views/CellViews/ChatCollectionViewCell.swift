//
//  ChatCollectionViewCell.swift
//  ChatApp
//

import Foundation
import UIKit
import PureLayout
import SwiftyUserDefaults

class ChatCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ChatCollectionViewCell"
    
    lazy var messageContainer: UIView = {
        let container = UIView.newAutoLayout()
        return container
    }()
    
    lazy var messageTxt: UILabel = {
        let lbl = UILabel.newAutoLayout()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configureMessageCell(with model: MessageModel) {
        
        messageTxt.text = model.messageTxt
        
      //  if model.senderID != Defaults [.userID] {
        
            messageContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
            
       // }else {
            
       //     messageContainer.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
      //  }
    }
    
    func setupViews() {
        contentView.addSubview(messageContainer)
        messageContainer.addSubview(messageTxt)
        
        
        messageContainer.autoPinEdge(toSuperviewEdge: .top, withInset: 5)
        messageContainer.autoSetDimensions(to: CGSize(width: 200, height: 50))

        messageTxt.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        messageTxt.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        messageTxt.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
        messageTxt.autoSetDimension(.width, toSize: 200)
        
        styleUI()
    }
    
    func styleUI() {
    
        messageContainer.backgroundColor = UIColor.messageContainerBackgroundColor
        messageContainer.layer.cornerRadius = 6
        
        messageTxt.numberOfLines = 0
    
    }

}
