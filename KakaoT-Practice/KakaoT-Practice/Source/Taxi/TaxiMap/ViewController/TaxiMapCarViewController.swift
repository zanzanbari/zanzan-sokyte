//
//  TaxiMapCarViewController.swift
//  KakaoT-Practice
//
//  Created by 소연 on 2022/03/07.
//

import UIKit

import SnapKit
import Then

final class TaxiMapCarViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var carView = TaxiMapCarView()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(getNotification), name: NSNotification.Name("DirectionNotification"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.addSubview(carView)
        
        carView.layer.cornerRadius = 16
        carView.layer.masksToBounds = true
        carView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setLayout() {
        carView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(452)
        }
    }
    
    private func bind() {
        
    }
    
    // MARK: - @objc
    
    @objc func getNotification(_ notification: Notification) {
        print("✅ 화면 전환 이후 노티 받음")
        
        let object = notification.object as! GeneralResponse<DirectionsResponse>
        guard let carData = object.data?.carType else { return }
        
        carView.ventiCarView.cost = carData[2].cost
        carView.blueCarView.cost = carData[0].cost
        carView.normalCarView.cost = carData[1].cost
    }
}
