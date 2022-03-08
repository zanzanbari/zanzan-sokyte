//
//  Temp.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/02/24.
//

import Foundation

// MARK: - Directions Response

struct DirectionsResponse: Codable {
    let estimatedTime: Int
    let routes: Routes
    let carType: [CarType]
}

// MARK: - CarType

struct CarType: Codable {
    let name: String
    let cost: Int
}

// MARK: - Routes

struct Routes: Codable {
    let bound: [String: Double]
    let roads: [Road]
}

// MARK: - Road

struct Road: Codable {
    let name: String
    let distance, duration, trafficSpeed, trafficState: Int
    let vertexes: [Double]
}
