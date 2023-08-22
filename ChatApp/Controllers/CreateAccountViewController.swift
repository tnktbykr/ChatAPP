
import UIKit
import CoreData
import PureLayout
import Contacts
import ContactsUI


class CreateAccountViewController: UIViewController {
    
    private var createAccountView: CreateAccountView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        createAccountView = CreateAccountView.newAutoLayout()
        setupUI(createAccountView)
        
        createAccountView?.continueToConversationsAction = goToConversations
        createAccountView?.showAlertAction = noNameAlert
        
        createAccountView?.userNameField.becomeFirstResponder()
        
        DataManager.shared.fetchData()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    private func goToConversations() {
        debugPrint("goToConversations ACTION")
      
        let vc = ConversationsViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func noNameAlert() {
        self.showAlert()
    }
   
    private var configureUI: UIView?
    private func setupUI(_ userView: UIView?){
        
        configureUI = userView
        guard let configureUI = configureUI else {return}
        
        view.addSubview(configureUI)
        configureUI.autoPinEdgesToSuperviewEdges()
    }
}
