//
//  MovieAPI.swift
//  Moya-Practice
//
//  Created by 소연 on 2022/06/15.
//

import Foundation

import Moya

public class MovieAPI {
    static let shared = MovieAPI()
    var movieProvider = MoyaProvider<MovieService>(plugins: [MoyaLoggerPlugin()])

    public init() { }
    
    func movieList(param: MovieRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        movieProvider.request(.popular(param: param)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeMovieStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeMovieStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(MovieResponse.self, from: data)else {
            return .pathErr
        }

        switch statusCode {
        case 200:
            return .success(decodedData.results ?? "None-Data")
        case 400..<500:
            return .requestErr(decodedData.totalPages)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
