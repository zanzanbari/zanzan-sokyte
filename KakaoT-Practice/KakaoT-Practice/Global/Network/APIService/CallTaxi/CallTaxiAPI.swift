//
//  CallTaxiAPI.swift
//  KakaoT-Practice
//
//  Created by 소연 on 2022/03/08.
//

import Foundation

import Moya

public class CallTaxiAPI {
    static let shared = CallTaxiAPI()
    var callTaxiProvider = MoyaProvider<CallTaxiService>(plugins: [MoyaLoggingPlugin()])
    
    public init() { }
    
    func requestCallTaxi(parameter: CallTaxiRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        callTaxiProvider.request(.requestCallTaxi(parameter: parameter)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            return isValidLoginData(data: data)
        case 400..<500:
            return isValidLoginData(data: data)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }

    private func isValidLoginData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GeneralResponse<CallTaxiResponse>.self, from: data)
        else { return .pathErr }
        
        return .success(decodedData)
    }
}
