//
//  ProfilePage.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 26.04.2022.
//

import UIKit

class ProfilePage: UIViewController {
    
    var user: SearchedUsers?
    
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
    
    private let segmentedControl =  UISegmentedControl (items: ["Photos","Likes","Collections"])
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
        
        segmentedControl.addTarget(self, action: #selector(reloadPhoto), for: .valueChanged)
    }
    
    init(userViewModel: UserViewModel, userPhotoViewModel: UserPhotosViewModel){
        self.userViewModel = userViewModel
        self.userPhotosViewModel = userPhotoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func reloadPhoto(){
        userPhotos.removeAll()
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        if let user = user{
            switch selectedIndex
            {
            case 0:
                userPhotosViewModel.getPhotoss(username: user.username, param: "photos")
                bindUserPhotosViewModel()
            case 1:
                userPhotosViewModel.getPhotoss(username: user.username, param: "likes")
                bindUserPhotosViewModel()
            default:
                userPhotosViewModel.getPhotoss(username: user.username, param: "collections")
                bindUserPhotosViewModel()
            }
        }
    }
    
    private func createHeader(){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.25))
        
        header.addSubview(userPhoto)
        header.addSubview(username)
        header.addSubview(name)
        header.addSubview(segmentedControl)
        
        segmentedControl.selectedSegmentIndex = 0
        
        tableView.tableHeaderView = header
    }
    
    func fetchData(){
        userViewModel.getUsers(query: "nas")
    }
    
    private func bindUserViewModel(){
        userViewModel.didLoadPhoto = { [self] photoDatas in
            user = photoDatas[0]
            if let user = user{
                username.text = user.username
                name.text = user.name
                userPhoto.load(url: URL(string: user.profileImage.medium)!)
                userPhotosViewModel.getPhotoss(username: user.username, param: "photos")
                bindUserPhotosViewModel()
            }
        }
        
    }
    
    private func bindUserPhotosViewModel(){
//        userPhotos.removeAll()
        userPhotosViewModel.didLoadPhoto = { [self] photoDatas in
            for photo in photoDatas{
                let photoData = PhotoCellModel(photoImage: photo.urls.small, user: photo.user.firstName,
                                          width: Double(photo.width), height: Double(photo.height))
                userPhotos.append(photoData)
            }
            tableView.reloadData()
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
            make.top.equalToSuperview().offset(10)
        }

        username.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userPhoto.snp.bottom).offset(10)
        }

        name.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(username.snp.bottom).offset(10)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(name.snp.bottom).offset(10)
        }
    }
    
}

extension ProfilePage: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        switch selectedIndex{
        case 0:
           return userPhotos.count
        case 1:
            return userPhotos.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let url = userPhotos[indexPath.row].photoImage
        tableView.register(ProfilePhotoCell.self, forCellReuseIdentifier: ProfilePhotoCell.identifier)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePhotoCell.identifier, for: indexPath) as! ProfilePhotoCell
        cell.configureCell(photoUrl: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = DetailedPhotoPage(imageUrl: userPhotos[indexPath.row].photoImage, titleText: userPhotos[indexPath.row].user)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    
}
