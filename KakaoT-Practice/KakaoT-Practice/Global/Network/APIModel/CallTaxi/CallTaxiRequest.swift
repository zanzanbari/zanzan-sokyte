//
//  CallTaxiRequest.swift
//  KakaoT-Practice
//
//  Created by 소연 on 2022/03/08.
//

import Foundation

// MARK: - CallTaxi Request

struct CallTaxiRequest: Codable {
    let origin, carType: String
}
