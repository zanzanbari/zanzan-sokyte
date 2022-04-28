//
//  HistoryResponseData.swift
//  WAL-History-Pratice
//
//  Created by 소연 on 2022/04/28.
//

import Foundation

// MARK: - History Response

struct HistoryResponse: Codable {
    let sendingData, completeData: [HistoryData]
}

// MARK: - Data

struct HistoryData: Codable {
    let sendingDate, content, recieveDate: String
    let hidden: Bool?
}
