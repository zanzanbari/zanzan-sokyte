//
//  LoginViewController.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/02.
//

import UIKit

import KakaoSDKUser

import NaverThirdPartyLogin

import SnapKit
import Then

import Alamofire

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "icnLogoLogin")
        $0.contentMode = .scaleAspectFit
    }
    
    private var kakakoLoginButton = BDSButton().then {
        $0.setBtnColors(normalBgColor: .gray300, normalFontColor: .white, activatedBgColor: .yellow100, activatedFontColor: .black200)
        $0.setTitleWithStyle(title: "카카오 로그인", size: 17.0)
        $0.setLeftIcon(imageName: "icnKakao")
        $0.isActivated = true
        $0.isEnabled = true
        $0.addTarget(self, action: #selector(touchUpKakaoLoginButton), for: .touchUpInside)
    }
    
    private var naverLoginButton = BDSButton().then {
        $0.setBtnColors(normalBgColor: .gray300, normalFontColor: .white, activatedBgColor: .green100, activatedFontColor: .white)
        $0.setTitleWithStyle(title: "네이버 로그인", size: 17.0)
        $0.setLeftIcon(imageName: "icnNaver")
        $0.isActivated = true
        $0.isEnabled = true
        $0.addTarget(self, action: #selector(touchUpNaverLoginButton), for: .touchUpInside)
    }
    
    private var appleLoginButton = BDSButton().then {
        $0.setBtnColors(normalBgColor: .gray300, normalFontColor: .white, activatedBgColor: .white, activatedFontColor: .black200)
        $0.setTitleWithStyle(title: "Apple 로그인", size: 17.0)
        $0.setLeftIcon(imageName: "icnApple")
        $0.setBorder(width: 1, color: .black200)
        $0.isActivated = true
        $0.isEnabled = true
    }
    
    private var emailLoginButton = BDSButton().then {
        $0.setBtnColors(normalBgColor: .clear, normalFontColor: .clear, activatedBgColor: .white, activatedFontColor: .gray100)
        $0.setTitleWithStyle(title: "이메일 로그인", size: 17.0)
        $0.isActivated = true
        $0.isEnabled = true
        $0.addTarget(self, action: #selector(touchUpEmailLoginButton), for: .touchUpInside)
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = .gray200
    }
    
    private var signupButton = BDSButton().then {
        $0.setBtnColors(normalBgColor: .clear, normalFontColor: .clear, activatedBgColor: .white, activatedFontColor: .gray100)
        $0.setTitleWithStyle(title: "가입하기", size: 17.0)
        $0.isActivated = true
        $0.isEnabled = true
    }
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        [logoImageView, kakakoLoginButton, naverLoginButton, appleLoginButton, emailLoginButton, lineView, signupButton].forEach {
            view.addSubview($0)
        }
        
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(209)
            $0.width.equalTo(97)
            $0.height.equalTo(89)
        }
        
        kakakoLoginButton.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(159)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        naverLoginButton.snp.makeConstraints {
            $0.top.equalTo(kakakoLoginButton.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(naverLoginButton.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        emailLoginButton.snp.makeConstraints {
            $0.top.equalTo(appleLoginButton.snp.bottom).offset(41)
            $0.leading.equalToSuperview().inset(75)
        }
        
        lineView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(emailLoginButton.snp.centerY)
            $0.width.equalTo(1)
            $0.height.equalTo(20)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(appleLoginButton.snp.bottom).offset(41)
            $0.leading.equalTo(lineView.snp.trailing).offset(30)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        loginInstance?.delegate = self
    }
    
    // MARK: - @objc
    
    @objc func touchUpEmailLoginButton() {
        let dvc = EmailLoginViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc func touchUpKakaoLoginButton() {
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            loginWithKakaoApp()
        } else {
            // 만약, 카카오톡이 깔려있지 않을 경우에는 웹 브라우저로 카카오 로그인함.
            loginWithWeb()
        }
    }
    
    @objc func touchUpNaverLoginButton() {
        loginInstance?.requestThirdPartyLogin()
        //        loginInstance?.requestDeleteToken()
        //        loginInstance?.requestAccessTokenWithRefreshToken()
    }
    
    @objc func touchUpAppleLoginButton() {
        
    }
}

// MARK: - Kakao Login

extension LoginViewController {
    private func loginWithKakaoApp() {
        UserApi.shared.loginWithKakaoTalk { _, error in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoApp() success.")
                self.getUserID()
            }
        }
    }
    
    private func loginWithWeb() {
        UserApi.shared.loginWithKakaoAccount { _, error in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")
                self.getUserID()
            }
        }
    }
    
    private func getUserID() {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print(error)
            } else {
                if let id = user?.id {
                    print(id)
                    //                    UserDefaults.standard.set(String(id), forKey: Const.UserDefaultsKey.userID)
                    //                    UserDefaults.standard.set(false, forKey: Const.UserDefaultsKey.isAppleLogin)
                    // 서버 연결
                }
            }
        }
    }
}

// MARK: - Naver Login

extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
        getNaverInfo()
    }
    
    // referesh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print(loginInstance?.refreshToken)
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    // 모든 error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    
    private func getNaverInfo() {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
            return
        }
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        
        socialLogin(socialType: "naver", token: accessToken)
    }
    
    
}

// MARK: - Network

extension LoginViewController {
    private func socialLogin(socialType: String, token: String){
        LoginAPI.shared.socialLogin(parameter: SocailLoginRequest.init(social: socialType, token: token)) { responseData in
            switch responseData {
            case .success(let loginResponse):
                
                guard let response = loginResponse as? GeneralResponse<LoginResponse> else { return }
                
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
