//
//  SearchedPage.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import UIKit

class SearchResultPage: UIViewController {

    lazy var searchText = ""
    lazy var searchUsersVC = SearchUserResultPage()
    lazy var searchCollectionsVC = SearchCollectionsPage()
//    lazy var searchPhotosVC = SearchPhotoResultPage(viewModel: SearchedPhotoViewModel(photoService: GetSearchedPhotoImpl()))
    lazy var searchPhotosVC = SearchPhotoPage(viewModel: SearchedPhotoViewModel(photoService: GetSearchedPhotoImpl()))

    
    private let searchController : UISearchController = {
        let searchController = UISearchController()
       
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.scopeButtonTitles = ["Photos", "Collections", "Users"]
        searchController.searchBar.selectedScopeButtonIndex = 0
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.backgroundColor = .black
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        add(searchUsersVC)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.placeholder = searchText
        searchController.automaticallyShowsCancelButton = true
        
    }

}

extension UIViewController {
    func add(_ child: UIViewController){
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(){
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension SearchResultPage : UISearchControllerDelegate{
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
     print ("update")
    }
    
    
}

extension SearchResultPage: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let scope = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        
        if scope == "Collections" {
            searchUsersVC.remove()
            searchPhotosVC.remove()
            add(searchCollectionsVC)
        }
        
        if scope == "Users" {
            searchPhotosVC.remove()
            searchCollectionsVC.remove()
            add(searchUsersVC)
        }
        
        if scope == "Photos" {
            searchUsersVC.remove()
            searchCollectionsVC.remove()
            add(searchPhotosVC)
        }
    }
    

   

}
