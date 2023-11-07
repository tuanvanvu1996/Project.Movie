//
//  YoutubeResponse.swift
//  Movie
//
//  Created by AsherFelix on 11/7/23.
//

import Foundation

struct YoutubeResponse:Codable {
    let items:  [VideoElements]
}
struct VideoElements:Codable {
    let id: IdVideoElement
}

struct IdVideoElement:Codable {
    let kind: String
    let videoId: String
}
