//
//  MovieService.swift
//  Moya-Practice
//
//  Created by 소연 on 2022/06/15.
//

import Foundation

import Moya

enum MovieService {
    case movieList(id: Int)
}

extension MovieService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .movieList(let id):
            return "/movie/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .movieList:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .movieList:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .movieList:
            return Const.Header.tokenHeader
        }
    }
}
