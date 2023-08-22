//
//  ConversationsView.swift
//  ChatApp
//

import Foundation
import UIKit
import PureLayout

class StandartChatViewHeader: UIView {
   
    lazy var chatTitle: UILabel = {
        let lbl = UILabel.newAutoLayout()
        return lbl
    }()
    
    lazy var headerBackgrounView: UIView = {
        
        let view = UIView.newAutoLayout()
        return view
    }()
    
    lazy var separatorBackgrounView: UIView = {
        
        let view = UIView.newAutoLayout()
        return view
    }()
    

    func setupViews(title: String) {
        
        addSubview(headerBackgrounView)
        headerBackgrounView.addSubview(chatTitle)
        headerBackgrounView.addSubview(separatorBackgrounView)
        bringSubviewToFront(chatTitle)
        bringSubviewToFront(separatorBackgrounView)
        
        headerBackgrounView.autoPinEdge(toSuperviewEdge: .top ,withInset: 0)
        headerBackgrounView.autoPinEdge(toSuperviewEdge: .left ,withInset: 0)
        headerBackgrounView.autoPinEdge(toSuperviewEdge: .right ,withInset: 0)
        headerBackgrounView.autoPinEdge(toSuperviewEdge: .bottom ,withInset: 0)
        
        separatorBackgrounView.autoPinEdge(toSuperviewEdge: .left ,withInset: 0)
        separatorBackgrounView.autoPinEdge(toSuperviewEdge: .right ,withInset: 0)
        separatorBackgrounView.autoPinEdge(toSuperviewEdge: .bottom ,withInset: 0)
        separatorBackgrounView.autoSetDimension(.height, toSize: 1)
        
        
        chatTitle.autoAlignAxis(toSuperviewAxis: .horizontal)
        chatTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        chatTitle.autoSetDimension(.height, toSize: 25)
      
        chatTitle.text = title
        styleUI()
    }
    
    func styleUI() {
        
        chatTitle.textColor = .white
        headerBackgrounView.backgroundColor = UIColor.headerBackgroundColor
        separatorBackgrounView.backgroundColor = UIColor.separatorColor
        
    }

}
