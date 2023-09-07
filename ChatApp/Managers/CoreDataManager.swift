//
//  CoreDataManager.swift
//  ChatApp
//
//

import Foundation
import CoreData
import UIKit


class CoreDatamanager {
    
    static let shared = CoreDatamanager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    private init() {
        debugPrint("CM -> CoreDatamanager started")
        
        
    }
    
    func saveConversation(convsID: UUID, convsTitle: String) {
        
        debugPrint("CM -> saveConversation started")
        
        let context = appDelegate.persistentContainer.viewContext
        let data = NSEntityDescription.insertNewObject(forEntityName: "Conversations", into: context)
        
        
        data.setValue(convsTitle, forKey: "conversationTitle")
        data.setValue(UUID(), forKey: "conversationID")
        
        do {
            
            try context.save()
            debugPrint("conversation saved Succes")
            
            saveUsers(convsID: convsID,
                      title: convsTitle)
            
        } catch {
            debugPrint("conversastion save ERROR")
        }
    }
    
    func saveUsers(convsID: UUID, title: String) {
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            // TODO: SAVE USER TO CORE DATA
            
            try context.save()
            debugPrint("user saved")
            let userID = UUID()
            
            DataManager.shared.usersArray.append(UserModel(conversationID: convsID,
                                        participatorID: userID,
                                        participatorName: title,
                                        participatorImage: "ımageURl"))
            
        } catch {
            
            debugPrint("user save ERROR")
        }
        
        for user in DataManager.shared.usersArray {
            
            debugPrint("\(user.participatorName) : CONVS ID:  \(user.conversationID) +  USER ID : \(user.participatorID)")
        }
        
    }
    
    func saveMessage(convsID: UUID, senderID: UUID, messageID: UUID,messageTxt: String) {
        debugPrint("CM -> saveMessage started")
        
        let context = appDelegate.persistentContainer.viewContext
        let data = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context)
        
        data.setValue(convsID, forKey: "conversationID")
        data.setValue(senderID, forKey: "senderID")
        data.setValue(messageID, forKey: "messageID")
        data.setValue(messageTxt, forKey: "messageTxt")
        
        do {
            
            try context.save()
            debugPrint("message saved Succes")
        
        } catch {
            debugPrint("message save ERROR")
        }
        
        
    }
    
    func fetchConversations() {
        debugPrint("CM -> fetchConversations started")
        
    }
    
    func fetchMessages() {
        
        debugPrint("fetchMessages")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
    
        fetchRequest.returnsObjectsAsFaults = false

        var convsID: UUID?
        var msgID: UUID?
        var msgTxt: String?
        var sndrID: UUID?
        
        do{
            
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let id = result.value(forKey: "conversationID") as? UUID {
                    convsID = id
                }
                
                if let messageID = result.value(forKey: "messageID") as? UUID {
                    msgID = messageID
                }
                
                if let txt = result.value(forKey: "messageTxt") as? String {
                    msgTxt = txt
                }
                
                if let senderID = result.value(forKey: "senderID") as? UUID {
                    sndrID = senderID
                }
                
                var messageData = MessageModel(conversationID: convsID!,
                                               senderID: sndrID!,
                                               messageID: msgID!,
                                               messageTxt: msgTxt!)
                
                DataManager.shared.messages.append(messageData)
             
                debugPrint(DataManager.shared.messages)
                
            }
            
        }catch {
            debugPrint("FETCH ERROR")
            
        }
    }

    func deleteConversation() {
        debugPrint("CM -> deleteConversation started")
        
        
    }

}
