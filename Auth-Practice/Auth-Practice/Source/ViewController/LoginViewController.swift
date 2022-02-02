//
//  LoginViewController.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/02.
//

import UIKit

import SnapKit
import Then

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
    }
    
    private var naverLoginButton = BDSButton().then {
        $0.setBtnColors(normalBgColor: .gray300, normalFontColor: .white, activatedBgColor: .green100, activatedFontColor: .white)
        $0.setTitleWithStyle(title: "네이버 로그인", size: 17.0)
        $0.setLeftIcon(imageName: "icnNaver")
        $0.isActivated = true
        $0.isEnabled = true
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
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
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
    
    // MARK: - @objc
    
    @objc func touchUpEmailLoginButton() {
        let dvc = EmailLoginViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
}
