//
//  EditorialViewController.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 27.04.2022.
//

import UIKit

class EditorialViewController: UIViewController {

//    private let items: [CellConfigurator] = []
    private var topic: [EditorialModel] = []
    private var items = [[CellConfigurator]]()
    
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
        tableView.register(EditorialViewCell.self, forCellReuseIdentifier: EditorialViewCell.identifier)
        setup()
        fetchData()
        bindViewMode()
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
    
    private func bindViewMode(){
        topicViewModel.didLoadPhoto = { [weak self] photoDatas in
            for photo in photoDatas{
                let photoData = EditorialModel(imageName: photo.coverPhoto.urls.full
                )
                self?.topic.append(photoData)
            }
            self?.tableView.reloadData()
        }
    }
    
}

extension EditorialViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = topic[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EditorialViewCell.identifier, for: indexPath) as! EditorialViewCell
        cell.configure(data: topic[indexPath.row])
        
        return cell
    }
}

extension EditorialViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic.count
    }
}
