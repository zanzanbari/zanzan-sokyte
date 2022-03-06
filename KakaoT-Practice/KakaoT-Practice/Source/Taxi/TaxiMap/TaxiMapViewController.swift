//
//  TaxiViewController.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/02/24.
//

import UIKit

import SnapKit
import Then

import CoreLocation

final class TaxiMapViewController: UIViewController {
    
    // MARK: - Properties
    
    private var locationManager : CLLocationManager!
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
//        var config = UIButton.Configuration.plain()
//        config.imagePadding = -4
//        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        $0.configuration = config
    }
    
    private var bottomBackgrounView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private var hereTextField = KakakoTTextField().then {
        $0.textFieldType = .here
        $0.isActivated = false
        $0.text = "현위치: 애오개역 5호선 1번 출구"
        $0.textColor = .black100
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = .gray400
    }
    
    private var destinationTextField = KakakoTTextField().then {
        $0.textFieldType = .destination
        $0.isActivated = false
        $0.setPlaceholder(placeholder: "어디로 갈까요?")
    }
    
    private var destinationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.bounces = false
            $0.isPagingEnabled = false
            $0.showsHorizontalScrollIndicator = false
            $0.register(TaxiLocationCollectionViewCell.self, forCellWithReuseIdentifier: TaxiLocationCollectionViewCell.CellIdentifier)
        }
    }()
    
    private var destinationList: [String] = ["집", "회사"]
    
    private var taxiMapMarkerView = TaxiMapMarkerView()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        positionItem1 = MTMapPOIItem()
        configMap()
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        
        [backButton, businessButton, bookingButton, locationButton, bottomBackgrounView].forEach {
            view.addSubview($0)
        }
        
        bookingButton.layer.cornerRadius = 20
        bookingButton.layer.masksToBounds = true
        
        bottomBackgrounView.layer.cornerRadius = 16
        bottomBackgrounView.layer.masksToBounds = true
        bottomBackgrounView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        [hereTextField, lineView, destinationTextField, destinationCollectionView].forEach {
            bottomBackgrounView.addSubview($0)
        }
        
        [hereTextField, destinationTextField].forEach {
            $0.isUserInteractionEnabled = false
        }
        
        view.addSubview(taxiMapMarkerView)
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
        
        bottomBackgrounView.snp.makeConstraints {
            $0.top.equalTo(bookingButton.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        hereTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(19)
            $0.height.equalTo(48)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(hereTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        destinationTextField.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(48)
        }
        
        destinationCollectionView.snp.makeConstraints {
            $0.top.equalTo(destinationTextField.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(40)
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
        bottomBackgrounView.addGestureRecognizer(tapGesture)
        
        destinationCollectionView.delegate = self
        destinationCollectionView.dataSource = self
    }
    
    private func calculateCellWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = KDSFont.body6
        label.sizeToFit()
        return label.frame.width + 12 + 24 + 6 + 15
    }
    
    private func configMap() {
        /// 델리게이트 설정
        locationManager.delegate = self
        /// 거리 정확도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        /// 사용자에게 허용 받기 alert 띄우기
        locationManager.requestWhenInUseAuthorization()
        
        /// 위치 서비스 설정 유무
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation() //위치 정보 받아오기 시작
            print(locationManager.location?.coordinate)
        } else {
            print("위치 서비스 Off 상태")
        }
        
        mapView = MTMapView(frame: self.view.bounds)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            view.addSubview(mapView)
            
            /// 마커 추가
            positionItem1?.itemName = "애오개역 5호선 1번 출구"
            positionItem1?.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.553085038675434,
                                                                longitude: 126.9562709925087))
            positionItem1?.markerType = .bluePin
            
            mapView.addPOIItems([positionItem1!])
            mapView.fitAreaToShowAllPOIItems()
        }
    }
    
    /// 위치 정보 계속 업데이트 -> 위도 경도 받아옴
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longtitude = location.coordinate.longitude
            
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
        }
    }
    
    /// 위도 경도 받아오기 에러
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
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
}

// MARK: - Custom Transition Delegate

extension TaxiMapViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return modalAnimation
    }
    
    // dismiss될때 실행애니메이션
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
    
// MARK: - UICollectionView Delegate

extension TaxiMapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = calculateCellWidth(text: destinationList[indexPath.item])
        let cellHeight = collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionView DataSource

extension TaxiMapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return destinationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaxiLocationCollectionViewCell.CellIdentifier, for: indexPath) as? TaxiLocationCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.item == 0 {
            cell.setCell(type: .home)
        } else if indexPath.item == 1 {
            cell.setCell(type: .company)
        } else {
            cell.setCell(type: .none)
        }
        return cell
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

// MARK: - CLLocationManagerDelegate

extension TaxiMapViewController: CLLocationManagerDelegate {
    
}
