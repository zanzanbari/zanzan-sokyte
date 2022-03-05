//
//  NetworkConstant.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/06.
//

import Foundation

struct NetworkConstant {
    static let noTokenHeader = ["Content-Type": "application/json"]
    static let hasTokenHeader = ["Content-Type": "application/json",
                                 "accesstoken": NetworkConstant.accessToken]
    static let hasRefreshTokenHedaer = ["Content-Type": "application/json",
                                        "accesstoken": NetworkConstant.accessToken,
                                        "refreshtoken": NetworkConstant.refreshToken]
    
    static var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTgsImVtYWlsIjoidGVzdDEyMzRAdXNlci5jb20iLCJuaWNrbmFtZSI6IuyelOyelOuwlOumrCIsImlhdCI6MTY0NjUwODMyOSwiZXhwIjoxNjQ3NzE3OTI5LCJpc3MiOiJjaGFud29vIn0.Jv8aCZsnGaXCYkrYpEbNmyji-HK3fqJE618-3OYjsKw"
    static var refreshToken = ""
}
