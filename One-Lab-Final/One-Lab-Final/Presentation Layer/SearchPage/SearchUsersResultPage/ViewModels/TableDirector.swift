//
//  TableDirector.swift
//  One-Lab-Final
//
//  Created by aya on 04.05.2022.
//

import UIKit

class TableDirector: NSObject {
    
    let tableView: UITableView
    var items = [CellConfigurator]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let actionProxy = CellActionProxy()
    
    init(tableView: UITableView, items: [CellConfigurator]) {
        self.tableView = tableView
        super.init()
        self.tableView.separatorColor = .white
        self.tableView.separatorStyle = .none
        self.tableView.separatorStyle = .singleLine
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.layer.cornerRadius = CGFloat(10)
        self.tableView.clipsToBounds = true
        self.tableView.backgroundColor = .black
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0)
        
            // self.tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.items = items
        
        NotificationCenter.default.addObserver(self, selector: #selector(onActionEvent(notification:)), name: CellAction.notificationName, object: nil)
    }
    
    @objc fileprivate func onActionEvent(notification: Notification) {
        if let eventData = notification.userInfo?["data"] as? CellActionEventData, let cell = eventData.cell as? UITableViewCell, let indexPath = self.tableView.indexPath(for: cell) {
            actionProxy.invoke(action: eventData.action, cell: cell, configurator: self.items[indexPath.row])
        }
    }
}

extension TableDirector: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellConfig = self.items[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
       self.actionProxy.invoke(action: .didSelect, cell: cell, configurator: cellConfig)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = (tableView.bounds.size.height) / 6.25
        return height
    }
}

extension TableDirector: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfig = self.items[indexPath.row]
        tableView.register(type(of: cellConfig).cellClass, forCellReuseIdentifier: type(of:cellConfig).reuseId)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: cellConfig).reuseId, for: indexPath)
        cellConfig.configure(cell: cell)
        return cell
    }
}

