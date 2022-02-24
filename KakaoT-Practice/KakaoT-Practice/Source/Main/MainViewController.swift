//
//  MainViewController.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/02/24.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var vehicleButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private lazy var taxiButton = VehicleButton(vehicleType: .taxi).then {
        $0.addTarget(self, action: #selector(touchUpTaxiButton), for: .touchUpInside)
    }
    
    private lazy var blackButton = VehicleButton(vehicleType: .black)
    
    private lazy var bikeButton = VehicleButton(vehicleType: .bike)
    
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
        view.backgroundColor = .white
        
        view.addSubview(vehicleButtonStackView)
        
        vehicleButtonStackView.addArrangedSubview(taxiButton)
        vehicleButtonStackView.addArrangedSubview(blackButton)
        vehicleButtonStackView.addArrangedSubview(bikeButton)
    }
    
    private func setLayout() {
        vehicleButtonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.height.equalTo(70)
        }
    }
    
    // MARK: - Custom Method
    
    // MARK: - @objc
    
    @objc func touchUpTaxiButton() {
        let dvc = TaxiMapViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
}

fileprivate final class VehicleButton: UIButton {
    private lazy var type: VehicleType = .taxi
    
    private lazy var buttonTitleLabel = UILabel().then {
        $0.text = type.title
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private lazy var image = UIImageView().then {
        $0.image = type.image
    }
    
    init(vehicleType: VehicleType) {
        super.init(frame: .zero)
        self.type = vehicleType
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        addSubview(image)
        addSubview(buttonTitleLabel)
        
        image.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.width.equalTo(50)
        }
        
        buttonTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(image.snp.centerX)
            $0.height.equalTo(20)
        }
    }
}

fileprivate enum VehicleType {
    case taxi
    case black
    case bike
    
    var title: String {
        switch self {
        case .taxi:
            return "택시"
        case .black:
            return "블랙"
        case .bike:
            return "바이크"
        }
    }
    
    var image: UIImage {
        switch self {
        case .taxi:
            return UIImage(named: "icnTaxi")!
        case .black:
            return UIImage(named: "icnBlack")!
        case .bike:
            return UIImage(named: "icnGrayTaxi")!
        }
    }
}
