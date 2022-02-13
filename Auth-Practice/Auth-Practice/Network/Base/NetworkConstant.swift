//
//  NetworkConstant.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/03.
//

import Foundation

struct NetworkConstant {
    
    static let noTokenHeader = ["Content-Type": "application/json"]
    static let hasTokenHeader = ["Content-Type": "application/json",
                                 "accesstoken": Const.UserDefaultsKey.accessToken]
    static let hasRefreshTokenHedaer = ["Content-Type": "application/json",
                                        "accesstoken": Const.UserDefaultsKey.refreshToken,
                                        "refreshtoken": Const.UserDefaultsKey.refreshToken]
    
    static var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJzdWJpbjA3MjNAYmVmb3JlZ2V0LmNvbSIsIm5pY2siOiLtj6zrppAiLCJpZEZpcmViYXNlIjoiaXNRM1kzVU4xSVlqdmQzMXpsZk5Bd2FHejFtMSIsImlhdCI6MTY0MjQzNTEzMSwiZXhwIjoxNjQzNjQ0NzMxLCJpc3MiOiJjaGFud29vIn0.zIK0c8Gq1f_GcJ_UjkwABWfXQ5UbVSU5M69uEqZhKkc"
}
