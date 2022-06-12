//
//  MovieFetcher.swift
//  Concurrency-Practice
//
//  Created by 소연 on 2022/06/03.
//

import Foundation

struct MovieFetcher {
    
    enum MovieFetcherError: Error {
        case invalidURL
        case invalidData
    }
    
    static func fetchMovieWithAsyncURLSession() async throws -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1") else {
            throw MovieFetcherError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let movieResponse = try JSONDecoder().decode(PopularMovie.self, from: data)
        return movieResponse.results
    }

}

