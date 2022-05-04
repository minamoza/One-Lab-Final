//
//  TopicService.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 04.05.2022.
//

import Foundation
import AlamofireImage
import Alamofire

protocol GetTopicService{
    func getTopic(success:@escaping ([Topic]) -> Void, failure:@escaping (Error) -> Void)
}

class GetTopicImpl: GetTopicService{
    func getTopic(success:@escaping ([Topic]) -> Void, failure:@escaping (Error) -> Void){
        let urlString = String(format: "%@/topics", EndPoint.baseurl)
        guard let url = URL(string: urlString) else { return }
        
        let queryParams: Parameters = ["client_id": EndPoint.apiKey]
        AF.request(url, method: .get, parameters: queryParams).responseDecodable{(response: DataResponse<[Topic], AFError>) in
            switch response.result{
            case .success(let topic):
                success(topic)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Topic: Codable {
    let id, slug, title: String?
    let publishedAt, updatedAt, startsAt, endsAt: Date?
//    let onlySubmissionsAfter: JSONNull?
    let featured: Bool?
    let totalPhotos: Int?
    let links: WelcomeLinks?
    let status: String?
    let owners: [User]?
//    let currentUserContributions: [JSONAny]
//    let totalCurrentUserSubmissions: TotalCurrentUserSubmissions
    let coverPhoto: CoverPhoto?

    enum CodingKeys: String, CodingKey {
        case id, slug, title
//        case welcomeDescription = "description"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
//        case onlySubmissionsAfter = "only_submissions_after"
        case featured
        case totalPhotos = "total_photos"
        case links, status
        case owners
//        case currentUserContributions = "current_user_contributions"
//        case totalCurrentUserSubmissions = "total_current_user_submissions"
        case coverPhoto = "cover_photo"
    }
}

// MARK: - CoverPhoto
struct CoverPhoto: Codable {
    let id: String?
    let createdAt, updatedAt: Date?
//    let promotedAt: JSONNull?
    let width, height: Int?
    let color, blurHash, coverPhotoDescription, altDescription: String?
    let urls: Urls?
    let links: CoverPhotoLinks?
    let user: User?
    let previewPhotos: [PreviewPhoto]?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
//        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case coverPhotoDescription = "description"
        case altDescription = "alt_description"
        case urls, links, user
        case previewPhotos = "preview_photos"
    }
}

// MARK: - CoverPhotoLinks
struct CoverPhotoLinks: Codable {
    let linksSelf, html, download, downloadLocation: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - PreviewPhoto
struct PreviewPhoto: Codable {
    let id: String?
    let createdAt, updatedAt: Date?
    let urls: Urls?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case urls
    }
}

// MARK: - TotalCurrentUserSubmissions
struct TotalCurrentUserSubmissions: Codable {
}
