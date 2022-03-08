//
//  DirectionsRequest.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/06.
//

import Foundation

// MARK: - Directions Request

struct DirectionsRequest: Codable {
    let origin, destination: String
}
