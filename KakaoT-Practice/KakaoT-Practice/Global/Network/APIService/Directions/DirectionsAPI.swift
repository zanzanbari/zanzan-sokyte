//
//  DirectionsAPI.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/06.
//

import Foundation

import Moya

public class DirectionsAPI {
    static let shared = DirectionsAPI()
    var directionsProvider = MoyaProvider<DirectionsService>(plugins: [MoyaLoggingPlugin()])
    
    public init() { }
    
    func postLogin(parameter: DirectionsRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        directionsProvider.request(.getDirections(parameter: parameter)) { result in
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
        guard let decodedData = try? decoder.decode(GeneralResponse<DirectionsResponse>.self, from: data)
        else { return .pathErr }
        
        return .success(decodedData)
    }
}
