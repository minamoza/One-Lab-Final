//
//  HeaderCollectionView.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 02.05.2022.
//

import UIKit

class HeaderCollectionView: UIViewController {
    
    private let searchController = UISearchController()
    
    private let collectionViewForCategory: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(DiscoverCollectionView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: DiscoverCollectionView.identifier)
        return cv
    }()
    
    private var categoryLabel: UILabel = {
        let sectionLabel = UILabel()
        sectionLabel.font = .boldSystemFont(ofSize: 25)
        sectionLabel.textColor = .label
        sectionLabel.sizeToFit()
        sectionLabel.text = "Browse By Category"
        return sectionLabel
    }()
    
    private var discoverLabel: UILabel = {
        let sectionLabel = UILabel()
        sectionLabel.font = .boldSystemFont(ofSize: 25)
        sectionLabel.textColor = .label
        sectionLabel.sizeToFit()
        sectionLabel.text = "Discovery"
        return sectionLabel
    }()
    
    private var categories: [String] = ["Nature", "Black and White", "Space", "Textures", "Minimal", "Animals", "Travel", "Underwater", "Architecture", "Sky", "Flowers", "Abstract"]
    
    private var categoryCell: [CellConfigurator] = []
    
    public func configure() {
        
        view.addSubview(categoryLabel)
        view.addSubview(collectionViewForCategory)
        view.addSubview(discoverLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        collectionViewForCategory.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.height.equalTo(view.frame.height * 0.35)
            make.width.equalToSuperview()
        }
        
        discoverLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionViewForCategory.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        for category in categories{
//            categoryCell.append(CategoryCellConfigurator(item: CategoryModel(image: category, description: category)))
//        }
//
//        collectionViewForCategory.delegate = self
//        collectionViewForCategory.dataSource = self
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.titleView = searchController.searchBar
    
        searchController.searchBar.delegate = self
        
        for category in categories{
            categoryCell.append(CategoryCellConfigurator(item: CategoryCellModel(image: category, description: category)))
        }
        
        configure()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        collectionViewForCategory.dataSource = self
        collectionViewForCategory.delegate = self
        
    }
}

extension HeaderCollectionView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return categoryCell.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var item: CellConfigurator?
        
        if collectionView == collectionViewForCategory{
            item = categoryCell[indexPath.row]
        }
        
        collectionView.register(type(of: item!).cellClass, forCellWithReuseIdentifier: type(of: item!).reuseId)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item!).reuseId, for: indexPath)
        item!.configure(cell: cell)
        
        return cell
    }
}

extension HeaderCollectionView: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height * 0.45, height: collectionView.frame.height * 0.45)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: DiscoverCollectionView.identifier,
                                                                     for: indexPath) as! DiscoverCollectionView
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 12)
    }
}

extension HeaderCollectionView: UISearchBarDelegate, UISearchDisplayDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        let newVC = SearchResultPage()
        newVC.searchPhotosVC.fetchData(query: searchText)
        newVC.searchText = searchText
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newVC = SearchPhotoResultPage(viewModel: SearchedPhotoViewModel(photoService: GetSearchedPhotoImpl()))
       
   //     let newVC = SearchResultPage(viewModel: SearchedPhotoViewModel(photoService: GetSearchedPhotoImpl()))
        newVC.fetchData(query: categories[indexPath.row])
        self.navigationController?.pushViewController(newVC, animated: true)
    
}
}
