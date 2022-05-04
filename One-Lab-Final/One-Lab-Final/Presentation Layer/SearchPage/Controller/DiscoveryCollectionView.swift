//
//  SearchPage.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 01.05.2022.
//

import UIKit
import SnapKit

class DiscoverCollectionView: UICollectionReusableView{
    
    static let identifier = "DiscoverCollectionView"
    
    
    private let collectionViewForPhoto: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
    }()


    var discoverCell: [CellConfigurator] = []
    var photosArray: [PhotoCellModel] = []
    
    private var photoViewModel: PhotoViewModel
    
//    init(viewModel: PhotoViewModel){
//        self.photoViewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.photoViewModel = PhotoViewModel(photoService: PhotoServiceImpl())
        
        configureCollectionView()
        setUpCollectionViewItemSize()
        fetchData()
        bindViewModel()
        
//        for category in categories{
//            categoryCell.append(CategoryCellConfigurator(item: CategoryModel(image: category, description: category)))
//        }
//
//        collectionViewForCategory.delegate = self
//        collectionViewForCategory.dataSource = self
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .systemBackground
//        
//        navigationItem.titleView = searchController.searchBar
//    
//        searchController.searchBar.delegate = self
//        
//        configureCollectionView()
//        setUpCollectionViewItemSize()
//        fetchData()
//        bindViewModel()
//        
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.obscuresBackgroundDuringPresentation = false
//        
//    }
    
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
            
            if !discoverCell.isEmpty{
                collectionViewForPhoto.reloadData()
            }
        }
        
    }
    
    private func configureCollectionView(){
        
        collectionViewForPhoto.dataSource = self
    
        addSubview(collectionViewForPhoto)
        
        collectionViewForPhoto.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setUpCollectionViewItemSize(){
        let customLayout = CustomLayout()
        customLayout.delegate = self
        collectionViewForPhoto.collectionViewLayout = customLayout
    }
    

}

extension DiscoverCollectionView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoverCell.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = discoverCell[indexPath.row]

        collectionView.register(type(of: item).cellClass, forCellWithReuseIdentifier: type(of: item).reuseId)
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)

        return cell
    }
    
}

//extension SearchPage: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                     withReuseIdentifier: HeaderCollectionView.identifier,
//                                                                     for: indexPath) as! HeaderCollectionView
//        header.configure()
//        return header
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
//   
//}

extension DiscoverCollectionView: CustomLayoutDelegate{
    
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: photosArray[indexPath.row].width, height: photosArray[indexPath.row].height)
    }
    
}


