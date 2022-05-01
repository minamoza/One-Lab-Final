//
//  SearchResultPage.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 28.04.2022.
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
        cv.register(DiscoverCell.self, forCellWithReuseIdentifier: DiscoverCell.identifier)
        return cv
    }()
    
    var images1: [PhotoCell] = []
    
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
        
        collectionViewForPhoto.dataSource = self
        
        configureCollectionView()
        setUpCollectionViewItemSize()
        fetchData()
        bindViewModel()
    }
    
    private func fetchData(){
        photoViewModel.getPhotos(query: "blue")
    }
    
    private func bindViewModel(){
        photoViewModel.didLoadPhoto = { [self] photoDatas in
            for photo in photoDatas{
                let photoData = PhotoCell(photoImage: photo.urls.full, user: photo.user.firstName)
                images1.append(photoData)
            }
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

extension SearchResultPage: CustomLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return getSize(url: images1[indexPath.row].photoImage)
    }
}

extension SearchResultPage: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCell.identifier, for: indexPath) as! DiscoverCell
        cell.configure(data: images1[indexPath.row])
        return cell
    }
}

