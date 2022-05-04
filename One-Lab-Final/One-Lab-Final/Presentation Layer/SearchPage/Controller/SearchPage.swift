//
//  SearchPage.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
//

import UIKit
import SnapKit

enum Section: Int, CaseIterable {
   case categorySection = 0, discoverSection
}

class SearchPage: UIViewController, UISearchControllerDelegate {
    
    private let searchControler = UISearchController()
    private let collectionViewForCategory: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private let collectionViewForPhoto: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
    }()
 
    private var categoryLabel = UILabel()
    private var discoverLabel = UILabel()
    private var cellBuilder = CollectionCellBuilder()
    
    private var categories: [String] = ["Nature", "Black and White", "Space", "Textures", "Minimal", "Animals", "Travel", "Underwater", "Architecture", "Sky", "Flowers", "Abstract"]
    
    private var categoryCell: [CellConfigurator] = []
    private var discoverCell: [CellConfigurator] = []
    private var items = [[CellConfigurator]]()
    private var photosArray: [PhotoCellModel] = []
    private var sections: [Section] = [.categorySection, .discoverSection]
    
    private let photoViewModel: PhotoViewModel
    
    init(viewModel: PhotoViewModel){
        self.photoViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.titleView = searchControler.searchBar
        
        for category in categories{
            categoryCell.append(CategoryCellConfigurator(item: CategoryCellModel(image: category, description: category)))
        }
        
        configureCollectionView()
        setUpCollectionViewItemSize()
        fetchData()
        bindViewModel()
        
        collectionViewForCategory.delegate = self
        collectionViewForCategory.dataSource = self
        collectionViewForPhoto.dataSource = self
        collectionViewForPhoto.delegate = self
        searchControler.searchBar.delegate = self
        
//        searchBar.hidesNavigationBarDuringPresentation = false
        
        items.append(categoryCell)
        items.append(discoverCell)
        
    }
    
    private func fetchData(){
        photoViewModel.getPhotos()
    }
    
    private func bindViewModel(){
        photoViewModel.didLoadPhoto = { [self] photoDatas in
            for photo in photoDatas{
                let photoData = PhotoCellModel(photoImage: photo.urls.small, user: photo.user.firstName,
                                          width: Double(photo.width), height: Double(photo.height))
                discoverCell.append(DiscoverCellConfigurator(item: photoData))
                photosArray.append(photoData)
            }
            collectionViewForPhoto.reloadData()
            collectionViewForCategory.reloadData()
        }
        
    }
    
    private func configureCollectionView(){
        categoryLabel = makeLabel(text: "Browse By Category")
        discoverLabel = makeLabel(text: "Discover")
        
        view.addSubview(categoryLabel)
        view.addSubview(discoverLabel)
        view.addSubview(collectionViewForCategory)
        view.addSubview(collectionViewForPhoto)
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(130)
            make.left.equalTo(view.snp.left).offset(10)
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
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        collectionViewForPhoto.snp.makeConstraints { make in
            make.top.equalTo(discoverLabel.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalToSuperview()
        }
    }
    
    private func setUpCollectionViewItemSize(){
        let customLayout = CustomLayout()
        customLayout.delegate = self
        collectionViewForPhoto.collectionViewLayout = customLayout
    }
    
    private func makeLabel(text: String) -> UILabel {
        let sectionLabel = UILabel()
        sectionLabel.font = .boldSystemFont(ofSize: 25)
        sectionLabel.textColor = .label
        sectionLabel.sizeToFit()
        sectionLabel.text = text
        return sectionLabel
    }
    

}

extension SearchPage: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewForCategory{
            return categoryCell.count
        }
        return discoverCell.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var item: CellConfigurator?
        
        if collectionView == collectionViewForCategory{
            item = categoryCell[indexPath.row]
        }else if collectionView == collectionViewForPhoto{
            item = discoverCell[indexPath.row]
        }
        
        collectionView.register(type(of: item!).cellClass, forCellWithReuseIdentifier: type(of: item!).reuseId)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item!).reuseId, for: indexPath)
        item!.configure(cell: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case collectionViewForCategory:
            let newVC = SearchPhotoPage(viewModel: SearchedPhotoViewModel(photoService: GetSearchedPhotoImpl()))
            newVC.fetchData(query: categories[indexPath.row])
            self.navigationController?.pushViewController(newVC, animated: true)
        default:
            let newVC = DetailedPhotoPage(imageUrl: photosArray[indexPath.row].photoImage, titleText: photosArray[indexPath.row].user)
            self.navigationController?.pushViewController(newVC, animated: true)
        }
        
    }
    
}

extension SearchPage:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height * 0.45, height: collectionView.frame.height * 0.45)
    }
}

extension SearchPage: CustomLayoutDelegate{
    
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: photosArray[indexPath.row].width, height: photosArray[indexPath.row].height)
    }
    
}

extension SearchPage: UISearchBarDelegate, UISearchDisplayDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
//        let newVC = SearchPhotoPage(viewModel: SearchedPhotoViewModel(photoService: GetSearchedPhotoImpl()))
//        newVC.fetchData(query: searchText)
//        self.navigationController?.pushViewController(newVC, animated: true)
        
        let newVC = SearchResultPage()
        newVC.searchPhotosVC.fetchData(query: searchText)
        newVC.searchText = searchText
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
}
