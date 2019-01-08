//
//  BaseViewController.swift
//  TechnologyInfrastructure
//
//  Created by Asma on 1/8/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import UIKit
import SwiftMessages

class BaseViewController: UIViewController {
    
    func displaySuccessMessage(_ message: String) {
        
        displayMessage(.success, message)
    }
    
    func displayErrorMessage(_ message: String) {
        
        displayMessage(.error, message)
    }
    
    private func displayMessage(_ theme: Theme, _ message: String) {
        
        SwiftMessages.defaultConfig.presentationStyle = .bottom
        SwiftMessages.defaultConfig.duration = SwiftMessages.Duration.seconds(seconds: 4)
        
        let view = MessageView.viewFromNib(layout: .cardView)
        
        view.configureTheme(theme)
        view.configureDropShadow()
        view.configureContent(title: "", body: message)
        view.button?.isHidden = true
        view.button?.removeFromSuperview()
        
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        SwiftMessages.show(view: view)
    }
}
