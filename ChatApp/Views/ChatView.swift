//
//  ChatView.swift
//  ChatApp
//

import Foundation
import UIKit
import PureLayout
import SwiftyUserDefaults

class ChatView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var bottomButtonConstraint = NSLayoutConstraint()
    
    var heightKeyboard:CGFloat?
    
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
    
    lazy var sendMessageImg: UIImageView = {
        
        let img = UIImageView.newAutoLayout()
        let flippedImage = Images.getImage(.blueArrow)!.withHorizontallyFlippedOrientation()
        img.image = flippedImage
        return img
        
    }()
    
    lazy var sendMessageButton: UIButton = {
        
        let btn = UIButton.newAutoLayout()
        btn.addTarget(self,
                      action: #selector(sendMessageTapped),
                      for: .touchUpInside)
        return btn
        
    }()
    
    lazy var goBackButton: UIButton = {
        
        let btn = UIButton.newAutoLayout()
        btn.setImage(Images.getImage(.blueArrow), for: .normal)
        btn.addTarget(self,
                      action: #selector(goBackTapped),
                      for: .touchUpInside)
        return btn
        
    }()
    
    
    lazy var txtFieldContainer: UIView = {
        let txtContainer = UIView.newAutoLayout()
        
        return txtContainer
    }()
    
    var chatCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    lazy var messageField: UITextField = {
        let txtField = UITextField.newAutoLayout()
        txtField.placeholder = "write a message"
        return txtField
        
    }()
    
    var goBackAction: (()->Void)?
    var sendMessageAction: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    func setupViews(title: String) {
        
        addSubview(headerBackgrounView)
        headerBackgrounView.addSubview(chatTitle)
        headerBackgrounView.addSubview(separatorBackgrounView)
        headerBackgrounView.addSubview(goBackButton)
        bringSubviewToFront(chatTitle)
        bringSubviewToFront(separatorBackgrounView)
        
        headerBackgrounView.autoPinEdge(toSuperviewSafeArea: .top,withInset: 0)
        headerBackgrounView.autoPinEdge(toSuperviewEdge: .left ,withInset: 0)
        headerBackgrounView.autoPinEdge(toSuperviewEdge: .right ,withInset: 0)
        headerBackgrounView.autoSetDimension(.height, toSize: 50)
        
        chatTitle.autoAlignAxis(toSuperviewAxis: .horizontal)
        chatTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        chatTitle.autoSetDimension(.height, toSize: 25)
        
        goBackButton.autoPinEdge(toSuperviewEdge: .left,withInset: 15)
        goBackButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        goBackButton.autoSetDimensions(to: CGSize(width: 25, height: 25))
        
        separatorBackgrounView.autoPinEdge(toSuperviewEdge: .left ,withInset: 0)
        separatorBackgrounView.autoPinEdge(toSuperviewEdge: .right ,withInset: 0)
        separatorBackgrounView.autoPinEdge(toSuperviewEdge: .bottom ,withInset: 0)
        separatorBackgrounView.autoSetDimension(.height, toSize: 1)
        
     
        
        chatTitle.text = title
        
        
        addSubview(txtFieldContainer)
        
        txtFieldContainer.backgroundColor = UIColor.headerBackgroundColor
        txtFieldContainer.autoPinEdge(toSuperviewEdge: .right)
        txtFieldContainer.autoPinEdge(toSuperviewEdge: .left)
        bottomButtonConstraint = txtFieldContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtonConstraint.isActive = true
        
        txtFieldContainer.autoSetDimension(.height, toSize: 50)
        
        txtFieldContainer.addSubview(messageField)
        
        messageField.autoPinEdge(toSuperviewEdge: .right,withInset: 35)
        messageField.autoPinEdge(toSuperviewEdge: .left,withInset: 35)
        messageField.autoPinEdge(toSuperviewEdge: .top,withInset: 5)
        messageField.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
        
        txtFieldContainer.addSubview(sendMessageImg)
        sendMessageImg.autoPinEdge(toSuperviewEdge: .top , withInset: 5)
        sendMessageImg.autoPinEdge(toSuperviewEdge: .bottom , withInset: 5)
        sendMessageImg.autoPinEdge(.left, to: .right, of: messageField, withOffset: 10)
        sendMessageImg.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        txtFieldContainer.addSubview(sendMessageButton)
        
        sendMessageButton.autoSetDimensions(to: CGSize(width: 45, height: 45))
        sendMessageButton.autoPinEdge(.left, to: .right, of: messageField, withOffset: 5)
        sendMessageButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        txtFieldContainer.bringSubviewToFront(sendMessageButton)
        
        
        styleUI()
    }
    
    func styleUI() {
        
        messageField.setLeftPadding(11)
        messageField.layer.borderWidth = 1
        messageField.layer.borderColor = UIColor.separatorColor.cgColor
        messageField.layer.cornerRadius = 6
        
        chatTitle.textColor = .white
        headerBackgrounView.backgroundColor = UIColor.headerBackgroundColor
        separatorBackgrounView.backgroundColor = UIColor.separatorColor
        
        sendMessageImg.contentMode = .scaleAspectFit
        sendMessageButton.backgroundColor = .clear
        
        goBackButton.contentMode = .scaleAspectFill

        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        addSubview(chatCollectionView)
        
        chatCollectionView.autoPinEdge(.top, to: .bottom, of: headerBackgrounView, withOffset: 1)
        chatCollectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        chatCollectionView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        chatCollectionView.autoPinEdge(.bottom, to: .top, of: txtFieldContainer, withOffset: 0)
        
        chatCollectionView.backgroundColor = UIColor.chatBackgroundColor
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        chatCollectionView.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: ChatCollectionViewCell.identifier)
        
    }
    
    @objc func sendMessageTapped() {
        
        sendMessageAction?()
    }
    
    @objc func goBackTapped() {
        
        goBackAction?()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if self.isHidden {
            return
        }
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            heightKeyboard = keyboardHeight
            
            DispatchQueue.main.async {
                
                self.bottomButtonConstraint.constant -= keyboardHeight

            }
        }
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        
        guard let heightKeyboard = heightKeyboard, self.isHidden == false else {
            return
        }
        
        self.bottomButtonConstraint.constant += heightKeyboard
        self.layoutIfNeeded()
    }
    
    //MARK: - COLLECTONVIEW SETUP
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return DataManager.shared.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionViewCell.identifier, for: indexPath) as! ChatCollectionViewCell
        
        cell.backgroundColor = .clear
 
        cell.configureMessageCell(with: MessageModel(conversationID: UUID(),
                                                     senderID: UUID(),
                                                     messageID: DataManager.shared.messages[indexPath.row].messageID,
                                                     messageTxt: DataManager.shared.messages[indexPath.row].messageTxt))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 75)
    }
    
    
}
