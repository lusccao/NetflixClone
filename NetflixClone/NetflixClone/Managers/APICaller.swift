//
//  APICaller.swift
//  NetflixClone
//
//  Created by Lucas Arthur on 17/01/24.
//

import Foundation

struct Constants {
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
    static let headers = [
        "accept": "application/json",
        "Authorization": "Bearer \(Constants.ACCESS_TOKEN)"
      ]
    
    func getTrendingMovies(completions: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url =  URL(string: ("\(Constants.API_URL)\(APICaller.trendingMoviesURL)")) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = APICaller.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completions(.success(results.results))
            } catch {
                completions(.failure(error))
            }
        })

        dataTask.resume()
        
    }
    
    func getTrendingTv(completions: @escaping (Result<[Tv], Error>) -> Void) {
        guard let url =  URL(string: ("\(Constants.API_URL)\(APICaller.trendingTvURL)")) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = APICaller.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTvResponse.self, from: data)
                completions(.success(results.results))
            } catch {
                completions(.failure(error))
            }
        })

        dataTask.resume()
    }
    
    func getUpcomingMovies(completions: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url =  URL(string: ("\(Constants.API_URL)\(APICaller.upcomingMoviesURL)")) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = APICaller.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completions(.success(results.results))
            } catch {
                completions(.failure(error))
            }
        })

        dataTask.resume()
    }
    
    func getPopularMovies(completions: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url =  URL(string: ("\(Constants.API_URL)\(APICaller.popularMoviesURL)")) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = APICaller.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completions(.success(results.results))
            } catch {
                completions(.failure(error))
            }
        })

        dataTask.resume()
    }
    
    func getTopRatedMovies(completions: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url =  URL(string: ("\(Constants.API_URL)\(APICaller.topRatedMoviesURL)")) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = APICaller.headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completions(.success(results.results))
            } catch {
                completions(.failure(error))
            }
        })

        dataTask.resume()
    }
    
}
