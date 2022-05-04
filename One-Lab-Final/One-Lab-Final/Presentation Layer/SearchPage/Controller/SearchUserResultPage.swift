//
//  SearchUserResultPage.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import UIKit

class SearchUserResultPage: UIViewController {

    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let items: [CellConfigurator] = [
//        SearchUserCellConfigurator(item: UserTemp(profileImage: "test2", name: "Dalton Caraway", username: "crwy___")),
//        SearchUserCellConfigurator(item: UserTemp(profileImage: "test2", name: "green ant", username: "anantiscrawling")),
//        SearchUserCellConfigurator(item: UserTemp(profileImage: "test2", name: "Viridi Green", username: "virirdigreen")),
//        SearchUserCellConfigurator(item: UserTemp(profileImage: "test2", name: "Michael Green", username: "samolet24")),
//        SearchUserCellConfigurator(item: UserTemp(profileImage: "test2", name: "Charlie Green", username: "charliegreen998")),
//        SearchUserCellConfigurator(item: UserTemp(profileImage: "test2", name: "Desiray Green", username: "desiraygreen")),
//        SearchUserCellConfigurator(item: UserTemp(profileImage: "test2", name: "George Martin", username: "gcmartin")),
//        SearchUserCellConfigurator(item: UserTemp(profileImage: "test2", name: "Brandon Green", username: "brandgreen"))
   ]
   
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
        configureTableView()
        cellActionHandlers()
        view.backgroundColor = .darkGray
        containerView.backgroundColor = .black
        view.addSubview(containerView)
        containerView.snp.makeConstraints{
            $0.right.left.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func cellActionHandlers() {
        self.tableDirector.actionProxy
            .on(action: .didSelect) { (config: SearchUserCellConfigurator, cell) in
                print("hey")
               //create new VC = ProfilePage
              //  self.navigationController?.pushViewController(newVC, animated: true)
            }
            .on(action: .willDisplay) { (config: SearchUserCellConfigurator, cell) in
                cell.backgroundColor = .gray
         /*   }.on(action: .custom(UserCell.didTapButtonAction)){ (config: UserCellConfigurator, cell) in
                print("button did tap")
            }.on(action: .custom(UserCell.didTapFollowButtonAction)){ (config: UserCellConfigurator, cell) in
                print("follow button did tap")*/
            }
    }

}
