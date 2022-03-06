//
//  LoginAPI.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/03.
//

import Foundation

import Alamofire
import Moya

public class LoginAPI {
    static let shared = LoginAPI()
    static var instance = MoyaProvider<LoginService>(plugins: [MoyaLoggingPlugin()])
    
    var loginProvider = MoyaProvider<LoginService>(plugins: [MoyaLoggingPlugin()])
    
    public init() { }
    
    func postLogin(parameter: LoginRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        loginProvider.request(.postLogin(parameter: parameter)) { result in
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
    
    func reissueToken(completion: @escaping (NetworkResult<Any>) -> Void) {
        loginProvider.request(.authReissueToken) { result in
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
    
    func socialLogin(parameter: SocailLoginRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        loginProvider.request(.socialLogin(parameter: parameter)) { result in
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
        guard let decodedData = try? decoder.decode(GeneralResponse<LoginResponse>.self, from: data)
        else { return .pathErr }
        
        return .success(decodedData)
    }
}
