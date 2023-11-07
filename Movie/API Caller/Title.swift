//
//  Title.swift
//  Movie
//
//  Created by AsherFelix on 11/1/23.
//

import Foundation
import  Alamofire
//    struct MovieReponse: Codable {
//        let page: Int
//        let results: [Movie]
//        let totalPages, totalResults: Int
//        enum CodingKeys: String, CodingKey {
//            case page, results
//            case totalPages = "total_pages"
//            case totalResults = "total_results"
//        }
//
//    }
//
//    struct Movie:Codable {
//        let adult: Bool
//        let backdropPath: String
//        let id: Int
//        let title: String
//        let originCountry: String
//        let originalLanguage: String
//        let originalName: String
//        let overview: String
//        let popularity: Double
//        let posterPath, firstAirDate, name: String
//        let voteAverage: Double
//        let voteCount: Int
//    }
struct MovieReponse: Codable {
    let page: Int
    let results: [Movie] // Đây là danh sách các bộ phim
    let totalPages, totalResults: Int
}

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int] // Một mảng các genre_ids
    let id: Int
    let originCountry: [String] // Một mảng các origin_country
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let firstAirDate: String // Trong mẫu dữ liệu của bạn, firstAirDate có dạng String
    let name: String
    let voteAverage: Double
    let voteCount: Int
}

