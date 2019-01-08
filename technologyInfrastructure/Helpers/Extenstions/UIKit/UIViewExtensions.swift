//
//  UIViewExtensions.swift
//  TechnologyInfrastructure
//
//  Created by Asma on 1/7/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    
    @IBInspectable dynamic var  corner: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadiusView: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOffset = CGSize(width: -2, height: 2)
            layer.shadowOpacity = 0.2
            layer.shadowRadius = shadowRadiusView
            layer.masksToBounds = false
        }
    }

}
