//
//  TaxiViewController.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/02/24.
//

import UIKit

import SnapKit
import Then

final class TaxiMapViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var taxiSearchViewController = TaxiSearchViewController()
    
    private var backButton = KakaoTButton(buttonType: .back).then {
        $0.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    }
    
    private var businessButton = KakaoTButton(buttonType: .business)
    private var locationButton = KakaoTButton(buttonType: .location)
    
    private var bookingButton = UIButton().then {
        $0.setTitle("예약", for: .normal)
        $0.setImage(UIImage(named: "btn_ booking"), for: .normal)
        $0.setTitleColor(.navy100, for: .normal)
        $0.backgroundColor = .white
        $0.titleLabel?.font = KDSFont.body7
        
        // TODO: - 버튼 아이콘과 텍스트 레이아웃 수정
        var config = UIButton.Configuration.plain()
        config.imagePadding = -4
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        $0.configuration = config
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .gray
        
        [backButton, businessButton, bookingButton, locationButton].forEach {
            view.addSubview($0)
        }
        
        bookingButton.layer.cornerRadius = 20
        bookingButton.layer.masksToBounds = true
    }
    
    private func setLayout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().inset(12)
            $0.width.height.equalTo(40)
        }
        
        businessButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(40)
        }
        
        bookingButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalTo(backButton.snp.bottom).offset(424)
            $0.width.equalTo(86)
            $0.height.equalTo(40)
        }
        
        locationButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalTo(bookingButton.snp.centerY)
            $0.width.height.equalTo(40)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        taxiSearchViewController.transitioningDelegate = self
    }
    
    // MARK: - @objc
    
    @objc func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension TaxiMapViewController: UIViewControllerTransitioningDelegate {
    
}

// MARK: - Button

fileprivate final class KakaoTButton: UIButton {
    private lazy var type: KakaoTButtonType = .back
    
    private lazy var image = UIImageView().then {
        $0.image = type.image
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
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        addSubview(image)
        image.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

fileprivate enum KakaoTButtonType {
    case back
    case business
    case location
    
    var image: UIImage {
        switch self {
        case .back:
            return UIImage(named: "btn_back")!
        case .business:
            return UIImage(named: "btn_business")!
        case .location:
            return UIImage(named: "btn_location")!
        }
    }
}

