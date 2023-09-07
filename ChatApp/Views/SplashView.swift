//
//  SplashView.swift
//  ChatApp

//

import Foundation
import UIKit
import PureLayout

class SplashView: UIView {
    
    lazy var appLogo: UIImageView = {
        let img = UIImageView.newAutoLayout()
        img.image = Images.getImage(.newChat)
        
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        addSubview(appLogo)
        
        appLogo.autoAlignAxis(toSuperviewAxis: .horizontal)
        appLogo.autoAlignAxis(toSuperviewAxis: .vertical)
        appLogo.autoSetDimensions(to: CGSize(width: 125, height: 125))
    }
    
}
