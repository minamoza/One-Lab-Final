//
//  MainPage.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 02.05.2022.
//

import UIKit

class MainPage: UITabBarController {
    
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let myFeed = FeedPage()
        let searchPage = SearchPage(viewModel: PhotoViewModel(photoService: GetPhotoServiceImpl()))
//        let myPins = MyPinsVC()
//        let myProfile = MyProfileVC()
        
        myFeed.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        searchPage.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
//        searchPage.navigationItem.titleView = searchBar
        
        let controllers = [myFeed, searchPage]
        self.viewControllers = controllers
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}

        
//        self.setViewControllers([myFeed, searchPage], animated: false)
        
//        guard let items = self.tabBar.items else { return }
//
//        let images = ["globe", "person.2.fill"]
//
//        for i in 0..<images.count{
//            items[i].image = UIImage(systemName: images[i])
//        }
        
        selectedIndex = 0
    }

}
