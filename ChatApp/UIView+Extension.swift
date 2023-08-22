//
//  UIView+Extension.swift
//  ChatApp
//

//

import UIKit
import Foundation

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    @objc func dismissKeyboard() {
       
        view.endEditing(true)
        
        NotificationCenter.default.post(name: NSNotification.Name("checkIsSearching"), object: nil)
        
        
        debugPrint("KEYBOARD DISMISSED")
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Warning", message: "You did not specify any name", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
      
        self.present(alert, animated: true)
     
        
        
    }
}
