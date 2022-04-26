//
//  ViewController.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/01/29.
//

import UIKit

import RxSwift
import RxCocoa

import SnapKit
import Then

import Moya

final class EmailLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var disposeBag = DisposeBag()
    
    private var rootView = EmailLoginView()
    
    private lazy var appApi = LoginAPI.instance
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: - InitUI
    
    private func initView() {
        self.view.addSubview(rootView)
        rootView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        
    }
}

// MARK: - Network

extension EmailLoginViewController {
    func requestLogin() {
//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
//
//        LoginAPI.shared.postLogin(parameter: LoginRequest.init(email: email, password: password)) { responseData in
//            switch responseData {
//            case .success(let loginResponse):
//
//                guard let response = loginResponse as? GeneralResponse<LoginResponse> else { return }
//
//                if response.status == 200 {
//                    UserDefaults.standard.setValue(response.data?.nickname ?? "", forKey: Const.UserDefaultsKey.name)
//                    UserDefaults.standard.setValue(response.data?.accesstoken ?? "", forKey: Const.UserDefaultsKey.accessToken)
//                    UserDefaults.standard.setValue(response.data?.refreshtoken ?? "", forKey: Const.UserDefaultsKey.refreshToken)
//
//                    let dvc = MainViewController()
//                    self.navigationController?.pushViewController(dvc, animated: true)
//                } else if response.status == 403 {
//
//                } else {
//                    self.showToast(message: response.message ?? "", font: .Pretendard(type: .regular, size: 12))
//                }
//
//            case .requestErr(let message):
//                print("requestErr \(message)")
//            case .pathErr:
//                print("pathErr")
//            case .serverErr:
//                print("serverErr")
//            case .networkFail:
//                print("networkFail")
//            }
//        }
    }
    
    private func signUp(email: String, password: String) {
        self.appApi.rx
            .request(.postLogin(parameter: LoginRequest.init(email: email, password: password)))
            .asObservable()
            .observeOnMain()
            .doOnMoyaError { err in
                print("\(err)")
            }
            .appApiDecode(LoginResponse)
            .withUnretained(self)
            .subscribe(onNext: { (`self`, resBody) in
                AppProperty.signInType = signInType
                AppKeychain.keychain[.appApiAccessToken] = resBody.token.accessToken
                AppKeychain.keychain[.appApiRefreshToken] = resBody.token.refreshToken

                self.navigationController?.pushViewController(OnBoardingLayoutViewController(), animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
    func getRefreshToken() {
        LoginAPI.shared.reissueToken { responseData in
            switch responseData {
            case .success(let response):
                guard let response = response as? GeneralResponse<LoginResponse> else { return }
                
                if response.status == 200 {
                    UserDefaults.standard.setValue(response.data?.accesstoken ?? "", forKey: Const.UserDefaultsKey.accessToken)
                } else {
                    self.showToast(message: response.message ?? "", font: .Pretendard(type: .regular, size: 12))
                }
                
            case .requestErr(let message):
                print("requestErr \(message)")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
