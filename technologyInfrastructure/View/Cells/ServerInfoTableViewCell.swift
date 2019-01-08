//
//  ServerInfoTableViewCell.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/5/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import UIKit

class ServerInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var serverNameLabel: UILabel!
    @IBOutlet weak var ipAddressLabel: UILabel!
    @IBOutlet weak var ipSubnetMaskLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var deviceProblemLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var clockButton: UIButton!
    @IBOutlet weak var silentButton: UIButton!
    
    func bindData(data: DeviceModel, indexPath: IndexPath) {
        
        serverNameLabel.text = data.name
        ipAddressLabel.text = data.ipAddress
        ipSubnetMaskLabel.text = data.ipSubnetMask
        
        var statusImageName = ""
        if indexPath.section == 1 {
            
            deviceProblemLabel.isHidden = true
            statusImageName = getStatusImageName(-1)
        
        } else if indexPath.section == 0 {
        
            switch indexPath.row {
            case 0:
                deviceProblemLabel.text = "   CPU 100 %   "
                break
            case 1:
                deviceProblemLabel.isHidden = true
                trueButton.isSelected = true
                clockButton.isSelected = true
                silentButton.isSelected = true
                break
            case 2:
                deviceProblemLabel.text = "   CPU 100 %   "
                break
            case 3:
                deviceProblemLabel.text = "   Module 2 Failure   "
                phoneButton.isSelected = true
                break
            default:
                break
            }
            
            statusImageName = getStatusImageName(data.status?.id ?? -1)
        }

        statusButton.setImage(UIImage(named: statusImageName), for: .normal)
    }

    private func getStatusImageName(_ status: Int) -> String {
        
        switch status {
        case 1:
            return "greenIcon"
        case 2:
            return "orangeIcon"
        case 3:
            return "yellowIcon"
        case 4:
            return "redIcon"
        default:
            return "blueIcon"
        }
    }
}
