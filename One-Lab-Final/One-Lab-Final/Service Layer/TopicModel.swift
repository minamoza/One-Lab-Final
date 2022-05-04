//
//  TopicModel.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 04.05.2022.
//

import Foundation

struct Topic: Codable {
    let id, slug, title: String
    let onlySubmissionsAfter: JSONNull?
    let featured: Bool?
    let totalPhotos: Int?
//    let links: WelcomeLinks?
    let status: String?
    let owners: [User]?
    let currentUserContributions: [JSONAny]
    let coverPhoto: CoverPhoto

    enum CodingKeys: String, CodingKey {
        case id, slug, title
        case onlySubmissionsAfter = "only_submissions_after"
        case featured
        case totalPhotos = "total_photos"
        case status
        case owners
        case currentUserContributions = "current_user_contributions"
        case coverPhoto = "cover_photo"
    }
}
struct CoverPhoto: Codable {
    let id: String?
    let width, height: Int?
    let color, blurHash, coverPhotoDescription, altDescription: String?
    let urls: Urls
    let links: CoverPhotoLinks?
    let user: User?
    let previewPhotos: [PreviewPhoto]?

    enum CodingKeys: String, CodingKey {
        case id
        case width, height, color
        case blurHash = "blur_hash"
        case coverPhotoDescription = "description"
        case altDescription = "alt_description"
        case urls, links, user
        case previewPhotos = "preview_photos"
    }
}

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
