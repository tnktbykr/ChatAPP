//
//  SplashViewController.swift
//  ChatApp
//

import Foundation
import UIKit
import PureLayout
import SwiftyUserDefaults

class SplashViewController: UIViewController {
    
    var splashView: SplashView?
    var vc: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        splashView = SplashView.newAutoLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUI(splashView)
        getConversations()
    }
    
    private var configureUI: UIView?
    private func setupUI(_ userView: UIView?){
        
        configureUI = userView
        guard let configureUI = configureUI else {return}
        
        view.addSubview(configureUI)
        configureUI.autoPinEdgesToSuperviewEdges()
    }
    
    private func getConversations(){
        debugPrint("GET CONVERSATIONS")
        
        continueToNextScreen()
    }
    
    private func continueToNextScreen(){
        
        
        if Defaults [.userLoggedIn] {
            debugPrint("START CONVERSATIONS")
            vc = ConversationsViewController()
        }else {
            debugPrint("START CREATE ACCOUNT")
            vc = CreateAccountViewController()
        }
        
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
