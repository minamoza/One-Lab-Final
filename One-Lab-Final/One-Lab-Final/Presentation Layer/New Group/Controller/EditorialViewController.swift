//
//  EditorialViewController.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 27.04.2022.
//

import UIKit

class EditorialViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBlue
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        setup()
    }
    
    private func setup(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.right.left.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
