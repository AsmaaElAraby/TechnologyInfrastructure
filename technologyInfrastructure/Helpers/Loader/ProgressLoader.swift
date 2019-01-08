//
//  ProgressLoader.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/8/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import ARSLineProgress
import UIKit

class ProgressLoader: NSObject {
    static func show() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            ARSLineProgress.show()
        }
    }

    static func dismiss() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            ARSLineProgress.hide()
        }
    }
}
