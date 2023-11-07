//
//  TrendingMovieTableViewCell.swift
//  Movie
//
//  Created by AsherFelix on 11/2/23.
//

import UIKit
import Alamofire
import Kingfisher
class TrendingMovieTableViewCell: UITableViewCell {
    var movies = [MovieReponse]()
    @IBOutlet weak var trendingMovieCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 5
        trendingMovieCollection.collectionViewLayout = flowLayout
        trendingMovieCollection.showsHorizontalScrollIndicator = true
        trendingMovieCollection.dataSource = self
        trendingMovieCollection.delegate = self
        let trendingMovieNib = UINib(nibName: "TrendingMovieCollectionViewCell", bundle: nil)
        trendingMovieCollection.register(trendingMovieNib, forCellWithReuseIdentifier: "TrendingMovieCollectionViewCell")
    }
}
extension TrendingMovieTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let trendingMovieCollectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMovieCollectionViewCell", for: indexPath) as! TrendingMovieCollectionViewCell
        let movieReponse = movies[indexPath.item]
        let movie = movieReponse.results[indexPath.row]
        trendingMovieCollectCell.configure(with: movie)
        return trendingMovieCollectCell
    }
    
    
}
