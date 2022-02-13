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
    private var emailTextField = BDSTextField().then {
        $0.setPlaceholder(placeholder: "이메일")
    }
    
    private var passwordTextField = BDSTextField().then {
        $0.setPlaceholder(placeholder: "비밀번호")
    }
    
    private var emailWarningLabel = UILabel().then {
        $0.textColor = .red100
        $0.font = .Pretendard(type: .regular, size: 14)
        $0.isHidden = true
    }
    
    private var passwordWarningLabel = UILabel().then {
        $0.textColor = .red100
        $0.font = .Pretendard(type: .regular, size: 14)
        $0.isHidden = true
    }
    
    private var loginButton = BDSButton().then {
        $0.setBtnColors(normalBgColor: .gray300, normalFontColor: .white, activatedBgColor: .black200, activatedFontColor: .white)
        $0.setTitleWithStyle(title: "로그인", size: 17.0)
        $0.isActivated = true
        $0.isEnabled = true
        $0.addTarget(self, action: #selector(touchUpLoginButton), for: .touchUpInside)
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
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        
        emailTextField.becomeFirstResponder()
    }
    
    private func setupLayout() {
        [backButton,
         emailLoginLabel,
         emailTextField,
         emailWarningLabel,
         passwordTextField,
         passwordWarningLabel,
         loginButton,
         forgetPasswordButton].forEach {
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
            $0.height.equalTo(42)
        }
        
        emailWarningLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(28)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(42)
        }
        
        passwordWarningLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(28)
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
    
    private func bind() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - @objc
    
    @objc func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpLoginButton() {
        guard let text = emailTextField.text else { return }
        
        if !emailTextField.hasText && !passwordTextField.hasText {
            emailWarningLabel.isHidden = false
            emailWarningLabel.text = "이메일을 입력해주세요"
            
            passwordWarningLabel.isHidden = false
            passwordWarningLabel.text = "비밀번호를 입력해주세요"
        } else {
            if !isValidEmail(testStr: text) {
                emailWarningLabel.isHidden = false
                emailWarningLabel.text = "올바르지 않은 이메일 형식입니다"
                passwordWarningLabel.isHidden = true
            } else {
                if passwordTextField.hasText {
                    emailWarningLabel.isHidden = true
                    passwordWarningLabel.isHidden = true
                    
                    requestLogin()
                } else {
                    emailWarningLabel.isHidden = true
                    passwordWarningLabel.isHidden = false
                    passwordWarningLabel.text = "비밀번호를 입력해주세요"
                }
            }
        }
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

// MARK: - TextField Delegate

extension EmailLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = emailTextField.text else { return true }
        
        if !emailTextField.hasText && !passwordTextField.hasText {
            emailWarningLabel.isHidden = false
            emailWarningLabel.text = "이메일을 입력해주세요"
            
            passwordWarningLabel.isHidden = false
            passwordWarningLabel.text = "비밀번호를 입력해주세요"
        } else {
            if !isValidEmail(testStr: text) {
                emailWarningLabel.isHidden = false
                emailWarningLabel.text = "올바르지 않은 이메일 형식입니다"
                passwordWarningLabel.isHidden = true
            } else {
                if passwordTextField.hasText {
                    emailWarningLabel.isHidden = true
                    passwordWarningLabel.isHidden = true
                    
                    requestLogin()
                } else {
                    emailWarningLabel.isHidden = true
                    passwordWarningLabel.isHidden = false
                    passwordWarningLabel.text = "비밀번호를 입력해주세요"
                }
            }
        }
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
}

// MARK: - Network

extension EmailLoginViewController {
    func requestLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        LoginAPI.shared.postLogin(parameter: LoginRequest.init(email: email, password: password)) { responseData in
            switch responseData {
            case .success(let loginResponse):
                
                guard let response = loginResponse as? GeneralResponse<LoginResponse> else { return }
                
                if response.status == 200 {
                    UserDefaults.standard.setValue(response.data?.nickname ?? "", forKey: Const.UserDefaultsKey.name)
                    UserDefaults.standard.setValue(response.data?.accesstoken ?? "", forKey: Const.UserDefaultsKey.accessToken)
                    UserDefaults.standard.setValue(response.data?.accesstoken ?? "", forKey: Const.UserDefaultsKey.refreshToken)
                    
                    let dvc = MainViewController()
                    self.navigationController?.pushViewController(dvc, animated: true)
                } else {
                    // status가 400 혹은 500일 경우
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
