import UIKit

extension UITextField {
    
    func setLeftPadding(_ space: CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always

    }

}
