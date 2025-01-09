//
//  MovieModel.swift
//  MovieApp
//
//  Created by supaja on 2023/02/05.
//

// this File is
// data structure (API)

import Foundation

struct MovieModel: Codable {
    let resultCount: Int
    let results: [Result]
}

// ref. postman
struct Result: Codable {
    let trackName: String //없을 수도 있다면 ?(optional)
    let previewUrl: String
    let image: String
    let shortDescription: String?
    let longDescription: String
    let trackPrice: Double
    let currency: String
    let releaseDate: String
    
    // 다른 이름으로 사용하기
    enum CodingKeys: String, CodingKey {
        case image = "artworkUrl100"
        case trackName
        case previewUrl
        case shortDescription
        case longDescription
        case trackPrice
        case currency
        case releaseDate
    }
}

