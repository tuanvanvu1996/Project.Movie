//
//  OnBoardSlide.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import Foundation
import UIKit
struct OnBoardSlide {
    var image: String
    var title: String
    var description:String
    static var onBoard: [OnBoardSlide] = [OnBoardSlide(image: "onboard1", title: "Welcome to the MovieUniverse", description: "Explore the world of cinema, discover the latest blockbusters, and dive into the magic of movies. Get ready for an unforgettable cinematic journey!"),OnBoardSlide(image: "onboard2", title: "Your Movie Universe", description: "Create your watchlist, read reviews, and stay up-to-date with all things movies. Your one-stop destination for all movie enthusiasts."),OnBoardSlide(image: "onboard3", title: "Start Watching Today", description: "It's time to start your movie adventure. Sign up and begin your cinematic experience. MovieMania is your ticket to entertainment!")]
}
