//
//  SearchPage.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 26.04.2022.
//

import UIKit

class SearchResultPage: UIViewController {
    
    private let collectionViewForPhoto: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(DiscoverSubCell.self, forCellWithReuseIdentifier: DiscoverSubCell.identifier)
        return cv
    }()
    
    var images1: [PhotoCellModel] = []
    
    private let photoViewModel: SearchedPhotoViewModel
    
    init(viewModel: SearchedPhotoViewModel){
        self.photoViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureCollectionView()
    }
    
    func fetchData(query: String){
        photoViewModel.getPhotos(query: query)
        bindViewModel()
        setUpCollectionViewItemSize()
    }
    
    private func bindViewModel(){
        photoViewModel.didLoadPhoto = { [self] photoDatas in
            for photo in photoDatas{
                let photoData = PhotoCellModel(photoImage: photo.urls.small, user: photo.user.firstName,
                                          width: Double(photo.width), height: Double(photo.height))
                images1.append(photoData)
            }
            collectionViewForPhoto.dataSource = self
            collectionViewForPhoto.delegate = self
            collectionViewForPhoto.reloadData()
        }
        
    }
    
    private func configureCollectionView(){
        view.addSubview(collectionViewForPhoto)
        collectionViewForPhoto.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setUpCollectionViewItemSize(){
        let customLayout = CustomLayout()
        customLayout.delegate = self
        collectionViewForPhoto.collectionViewLayout = customLayout
    }
    

}

extension SearchResultPage: CustomLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: images1[indexPath.row].width, height: images1[indexPath.row].height)
    }
}

extension SearchResultPage: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverSubCell.identifier, for: indexPath) as! DiscoverSubCell
        cell.configure(data: images1[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images1.count
    }
    
}

extension SearchResultPage: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newVC = DetailedPhotoPage(imageUrl: images1[indexPath.row].photoImage, titleText: images1[indexPath.row].user)
        self.navigationController?.pushViewController(newVC, animated: true)

    }
}
