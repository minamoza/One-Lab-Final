//
//  SearchCollectionsPage.swift
//  One-Lab-Final
//
//  Created by aya on 04.05.2022.
//

import UIKit
import SnapKit

class SearchCollectionsPage: UIViewController{
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView (frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let viewLayout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(viewLayout, animated: true)
        viewLayout.scrollDirection = .vertical
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        collectionView.backgroundColor = .black
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        layoutSubviews()
        collectionView.register(SearchCollectionsCell.self, forCellWithReuseIdentifier: "SearchCollectionsCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionsCell", for: indexPath) as! SearchCollectionsCell
        cell.configure( collectionCellHeight:  (collectionView.bounds.size.height) / 2.7)
        return  cell
    }
    
   func collectionView(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
}

extension SearchCollectionsPage: UICollectionViewDelegateFlowLayout{
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let width = (UIScreen.main.bounds.size.width - 3 * 10)
          let height = (collectionView.bounds.size.height) / 2.7
          return CGSize(width: width, height: height)
      }
}

