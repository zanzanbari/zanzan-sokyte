//
//  Const.swift
//  Moya-Practice
//
//  Created by 소연 on 2022/06/15.
//

import Foundation

struct Const {
    
}

extension Const {
    struct URL {
        static let baseURL = "https://api.themoviedb.org/3"
    }
}

extension Const {
    static let accessToken: String = ""
    static let apiKey: String = "7a0258bf0084d8887279aaf068cda614"
}

extension Const {
    struct Header {
        static var tokenHeader = ["Content-Type": "application/json",
                                  "token": accessToken]
        static var multiTokenHeader = ["Content-Type": "multipart/form-data",
                                       "token": accessToken]
        static let loginHeader = ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
