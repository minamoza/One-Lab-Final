//
//  SearchUserTableViewCell.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import UIKit

typealias SearchUserCellConfigurator = TableCellConfigurator<SearchUserTableViewCell, UserCellModel>

class SearchUserTableViewCell : UITableViewCell, ConfigurableCell {
    
    typealias DataType = UserCellModel
    
    static let didTapUserCellAction = "UserCellDidTapButtonAction"
    
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderWidth = 0
        avatarImageView.layer.masksToBounds = false
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        return avatarImageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .white
        return nameLabel
    }()
    
    private let usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 12)
        usernameLabel.textColor = .lightGray
        return usernameLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ nameLabel, usernameLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
    
   /* @objc private func didTapUserCell() {
        CellAction.custom(type(of: self).didTapUserCellAction).invoke(cell: self)
    }*/

    func configure(data: UserCellModel) {
        avatarImageView.load(url: URL(string: data.photoImage)!)
        nameLabel.text = data.name
        usernameLabel.text = data.username
    }
    
    private func layoutUI() {
        configureImageView()
        confgigureStackView()
        contentView.backgroundColor = .darkGray
    }
    
    private func configureImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(70)
        }
    }
    
    private func confgigureStackView() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
    }
}
