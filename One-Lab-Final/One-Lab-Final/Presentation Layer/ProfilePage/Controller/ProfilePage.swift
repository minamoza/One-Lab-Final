//
//  ProfilePage.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 26.04.2022.
//

import UIKit

class ProfilePage: UIViewController {
    
    private let userViewModel: UserViewModel
    private let userPhotosViewModel: UserPhotosViewModel
    
    private let tableView = UITableView()
    
    private let userPhoto: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        img.layer.cornerRadius = img.frame.width/2
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let username: UILabel = {
        let sectionLabel = UILabel()
        sectionLabel.font = .boldSystemFont(ofSize: 25)
        sectionLabel.textColor = .label
        sectionLabel.sizeToFit()
        return sectionLabel
    }()
    
    private let segmentedController =  UISegmentedControl (items: ["Photos","Likes","Collections"])
    private let name = UILabel()
    
    private var userPhotos: [PhotoCellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain,
                                                            target: self, action: nil)
        view.backgroundColor = .systemBackground
        createHeader()
        configureConstraints()
        fetchData()
        bindUserViewModel()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    init(userViewModel: UserViewModel, userPhotoViewModel: UserPhotosViewModel){
        self.userViewModel = userViewModel
        self.userPhotosViewModel = userPhotoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createHeader(){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.25))
        
        header.addSubview(userPhoto)
        header.addSubview(username)
        header.addSubview(name)
        header.addSubview(segmentedController)
        
        segmentedController.selectedSegmentIndex = 0
        
        tableView.tableHeaderView = header
    }
    func fetchData(){
        userViewModel.getUsers(query: "nas")
    }
    
    private func bindUserViewModel(){
        userViewModel.didLoadPhoto = { [self] photoDatas in
            var user: SearchedUsers
            user = photoDatas[0]
            username.text = user.username
            name.text = user.name
            userPhoto.load(url: URL(string: user.profileImage.medium)!)
            userPhotosViewModel.getPhotoss(username: user.username, param: "likes")
            bindUserPhotosViewModel()
//            collectionViewForPhoto.dataSource = self
//            collectionViewForPhoto.delegate = self
//            collectionViewForPhoto.reloadData()
        }
        
    }
    
    private func bindUserPhotosViewModel(){
        userPhotosViewModel.didLoadPhoto = { [self] photoDatas in
            for photo in photoDatas{
                let photoData = PhotoCellModel(photoImage: photo.urls.small, user: photo.user.firstName,
                                          width: Double(photo.width), height: Double(photo.height))
                userPhotos.append(photoData)
            }
//            collectionViewForPhoto.dataSource = self
//            collectionViewForPhoto.delegate = self
//            collectionViewForPhoto.reloadData()
        }
    }
    
    func configureConstraints(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userPhoto.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }

        username.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userPhoto.snp.bottom).offset(10)
        }

        name.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(username.snp.bottom).offset(10)
        }
        
        segmentedController.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(name.snp.bottom).offset(10)
        }
    }
    
}

extension ProfilePage: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        let selectedIndex = self.segmentedControl.selectedSegmentIndex
//        switch selectedIndex
//        {
//        case 0:
//            return peopleArray.count
//        case 1:
//            return imagesArray.count
//        //Add other cases here
//        default:
//            return 0
//        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
//        let selectedIndex = self.segmentedControl.selectedSegmentIndex
//        switch selectedIndex
//        {
//        case 0:
//            return tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) //Do your custom handling whatever required.
//        case 1:
//            return tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
//        //Add other cases here
//        default:
//            return UITableViewCell()
//        }
        
        return UITableViewCell()
    }
    
    
}
