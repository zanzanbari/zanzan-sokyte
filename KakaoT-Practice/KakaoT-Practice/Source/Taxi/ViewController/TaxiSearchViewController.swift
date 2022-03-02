//
//  TaxiSearchViewController.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/02/24.
//

import UIKit

import SnapKit
import Then

final class TaxiSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private var backButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btn_back"), for: .normal)
    }
    
    private var locationButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btn_location"), for: .normal)
    }
    
    private var mapButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btn_map"), for: .normal)
    }
    
    private var hereTextField = KakakoTTextField().then {
        $0.textFieldType = .here
        $0.isActivated = false
        $0.text = "현위치: 어쩌구 저쩌구"
        $0.textColor = .black100
    }
    
    private var destinationTextField = KakakoTTextField().then {
        $0.textFieldType = .destination
        $0.isActivated = true
        $0.setPlaceholder(placeholder: "도착지 검색")
    }
    
    private var verticalDivideView = UIView().then {
        $0.backgroundColor = .navy400
    }
    
    private var horizontalDevideView = UIView().then {
        $0.backgroundColor = .gray500
    }
    
    private var emptyLabel = UILabel().then {
        $0.text = "최근 설정 기록이 없습니다."
        $0.textColor = .navy200
        $0.font = KDSFont.body4
    }
    
    private var homeButton = KakaoTButton(buttonType: .home)
    private var companyButton = KakaoTButton(buttonType: .company)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        
        [backButton, locationButton, mapButton, hereTextField, destinationTextField, verticalDivideView, horizontalDevideView, emptyLabel, homeButton, companyButton].forEach {
            view.addSubview($0)
        }
        
        [hereTextField, destinationTextField].forEach {
            $0.layer.cornerRadius = 30
            $0.layer.masksToBounds = true
            $0.delegate = self
        }
    }
    
    private func setLayout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(8)
            $0.width.height.equalTo(44)
        }
        
        hereTextField.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(48)
        }
        
        destinationTextField.snp.makeConstraints {
            $0.top.equalTo(hereTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(48)
        }
        
        homeButton.snp.makeConstraints {
            $0.top.equalTo(destinationTextField.snp.bottom).offset(9)
            $0.leading.equalToSuperview().inset(14)
            $0.width.equalTo(55)
            $0.height.equalTo(38)
        }
        
        companyButton.snp.makeConstraints {
            $0.top.equalTo(destinationTextField.snp.bottom).offset(9)
            $0.leading.equalTo(homeButton.snp.trailing).offset(17)
            $0.width.equalTo(68)
            $0.height.equalTo(38)
        }
        
        locationButton.snp.makeConstraints {
            $0.top.equalTo(destinationTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(270)
            $0.width.height.equalTo(40)
        }
        
        verticalDivideView.snp.makeConstraints {
            $0.leading.equalTo(locationButton.snp.trailing).offset(8)
            $0.width.equalTo(1)
            $0.height.equalTo(24)
            $0.centerY.equalTo(locationButton.snp.centerY)
        }
        
        mapButton.snp.makeConstraints {
            $0.top.equalTo(destinationTextField.snp.bottom).offset(8)
            $0.leading.equalTo(verticalDivideView.snp.trailing).offset(8)
            $0.width.height.equalTo(40)
        }
        
        horizontalDevideView.snp.makeConstraints {
            $0.top.equalTo(mapButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(237)
        }
    }
}

// MARK: - UITextField Delegate

extension TaxiSearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .navy400
        
        if textField == hereTextField {
            hereTextField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = .white
        
        if textField == hereTextField && hereTextField.isEmpty {
            hereTextField.text = "현위치: 어쩌구 저쩌구"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


// MARK: - Button

fileprivate enum KakaoTButtonType {
    case home
    case company
    
    var image: UIImage {
        switch self {
        case .home:
            return UIImage(named: "icn_home")!
        case .company:
            return UIImage(named: "icn_ company")!
        }
    }
    
    var text: String {
        switch self {
        case .home:
            return "집"
        case .company:
            return "회사"
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .home:
            return .black100
        case .company:
            return .navy200
        }
    }
}

fileprivate final class KakaoTButton: UIButton {
    private lazy var type: KakaoTButtonType = .home
    
    private lazy var image = UIImageView().then {
        $0.image = type.image
    }
    
    private lazy var label = UILabel().then {
        $0.text = type.text
        $0.font = KDSFont.body6
        $0.textColor = type.textColor
    }
    
    init(buttonType: KakaoTButtonType) {
        super.init(frame: .zero)
        self.type = buttonType
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        self.backgroundColor = .white
        
        addSubview(image)
        addSubview(label)
        
        image.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(6)
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().inset(8)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(6)
            $0.centerY.equalTo(image.snp.centerY)
        }
    }
}
