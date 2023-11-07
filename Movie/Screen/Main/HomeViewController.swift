//
//  HomeViewController.swift
//  Movie
//
//  Created by AsherFelix on 11/1/23.
//

import UIKit
import Kingfisher
import Alamofire
class HomeViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var homeTableView: UITableView!
    var movieReponse = [MovieReponse]()
    var movies = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        let trendingMovieCell = UINib(nibName: "TrendingMovieTableViewCell", bundle: nil)
        homeTableView.register(trendingMovieCell, forCellReuseIdentifier: "TrendingMovieTableViewCell")
        callApiPopular()
    }
//    func  callApiPopular() {
//        let apiKey = "b11178c07ba517d41d162f0aefa2edfc"
//        let baseUrl = "https://api.themoviedb.org/3/movie/popular"
//        let parameters: [String:Any] = [
//            "api_key": apiKey,
//            "language": "en-US",
//            "page": 1
//        ]
//        AF.request(baseUrl,method: .get,
//                           parameters: parameters,
////                           encoder: URLEncodedFormParameterEncoder.default,
//                           headers: [
//                            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMTExNzhjMDdiYTUxN2Q0MWQxNjJmMGFlZmEyZWRmYyIsInN1YiI6IjY0ZjFjY2UyNWYyYjhkMDBjNDMyMzc3YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1BHamevvFKiKyJpH9rz9I78eApq0ydDhNTL5dANGfxk"
//
//
//                           ])
//                .validate(statusCode: 200..<299)
//                .responseDecodable(of: MovieReponse.self) { (afDataResponse) in
//                    switch afDataResponse.result {
//                    case .success(let data):
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            self.movies = data.results
//                            self.homeTableView.reloadData()
//                        }
//                        break
//                    case .failure(let err):
//                        print(err.errorDescription)
//                        break
//                    }
//                }
    func callApiPopular() {
            let apiKey = "b11178c07ba517d41d162f0aefa2edfc"
            let baseUrl = "https://api.themoviedb.org/3/movie/popular"
            
            let parameters: [String: Any] = [
                "api_key": apiKey,
                "page": 1
            ]
            
            AF.request(baseUrl, method: .get, parameters: parameters)
                .validate(statusCode: 200..<299)
                .responseDecodable(of: MovieReponse.self) { (afDataResponse) in
                    switch afDataResponse.result {
                    case .success(let data):
                        self.movies = data.results
                        self.homeTableView.reloadData()
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
    }
    @IBAction func searchBtn(_ sender: Any) {
    }
    
}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieReponse.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trendingMovieCell = tableView.dequeueReusableCell(withIdentifier: "TrendingMovieTableViewCell", for: indexPath) as! TrendingMovieTableViewCell
        trendingMovieCell.movies = movieReponse
//        trendingMovieCell.trendingMovieCollection.reloadData()
        return trendingMovieCell
    }
    
    
}
