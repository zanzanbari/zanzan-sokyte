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
    
    enum CodingKeys: String, CodingKey {
        case sendingDate
        case content
        case recieveDate
        case hidden
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        sendingDate = (try? values.decode(String.self, forKey: .sendingDate)) ?? ""
        content = (try? values.decode(String.self, forKey: .content)) ?? ""
        recieveDate = (try? values.decode(String.self, forKey: .recieveDate)) ?? ""
        hidden = (try? values.decode(Bool.self, forKey: .hidden)) ?? false
    }
}
