//
//  SearchUserResultPage.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import UIKit

class SearchUserResultPage: UIViewController {
    
    private let userViewModel: UserViewModel
    private var users: [SearchedUsers] = []

    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private var items: [CellConfigurator] = []
   
   private lazy var tableDirector: TableDirector = {
       let tableDirector = TableDirector(tableView: tableView, items: items)
       return tableDirector
   }()
   
   private let tableView: UITableView = {
       let tableView = UITableView()
       return tableView
   }()
    
   private func configureTableView() {
       containerView.addSubview(tableView)
       tableView.snp.makeConstraints {
           $0.leading.equalTo(containerView.snp.leading).offset(10)
           $0.trailing.equalTo(containerView.snp.trailing).offset(-10)
           $0.top.equalTo(containerView.snp.top)
           $0.bottom.equalToSuperview()
       }
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = .black
        view.backgroundColor = .darkGray
        view.addSubview(containerView)
        
        cellActionHandlers()
        
        containerView.snp.makeConstraints{
            $0.right.left.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        configureTableView()
    }
    
    init(userViewModel: UserViewModel){
        self.userViewModel = userViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData(query: String){
        userViewModel.getUsers(query: query)
        bindUserViewModel()
    }
    
    func bindUserViewModel(){
        userViewModel.didLoadPhoto = { [self] userDatas in
            for user in userDatas{
                users.append(user)
                let data = UserCellModel(photoImage: user.profileImage.small, name: user.name, username: user.username)
                items.append(SearchUserCellConfigurator(item: data))
            }
            if !items.isEmpty{
//                tableView.reloadData()
                tableDirector.items = items
                tableDirector.tableView.reloadData()
            }
        }
        
    }
    
    private func cellActionHandlers() {
        self.tableDirector.actionProxy
            .on(action: .didSelect) { (config: SearchUserCellConfigurator, cell) in
                let newVC = ProfilePage(userPhotoViewModel: UserPhotosViewModel(userService: UserPhotosServiceImpl()))
                newVC.bindUserViewModel(user: config.item)
                self.navigationController?.pushViewController(newVC, animated: true)
            }
            .on(action: .willDisplay) { (config: SearchUserCellConfigurator, cell) in
                
         /*   }.on(action: .custom(UserCell.didTapButtonAction)){ (config: UserCellConfigurator, cell) in
                print("button did tap")
            }.on(action: .custom(UserCell.didTapFollowButtonAction)){ (config: UserCellConfigurator, cell) in
                print("follow button did tap")*/
            }
    }

}
