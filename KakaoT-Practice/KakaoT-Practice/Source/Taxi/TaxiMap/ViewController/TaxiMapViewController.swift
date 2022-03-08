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
    
    private var latitude: Double = 0.0
    private var longtitude: Double = 0.0
    
    private var mapView: MTMapView?
    private var positionItem1: MTMapPOIItem?
    
    private let modalAnimation: ModalAnimation = ModalAnimation()
    
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
    }
    
    private var locationView = TaxiMapLocationView()
    private var carView = TaxiMapCarView()
    
    private var taxiMapMarkerView = TaxiMapMarkerView()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(getNotification), name: NSNotification.Name("DirectionNotification"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MTMapView(frame: self.view.bounds)
        positionItem1 = MTMapPOIItem()
        configMap()
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        
        [backButton,
         businessButton,
         bookingButton,
         locationButton,
         locationView,
         carView].forEach {
            view.addSubview($0)
        }
        
        bookingButton.layer.cornerRadius = 20
        bookingButton.layer.masksToBounds = true
        
        [locationView, carView].forEach {
            $0.layer.cornerRadius = 16
            $0.layer.masksToBounds = true
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        view.addSubview(taxiMapMarkerView)
        
        locationView.isHidden = false
        carView.isHidden = true
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
        
        locationView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(locationButton.snp.bottom).offset(16)
        }
        
        carView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(452)
        }
        
        taxiMapMarkerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(228)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(47)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpBottomView))
        locationView.addGestureRecognizer(tapGesture)
    }
    
    private func configMap() {
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            view.addSubview(mapView)
            
            /// 마커 추가
            positionItem1?.itemName = "애오개역 5호선 1번 출구"
            positionItem1?.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  LocationValue.originLatitude,
                                                                longitude: LocationValue.originLongitude))
            positionItem1?.markerType = .bluePin
            
            mapView.addPOIItems([positionItem1!])
            mapView.fitAreaToShowAllPOIItems()
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpBottomView() {
        
        let dvc = TaxiSearchViewController()
        dvc.modalPresentationStyle = .custom
        dvc.transitioningDelegate = self
        present(dvc, animated: true, completion: nil)
    }
    
    @objc func getNotification(_ notification: Notification) {
        locationView.isHidden = true
        taxiMapMarkerView.isHidden = true
        
//        let dvc = TaxiMapCarViewController()
//        dvc.modalTransitionStyle = .coverVertical
//        dvc.modalPresentationStyle = .overCurrentContext
//        present(dvc, animated: true, completion: nil)
        
        carView.isHidden = false
        let object = notification.object as! GeneralResponse<DirectionsResponse>
        guard let carData = object.data?.carType else { return }
        carView.ventiCarView.cost = carData[2].cost
        carView.blueCarView.cost = carData[0].cost
        carView.normalCarView.cost = carData[1].cost

        mapView?.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude:  LocationValue.destinationLatitude,
                                                                 longitude: LocationValue.destinationLongtitude)), zoomLevel: 2, animated: true)
        
        // FIXME: 선택한 차량 타입 별 API 호출
        requestCallTaxi(origin: "127.11015314141542,37.39472714688412", carType: "일반 택시")
    }
}

// MARK: - Custom Transition Delegate

extension TaxiMapViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return modalAnimation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DisMissAnimation()
    }
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

// MARK: - MapView

extension TaxiMapViewController: MTMapViewDelegate {
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        let currentLocation = location?.mapPointGeo()
        if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude{
            print("MTMapView updateCurrentLocation (\(latitude),\(longitude)) accuracy (\(accuracy))")
        }
    }
    
    func mapView(_ mapView: MTMapView?, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading (\(headingAngle)) degrees")
    }
}

// MARK: - Network

extension TaxiMapViewController {
    func requestCallTaxi(origin: String, carType: String) {
        CallTaxiAPI.shared.requestCallTaxi(parameter: CallTaxiRequest.init(origin: origin, carType: carType)) { responseData in
            switch responseData {
            case .success(let taxiResponse):
                
                guard let response = taxiResponse as? GeneralResponse<CallTaxiResponse> else { return }
                guard let data = response.data else { return }
                print("✅", data.carNumber)
                
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
