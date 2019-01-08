//
//  ViewController.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/5/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import UIKit

class ServersListViewController: BaseViewController {

    @IBOutlet weak var baseTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var serverInfoController: ServerInfoProtocol? = nil
    fileprivate var dataSourceForBrokenServers: [DeviceModel] = []
    fileprivate var dataSourceForAllServers: [DeviceModel] = []

    private let currentPageNumber = 0
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        loadScreenData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        customizeSearchBarUI()
    }
    
    private func prepareUI() {
        
        baseTableView.register(UINib(nibName: "ServerInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "ServerInfoTableViewCell")
        baseTableView.register(UINib(nibName: "SectionHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "SectionHeaderTableViewCell")
        
        if #available(iOS 10.0, *) {
            baseTableView.refreshControl = refreshControl
        } else {
            baseTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(loadScreenData), for: .valueChanged)
    }

    private func customizeSearchBarUI() {
        
        searchBar.textFieldGlassIconOnRight = true
    }
    
    @objc private func loadScreenData() {
        loadScreenDataWith(requestProtocol: self)
    }
    
    private func loadScreenDataWith(requestProtocol: RequestProtocol) {
        serverInfoController = ServerInfoController(requestProtocol: requestProtocol)
        serverInfoController?.loadServersInfoFor(currentPageNumber)
    }
    
    fileprivate func dataSourceFor(_ section: Int) -> [DeviceModel] {
        
        return section == 0 ? dataSourceForBrokenServers : dataSourceForAllServers
    }
}

extension ServersListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceFor(section).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServerInfoTableViewCell", for: indexPath) as? ServerInfoTableViewCell else {
            return UITableViewCell()
        }

        cell.bindData(data: dataSourceFor(indexPath.section)[indexPath.row], indexPath: indexPath)
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderTableViewCell", for: IndexPath(row: 0, section: section)) as? SectionHeaderTableViewCell else {
                return nil
            }
            
            return cell.contentView
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 28
    }
}

extension ServersListViewController: RequestProtocol {
    
    func willLoad() {
        ProgressLoader.show()
    }
    
    func didLoadData<T: Codable>(data: T) {
        
        if refreshControl.isRefreshing == true {
            refreshControl.endRefreshing()
        }
        
        guard let serverData = data as? ServerSummaryModel else {
            return
        }

        dataSourceForAllServers = serverData.devicesInfoList ?? []
        dataSourceForBrokenServers = serverInfoController?.getBrokenServers(dataSourceForAllServers) ?? []
        baseTableView.reloadData()
        
        ProgressLoader.dismiss()
    }
    
    func didFailWith(message: String) {
        
        ProgressLoader.dismiss()
        displayErrorMessage(message)
    }
}
