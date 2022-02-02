//
//  ViewController.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/01/29.
//

import UIKit

import SnapKit
import Then

import Moya

final class EmailLoginViewController: UIViewController {

    // MARK: - Properties
    
    private var backButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    }
    
    private var emailLoginLabel = UILabel().then {
        $0.text = "이메일 로그인"
        $0.textColor = .black
        $0.font = .Pretendard(type: .medium, size: 23)
    }
    
    // FIX ME : 디자인 시스템 적용
    private var emailTextField = UITextField().then {
        $0.placeholder = "이메일"
    }
    
    private var passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
    }
    
    private var loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
    }
    
    private var forgetPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊어버리셨나요?", for: .normal)
        $0.setTitleColor(.gray200, for: .normal)
        $0.titleLabel?.font = .Pretendard(type: .medium, size: 15)
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
        [backButton, emailLoginLabel, emailTextField, passwordTextField, loginButton, forgetPasswordButton].forEach {
            view.addSubview($0)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(6)
            $0.width.height.equalTo(44)
        }
        
        emailLoginLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLoginLabel.snp.bottom).offset(42)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(81)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
        
        forgetPasswordButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    // MARK: - @objc
    
    @objc func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

