//
//  UserService.swift
//  One-Lab-Final
//
//  Created by Amina Moldamyrza on 04.05.2022.
//

import Foundation
import Alamofire

protocol UserService{
    func getUsers(success:@escaping ([SearchedUsers]) -> Void, failure:@escaping (Error) -> Void, query: String)
}

class UserServiceImpl: UserService{
    
    func getUsers(success:@escaping ([SearchedUsers]) -> Void, failure:@escaping (Error) -> Void, query: String) {
        let urlString = String(format: "%@/search/users", EndPoint.baseurl)
        guard let url = URL(string: urlString) else { return }
        
        let queryParams: Parameters = ["client_id": EndPoint.apiKey, "page": "1", "query": query]
        AF.request(url, method: .get, parameters: queryParams).responseDecodable{(response: DataResponse<Users, AFError>) in

            switch response.result{
            case .success(let collectionData):
                success(collectionData.results)
            case .failure(let error):
                print(error)
                failure(error)
            }
        }
    }
}

struct Users: Codable {
    let total, totalPages: Int
    let results: [SearchedUsers]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct SearchedUsers: Codable {
    let id, username, name, firstName: String
//    let lastName, instagramUsername: String
//    let totalLikes, totalPhotos, totalCollections: String
    let profileImage: ProfileImage
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case firstName = "first_name"
//        case lastName = "last_name"
//        case instagramUsername = "instagram_username"
//        case totalLikes = "total_likes"
//        case totalPhotos = "total_photos"
//        case totalCollections = "total_collections"
        case profileImage = "profile_image"
        case links
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: String
    let html: String
    let photos, likes: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes
    }
}

