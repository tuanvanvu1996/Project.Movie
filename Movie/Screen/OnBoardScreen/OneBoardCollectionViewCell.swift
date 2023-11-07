//
//  OneBoardCollectionViewCell.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit

class OneBoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageOnBoard: UIImageView!
    func configue(image:UIImage) {
        imageOnBoard.image = image
    }
}
