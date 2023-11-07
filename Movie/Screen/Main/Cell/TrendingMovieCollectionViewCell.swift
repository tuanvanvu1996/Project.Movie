//
//  TrendingMovieCollectionViewCell.swift
//  Movie
//
//  Created by AsherFelix on 11/2/23.
//

import UIKit
import Kingfisher
class TrendingMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trendingMovieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with image:Movie) {
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(image.posterPath)") {
            trendingMovieImage.kf.setImage(with: imageUrl)
            
        }
    }

}
