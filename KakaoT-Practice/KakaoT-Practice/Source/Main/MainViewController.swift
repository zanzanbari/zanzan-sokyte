//
//  MainViewController.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/02/24.
//

import UIKit

import CoreLocation

import SnapKit
import Then

final class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    private var locationManager : CLLocationManager = CLLocationManager()
    
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
    private lazy var veletButton = VehicleButton(vehicleType: .velet)
    
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
        vehicleButtonStackView.addArrangedSubview(veletButton)
    }
    
    private func setLayout() {
        vehicleButtonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(70)
        }
    }
    
    // MARK: - Custom Method
    
    private func initCoreLocation() {
        /// 델리게이트 설정
        locationManager.delegate = self
        /// 거리 정확도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        /// 사용자에게 허용 받기 alert 띄우기
        locationManager.requestWhenInUseAuthorization()
        
        /// 위치 서비스 설정 유무
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            print(locationManager.location?.coordinate)
        } else {
        }
    }
    
    /// 위치 정보 계속 업데이트 -> 위도 경도 받아옴
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
//            Const.Location.originLatitude = location.coordinate.latitude
//            Const.Location.originLongitude = location.coordinate.longitude
        }
    }
    
    /// 위도 경도 받아오기 에러
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
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
        $0.font = KDSFont.body6
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
            $0.top.equalTo(image.snp.bottom).offset(5)
            $0.centerX.equalTo(image.snp.centerX)
            $0.height.equalTo(20)
        }
    }
}

fileprivate enum VehicleType {
    case taxi
    case black
    case bike
    case velet
    
    var title: String {
        switch self {
        case .taxi:
            return "택시"
        case .black:
            return "블랙"
        case .bike:
            return "바이크"
        case .velet:
            return "대리"
        }
    }
    
    var image: UIImage {
        switch self {
        case .taxi:
            return UIImage(named: "img_car_nomal")!
        case .black:
            return UIImage(named: "img_car_black")!
        case .bike:
            return UIImage(named: "img_car_venti")!
        case .velet:
            return UIImage(named: "img_car_ luxury")!
        }
    }
}
