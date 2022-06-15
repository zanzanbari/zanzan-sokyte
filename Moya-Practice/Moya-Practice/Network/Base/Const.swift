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
        static let baseURL = ""
    }
}

extension Const {
    static let accessToken: String = ""
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
