//
//  ApiCaller.swift
//  Movie
//
//  Created by AsherFelix on 11/1/23.
//

import Foundation

struct Constants {
    static let API_KEY = "b11178c07ba517d41d162f0aefa2edfc"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}
enum APIError: Error {
    case failedData
}

class ApiCaller {
    static let shared = ApiCaller()

    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard  let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder ().decode(MovieReponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    func getTrendingTvs(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard  let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder ().decode(MovieReponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    func getUpcomingMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder ().decode(MovieReponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    func getPopular(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder ().decode(MovieReponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    func getTopRated(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder ().decode(MovieReponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    func getDiscoverMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder ().decode(MovieReponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    func search(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder ().decode(MovieReponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedData))
            }
        }
        task.resume()
    }
    func getMovie(with query: String, completion: @escaping (Result<VideoElements, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder ().decode(YoutubeResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
