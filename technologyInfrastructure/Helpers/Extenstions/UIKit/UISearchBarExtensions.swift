//
//  UISearchBarExtensions.swift
//  TechnologyInfrastructure
//
//  Created by Asma on 1/8/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import UIKit

@IBDesignable extension UISearchBar {
    
    private var searchTextField:UITextField {
        return (self.subviews[0].subviews.last as? UITextField)!
    }
    
    @objc dynamic var textFieldGlassIconOnRight: Bool {
        get {
            return searchTextField.rightView == nil ? false : true
        }
        set {
            
            if newValue == true {
                
                let glassIconView = searchTextField.leftView as? UIImageView
                glassIconView?.frame = CGRect(x: (glassIconView?.frame.origin.x)!, y: (glassIconView?.frame.origin.y)!, width: (glassIconView?.frame.size.width)! + 10, height: (glassIconView?.frame.size.height)!)
                glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
                glassIconView?.contentMode = .scaleAspectFit
                glassIconView?.tintColor = UIColor.lightGray
                
                searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: searchTextField.frame.height))
                
                searchTextField.rightView = glassIconView
                searchTextField.rightViewMode = UITextFieldViewMode.always
            }
        }
    }
    
    @IBInspectable
    dynamic var textFieldCorner: CGFloat {
        get {
            return searchTextField.corner
        }
        set {
            searchTextField.corner = newValue
        }
        
    }
    
    @IBInspectable
    var textFieldBorderWidth: CGFloat {
        get {
            return searchTextField.borderWidth
        }
        set {
            searchTextField.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var textFieldBorderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: searchTextField.borderColor! as! CGColor)
            return color
        }
        set {
            searchTextField.borderColor = newValue
        }
    }
}
