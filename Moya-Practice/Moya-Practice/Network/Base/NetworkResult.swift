//
//  NetworkResult.swift
//  Moya-Practice
//
//  Created by 소연 on 2022/06/14.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
