//
//  ConversationsView.swift
//  ChatApp
//

import Foundation
import UIKit
import PureLayout

class ConversationsView: UIView, UITableViewDelegate, UITableViewDataSource {
   
    lazy var screenLabel: UILabel = {
        let lbl = UILabel.newAutoLayout()
        return lbl
    }()
    
    lazy var noConvInform: UILabel = {
        let lbl = UILabel.newAutoLayout()
        lbl.isHidden = true
        return lbl
    }()
    
    var conversationsTableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.isHidden = true
        return tableView
    }()
    
    var startNewConversationButton: UIButton = {
        let btn = UIButton.newAutoLayout()
        btn.setImage(Images.getImage(.newChat), for: .normal)
       return btn
    }()
    
    var newConversationAction: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        conversationsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        conversationsTableView.delegate = self
        conversationsTableView.dataSource = self
        conversationsTableView.allowsSelection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(screenLabel)
        addSubview(startNewConversationButton)
        addSubview(conversationsTableView)
        addSubview(noConvInform)
        
        
        screenLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 50)
        screenLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
        screenLabel.autoSetDimension(.height, toSize: 25)
        
        startNewConversationButton.autoPinEdge(toSuperviewEdge: .top, withInset: 50)
        startNewConversationButton.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
        startNewConversationButton.autoSetDimensions(to: CGSize(width: 25, height: 25))

        
        
        conversationsTableView.autoPinEdge(.top, to: .bottom, of: screenLabel, withOffset: 10)
        conversationsTableView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        conversationsTableView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        conversationsTableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        
        noConvInform.autoAlignAxis(toSuperviewAxis: .vertical)
        noConvInform.autoAlignAxis(toSuperviewAxis: .horizontal)
        noConvInform.autoSetDimension(.height, toSize: 100)
        
        startNewConversationButton.addTarget(self, action: #selector(startNewConversationTapped), for: .touchUpInside)
        
        styleUI()
    }
    
    func styleUI() {
        
        screenLabel.textColor = .black
        screenLabel.text = "chats".uppercased()
        
        noConvInform.textColor = .black
        noConvInform.text = "No conversation found".uppercased()
        
        conversationsTableView.backgroundColor = .white
    }
    
    @objc func startNewConversationTapped() {
        newConversationAction?()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = conversationsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.separatorInset = UIEdgeInsets.zero
        
        return cell
    }
    
    
}
