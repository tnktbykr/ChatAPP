//
//  ConversationsView.swift
//  ChatApp
//

import Foundation
import UIKit
import PureLayout
import SwiftyUserDefaults

class CreateAccountView: UIView, UITextFieldDelegate, UITextViewDelegate {
   
    lazy var createAccounLabel: UILabel = {
        
        var lbl = UILabel.newAutoLayout()
        lbl.text = "choose your name".uppercased()
        return lbl
    }()
    
    lazy var userNameField: UITextField = {
        let field = UITextField.newAutoLayout()
        return field
    }()
    
    lazy var doneImg: UIImageView = {
        
        let img = UIImageView.newAutoLayout()
        let flippedImage = Images.getImage(.blueArrow)!.withHorizontallyFlippedOrientation()
        img.image = flippedImage
        return img
    }()
    
    lazy var doneButton: UIButton = {
        
        let btn = UIButton.newAutoLayout()
        btn.backgroundColor = .clear
        btn.addTarget(self,
                      action: #selector(continueToConversationsTapped),
                      for: .touchUpInside)
        return btn
    }()
    
   
    var continueToConversationsAction: (()->Void)?
    var showAlertAction: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(createAccounLabel)
        addSubview(userNameField)
        addSubview(doneButton)
        addSubview(doneImg)
        
        bringSubviewToFront(doneButton)
        
        createAccounLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        createAccounLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        createAccounLabel.autoSetDimension(.height, toSize: 50)
        
        userNameField.autoPinEdge(.top, to: .bottom, of: createAccounLabel, withOffset: 10)
        userNameField.autoPinEdge(toSuperviewEdge: .left, withInset: 50)
        userNameField.autoPinEdge(toSuperviewEdge: .right, withInset: 50)
        userNameField.autoSetDimension(.height, toSize: 45)
        userNameField.delegate = self
        
        doneButton.autoPinEdge(.top, to: .bottom, of: createAccounLabel, withOffset: 10)
        doneButton.autoPinEdge(.left, to: .right, of: userNameField, withOffset: 5)
        doneButton.autoSetDimensions(to: CGSize(width: 50, height: 50))
        
        doneImg.autoPinEdge(.top, to: .bottom, of: createAccounLabel, withOffset: 22)
        doneImg.autoPinEdge(.left, to: .right, of: userNameField, withOffset: 7)
        doneImg.autoSetDimensions(to: CGSize(width: 25, height: 25))
        
        
        styleUI()
    }
    
    func styleUI() {
        
        createAccounLabel.textColor = UIColor.headerBackgroundColor
        
        userNameField.layer.borderWidth = 1
        userNameField.layer.cornerRadius = 6
        userNameField.layer.borderColor = UIColor.textFieldUnfocusedBorderColor
        userNameField.textColor = UIColor.headerBackgroundColor
        userNameField.setLeftPadding(11)
        
        doneImg.contentMode = .scaleAspectFit

    }
    
    @objc func continueToConversationsTapped() {
        debugPrint("CONTINUE TO CONVERSATIONS TAPPED")
        
        if userNameField.text != "" {
            
            Defaults [.userName] = userNameField.text!
            Defaults [.userID] = UUID().uuidString
            
            debugPrint("GO TO CONVERSATIONS")
            continueToConversationsAction?()
            
        }else {
            debugPrint("SHOW ALERT")
            showAlertAction?()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            
            debugPrint("GO TO CONVERSATIONS")
            
        }else {
            
            debugPrint("SHOW ALERT")
            showAlertAction?()
        }
       
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.separatorColor.cgColor
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = UIColor.textFieldUnfocusedBorderColor
      
    }
    
  
}
