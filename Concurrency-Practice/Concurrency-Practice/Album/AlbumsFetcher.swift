//
//  AlbumsFetcher.swift
//  Concurrency-Practice
//
//  Created by 소연 on 2022/06/03.
//

import Foundation

struct ITunesResult: Codable {
    let results: [Album]
}

struct Album: Codable, Hashable {
    let collectionId: Int
    let collectionName: String
    let collectionPrice: Double
}

struct AlbumsFetcher {
    
    enum AlbumsFetcherError: Error {
        case invalidURL
        case invalidData
    }
    
    static func fetchAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=album") else {
            completion(.failure(AlbumsFetcherError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(AlbumsFetcherError.invalidData))
                return
            }
            
            do {
                let iTunesResult = try JSONDecoder().decode(ITunesResult.self, from: data)
                completion(.success(iTunesResult.results))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
        
        
    }
    
    static func fetchAlbumWithContinuation() async throws -> [Album] {
        let albums: [Album] = try await withCheckedThrowingContinuation({ continuation in
            fetchAlbums { result in
                switch result {
                case .success(let albums):
                    continuation.resume(returning: albums)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        
        return albums
    }
    
    static func fetchAlbumWithAsyncURLSession() async throws -> [Album] {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=album") else {
            throw AlbumsFetcherError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let iTunesResult = try JSONDecoder().decode(ITunesResult.self, from: data)
        return iTunesResult.results
    }

}
