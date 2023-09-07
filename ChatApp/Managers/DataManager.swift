//
//  DataManager.swift
//  ChatApp


import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    var conversationList = [ConversationModel]()
    var messages = [MessageModel]()
    var usersArray = [UserModel]()
    
    private init() {
        debugPrint("DM -> DataManager started")
        
                
    }
    
    func fetchData() {
        
        debugPrint("fetchData")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversations")
    
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let title = result.value(forKey: "conversationTitle") as? String {
                    //self.titleArray.append(title)
                }
                
                if let id = result.value(forKey: "conversationID") as? UUID {
                    //self.idArray.append(id)
                }
                
            }
            
        }catch {
            debugPrint("FETCH ERROR")
            
        }
        
    }
    
}
