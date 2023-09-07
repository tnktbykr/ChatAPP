
import UIKit
import CoreData
import PureLayout
import Contacts
import ContactsUI


class ConversationsViewController: UIViewController, CNContactPickerDelegate {
    
    var addNewChatButton = UIButton()
    var fetchDataFromCore = UIButton()
    var deleteFromCore = UIButton()
    var fetchFilteredDataFromCore = UIButton()
    
    var titleArray = [String]()
    var idArray = [UUID]()
    
    var filteredTitleArray = [String]()
    var filteredIdArray = [UUID]()

    
    private var conversationsView: ConversationsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)

        conversationsView = ConversationsView.newAutoLayout()
        setupUI(conversationsView)
        
        conversationsView?.newConversationAction = findContact
        //setupUICore()
        
        DataManager.shared.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkConversations()
        
    }
    
    func checkConversations() {
        
        if DataManager.shared.conversationList.count == 0 {
            debugPrint("NO CONVERSATIONS")
            conversationsView?.noConvInform.isHidden = false
            conversationsView?.conversationsTableView.isHidden = true
        }else {
            debugPrint("SHOW CONVERSATIONS")
            conversationsView?.conversationsTableView.isHidden = false
            conversationsView?.noConvInform.isHidden = true
        }
    }
    
    private func findContact() {
        debugPrint("NEW CONVERSATION")
        
        let vc = CNContactPickerViewController()
        vc.delegate = self
        present(vc,animated: true)
    }
    
    func setupUICore() {
        
        view.addSubview(addNewChatButton)
        
        addNewChatButton.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = addNewChatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = addNewChatButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = addNewChatButton.widthAnchor.constraint(equalToConstant: 125)
        let heightConstraint = addNewChatButton.heightAnchor.constraint(equalToConstant: 90)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        addNewChatButton.layer.cornerRadius = 6
        addNewChatButton.setTitle("add new chat", for: .normal)
        addNewChatButton.backgroundColor = .systemBlue
        
        addNewChatButton.addTarget(self, action: #selector(saveNewCon), for: .touchUpInside)
        
        view.addSubview(fetchDataFromCore)
        
        fetchDataFromCore.translatesAutoresizingMaskIntoConstraints = false
        fetchDataFromCore.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
        fetchDataFromCore.widthAnchor.constraint(equalToConstant: 125.0).isActive = true
        fetchDataFromCore.topAnchor.constraint(equalTo:addNewChatButton.bottomAnchor,constant: 40).isActive = true
        fetchDataFromCore.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        fetchDataFromCore.layer.cornerRadius = 6
        fetchDataFromCore.setTitle("fetch data", for: .normal)
        fetchDataFromCore.backgroundColor = .green
        fetchDataFromCore.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        
        view.addSubview(deleteFromCore)
        
        deleteFromCore.translatesAutoresizingMaskIntoConstraints = false
        deleteFromCore.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
        deleteFromCore.widthAnchor.constraint(equalToConstant: 125.0).isActive = true
        deleteFromCore.topAnchor.constraint(equalTo:fetchDataFromCore.bottomAnchor,constant: 40).isActive = true
        deleteFromCore.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        deleteFromCore.layer.cornerRadius = 6
        deleteFromCore.setTitle("delete data", for: .normal)
        deleteFromCore.backgroundColor = .systemRed
        deleteFromCore.addTarget(self, action: #selector(deleteAllData), for: .touchUpInside)
        
        view.addSubview(fetchFilteredDataFromCore)
        
        fetchFilteredDataFromCore.translatesAutoresizingMaskIntoConstraints = false
        fetchFilteredDataFromCore.autoPinEdge(.bottom, to: .top, of: addNewChatButton, withOffset: -40)
        fetchFilteredDataFromCore.autoAlignAxis(toSuperviewAxis: .vertical)
        fetchFilteredDataFromCore.autoSetDimensions(to: CGSize(width: 125, height: 90))
        
        
        fetchFilteredDataFromCore.layer.cornerRadius = 6
        fetchFilteredDataFromCore.setTitle("fetch filtered data", for: .normal)
        fetchFilteredDataFromCore.backgroundColor = .darkGray
        fetchFilteredDataFromCore.addTarget(self, action: #selector(fetchFilteredCoreData), for: .touchUpInside)
    }
    
    private var configureUI: UIView?
    private func setupUI(_ userView: UIView?){
        
        configureUI = userView
        guard let configureUI = configureUI else {return}
        
        view.addSubview(configureUI)
        configureUI.autoPinEdgesToSuperviewEdges()
    }
    
    @objc private func saveNewCon() {
        
        debugPrint("saveNewCon")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let data = NSEntityDescription.insertNewObject(forEntityName: "Conversations", into: context)
        
        
        data.setValue("deneme4", forKey: "conversationTitle")
        data.setValue(UUID(), forKey: "conversationID")
        
        do {
            
            try context.save()
            debugPrint("conversation saved Succes")
            
        } catch {
            debugPrint("conversastion save ERROR")
        }
    }
    
    @objc private func fetchData() {
        
        debugPrint("fetchData")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversations")
    
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let title = result.value(forKey: "conversationTitle") as? String {
                    self.titleArray.append(title)
                }
                
                if let id = result.value(forKey: "conversationID") as? UUID {
                    self.idArray.append(id)
                }
                
            }
            debugPrint("titles \(titleArray)")
            debugPrint("ids: \(idArray)")
            
        }catch {
            debugPrint("FETCH ERROR")
            
        }
        
    }
    
    @objc private func fetchFilteredCoreData() {
        debugPrint("fetchFilteredCoreData")
        
        debugPrint("fetchData")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversations")
    
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "conversationID = %@", "F9E389C4-7F42-426C-9CFB-FF5990C2CCD9")
        
        do{
            
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let title = result.value(forKey: "conversationTitle") as? String {
                    self.filteredTitleArray.append(title)
                }
                
                if let id = result.value(forKey: "conversationID") as? UUID {
                    self.filteredIdArray.append(id)
                }
                
            }
            debugPrint("titles \(filteredTitleArray)")
            debugPrint("ids: \(filteredIdArray)")
            
        }catch {
            debugPrint("FETCH ERROR")
            
        }
        
        
        
    }
    
    @objc private func deleteAllData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversations")
    
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(fetchRequest)
            
            for object in results {
                
                guard let objectData = object as? NSManagedObject else {continue}
                
                context.delete(objectData)
                titleArray.removeAll()
                idArray.removeAll()
                fetchData()
            }
            
        } catch let error {
            
            print("Detele all data in Conversations error :", error)
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {

        var chatTitle = ("\(contact.givenName) \(contact.familyName)")
    
        let convsTitle = ("\(chatTitle)")
        
        let convsID = UUID()
        
        CoreDatamanager.shared.saveConversation(convsID: convsID, convsTitle: convsTitle)
        
        // TODO: - START CHAT SCREEN
        let vc = ChatViewController()
        vc.participatorName = chatTitle
        navigationController?.pushViewController(vc, animated: true)
        
       
    }

}
