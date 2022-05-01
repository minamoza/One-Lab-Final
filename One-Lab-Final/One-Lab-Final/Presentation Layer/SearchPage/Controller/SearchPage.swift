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

class SearchPage: UIViewController {
    
    private let searchBar = UISearchBar()
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
//        cv.isScrollEnabled = false
        return cv
    }()
 
    private var categoryLabel = UILabel()
    private var discoverLabel = UILabel()
    private var cellBuilder = CollectionCellBuilder()
    
    private var categoryCell: [CellConfigurator] = []
    private var discoverCell: [CellConfigurator] = []
    private var items = [[CellConfigurator]]()
    private var photosArray: [PhotoCell] = []
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
        
        configureCollectionView()
        setUpCollectionViewItemSize()
        fetchData()
        bindViewModel()
        
        collectionViewForCategory.delegate = self
        collectionViewForCategory.dataSource = self
        collectionViewForPhoto.dataSource = self
        collectionViewForPhoto.delegate = self
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
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
                let photoData = PhotoCell(photoImage: photo.urls.full, user: photo.user.firstName)
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
    
    func getSize(url: String) -> CGSize{
        if let photoURL = URL(string: url){
            if let data = try? Data(contentsOf: photoURL) {
                if let image = UIImage(data: data) {
                    return image.size
                }
            }
        }
        return CGSize()
    }

}

extension SearchPage: UICollectionViewDataSource{
    
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
}

extension SearchPage:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height * 0.45, height: collectionView.frame.height * 0.45)
    }
}

extension SearchPage: CustomLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return getSize(url: photosArray[indexPath.row].photoImage)
    }
}

extension SearchPage: UISearchBarDelegate, UISearchDisplayDelegate{
    
}
