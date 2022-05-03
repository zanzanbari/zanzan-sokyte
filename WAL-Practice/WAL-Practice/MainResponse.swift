//
//  MainResponse.swift
//  WAL-Practice
//
//  Created by 소연 on 2022/05/01.
//

import Foundation

// MARK: - Main Response

struct MainResponse: Codable {
    let data: [MainData]
}

// MARK: - Datum

struct MainData: Codable {
    let type, content: String
}
