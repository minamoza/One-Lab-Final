//
//  SearchCollectionsPage.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import UIKit
import SnapKit

class SearchCollectionsPage: UIViewController{
    
    var searchText = ""
    
    private let collectionViewModel: CollectionViewModel
    
    private var collections: [CellConfigurator] = []
    private var collectionData: [CategoryCellModel] = []
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView (frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let viewLayout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(viewLayout, animated: true)
        viewLayout.scrollDirection = .vertical
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    init(collectionViewModel: CollectionViewModel){
        self.collectionViewModel = collectionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData(query: String){
        collectionViewModel.getPhotos(query: query)
        bindCollectionViewModel()
    }
    
    func bindCollectionViewModel(){
        collectionViewModel.didLoadPhoto = { [self] userDatas in
            for user in userDatas{
                let data = CategoryCellModel(image: user.coverPhoto.urls.small, description: user.title)
                collectionData.append(data)
                collections.append(CategoryCellConfigurator(item: data))
            }
            if !collections.isEmpty{
                collectionView.reloadData()
            }
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        layoutSubviews()
        collectionView.register(CategorySubCell.self, forCellWithReuseIdentifier: CategorySubCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchData(query: searchText)
        
    }
    
    func layoutSubviews(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.right.left.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}




extension SearchCollectionsPage: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        }
}

extension SearchCollectionsPage: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySubCell.identifier, for: indexPath) as! CategorySubCell
        cell.configure(data: collectionData[indexPath.row])
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
}

extension SearchCollectionsPage: UICollectionViewDelegateFlowLayout{
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let height = (collectionView.bounds.size.height) / 2.7
          return CGSize(width: view.frame.width, height: height)
      }
}

