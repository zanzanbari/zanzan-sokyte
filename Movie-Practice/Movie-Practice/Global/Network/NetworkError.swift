//
//  NetworkError.swift
//  Movie-Practice
//
//  Created by 소연 on 2022/06/02.
//

import Foundation

enum NetworkError: Error {
    case versionError
    case invalidURL
    case invalidResponse
    case parsingError
    case invalidRequest
    case serverError
    case unknown
}

enum FetchError: Error {
    case notOK
    case badData
}
