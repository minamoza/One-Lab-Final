//
//  SearchPhotoTableView.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 01.05.2022.
//

import UIKit

class SearchPhotoTableView: UIView {

    let cellId = "cellId"

    var tableView = UITableView()

    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width

    override init(frame: CGRect){
        super.init(frame: frame)

        setup()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setup() {

        self.backgroundColor = UIColor.black

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth*0.5, height: screenHeight))
        tableView.layer.backgroundColor = UIColor.black.cgColor
        self.addSubview(tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SearchPhotoTableView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .magenta
        return cell
    }
}
