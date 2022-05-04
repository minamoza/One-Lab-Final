//
//  EditorialViewController.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 27.04.2022.
//

import UIKit

class EditorialViewController: UIViewController {

    private let items: [CellConfigurator] = [
        EditorialCellConfigurator(item: EditorialModel(imageName: "animals", title: "animals")),
        EditorialCellConfigurator(item: EditorialModel(imageName: "Nature", title: "animals")),
        EditorialCellConfigurator(item: EditorialModel(imageName: "animals", title: "animals")),
        EditorialCellConfigurator(item: EditorialModel(imageName: "Underwater", title: "animals")),
        EditorialCellConfigurator(item: EditorialModel(imageName: "Nature", title: "animals")),
        EditorialCellConfigurator(item: EditorialModel(imageName: "Travel", title: "animals"))
    ]
    
    private let tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private let topicViewModel: TopicViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        tableView.delegate = self
        tableView.dataSource = self
        setup()
        fetchData()
    }
    
    private func setup(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.right.left.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    init(viewModel: TopicViewModel) {
        self.topicViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchData(){
        topicViewModel.getTopic()
    }
    
}

extension EditorialViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        tableView.register(type(of: item).cellClass, forCellReuseIdentifier: type(of: item).reuseId)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        
        return cell
    }
}

extension EditorialViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
