//
//  MovieRequest.swift
//  Moya-Practice
//
//  Created by 소연 on 2022/06/16.
//

import Foundation

struct MovieRequest: Codable {
    var api_key: String
    var language: String
    var page: Int
    
    init(_ api_key: String,_ language: String, _ page: Int = 1) {
        self.api_key = api_key
        self.language = language
        self.page = page
    }
}
