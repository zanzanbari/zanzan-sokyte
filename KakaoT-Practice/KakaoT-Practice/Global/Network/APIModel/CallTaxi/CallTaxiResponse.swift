//
//  CallTaxiResponse.swift
//  KakaoT-Practice
//
//  Created by 소연 on 2022/03/08.
//

import Foundation

// MARK: - CallTaxi

struct CallTaxiResponse: Codable {
    let name: String
    let photo: String?
    let carNumber, location: String
    let estimatedTime: Int
    let routes: Routes
}
