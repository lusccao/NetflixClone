//
//  APICaller.swift
//  NetflixClone
//
//  Created by Lucas Arthur on 17/01/24.
//

import Foundation

struct Constants {
    static let HTTP_METHOD = "GET"
    static let API_URL = "https://api.themoviedb.org/3"
    static let ACCESS_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1M2E2Yzc3N2I2YjM3YjcyYTNlZWU5YTdmMTdlMGI3NSIsInN1YiI6IjY1YTgxMmZmNGIwYzYzMDEyM2UzNzBkYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pdY5AbtF5GM5hlc-iJDUiF4NsmHEu-v_BsRbRsjDIn4"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    static let trendingMoviesURL = "/trending/movie/day?language=en-US"
    static let trendingTvURL = "/trending/tv/day?language=en-US"
    static let upcomingMoviesURL = "/movie/upcoming?language=en-US&page=1"
    static let popularMoviesURL = "/movie/popular?language=en-US&page=1"
    static let topRatedMoviesURL = "/movie/top_rated?language=en-US&page=1"
    private static let headers = [
        "accept": "application/json",
        "Authorization": "Bearer \(Constants.ACCESS_TOKEN)"
      ]
    
    func getTrendingMovies(completions: @escaping (Result<[Title], Error>) -> Void) {
        makeASession(typeURL: APICaller.trendingMoviesURL) { results in
            switch results {
            case .success(let titles):
                completions(.success(titles))
            case .failure(let error):
                print(error)
                completions(.failure(error))
            }
        }
    }
    
    func getTrendingTv(completions: @escaping (Result<[Title], Error>) -> Void) {
        makeASession(typeURL: APICaller.trendingTvURL) { results in
            switch results {
            case .success(let titles):
                completions(.success(titles))
            case .failure(let error):
                completions(.failure(error))
            }
        }
    }
    
    func getUpcomingMovies(completions: @escaping (Result<[Title], Error>) -> Void) {
        makeASession(typeURL: APICaller.upcomingMoviesURL) { results in
            switch results {
            case .success(let titles):
                completions(.success(titles))
            case .failure(let error):
                completions(.failure(error))
            }
        }
    }
    
    func getPopularMovies(completions: @escaping (Result<[Title], Error>) -> Void) {
        makeASession(typeURL: APICaller.popularMoviesURL) { results in
            switch results {
            case .success(let titles):
                completions(.success(titles))
            case .failure(let error):
                completions(.failure(error))
            }
        }
    }
    
    func getTopRatedMovies(completions: @escaping (Result<[Title], Error>) -> Void) {
        makeASession(typeURL: APICaller.topRatedMoviesURL) { results in
            switch results {
            case .success(let titles):
                completions(.success(titles))
            case .failure(let error):
                completions(.failure(error))
            }
        }
    }
   
    func makeASession(typeURL: String, completions: @escaping (Result<[Title], Error>) -> Void) {
        guard let url =  URL(string: ("\(Constants.API_URL)\(typeURL)")) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = Constants.HTTP_METHOD
        request.allHTTPHeaderFields = APICaller.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completions(.success(results.results))
            } catch {
                completions(.failure(APIError.failedToGetData))
            }
        })

        dataTask.resume()
    }
    
}
