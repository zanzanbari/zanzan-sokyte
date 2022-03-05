//
//  BaseTargetType.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/06.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var sampleData: Data {
        return Data()
    }
}

