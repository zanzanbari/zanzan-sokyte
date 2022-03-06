//
//  MapMarkerView.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/04.
//

import UIKit

import SnapKit
import Then

final class TaxiMapMarkerView: UIView {
    
    // MARK: - Properties
    
    private var backgroundView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private var blackView = UIView().then {
        $0.backgroundColor = .black200
        $0.layer.borderColor = UIColor.black100.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 1
        $0.layer.masksToBounds = true
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "출발"
        $0.textColor = .white
        $0.font = KDSFont.body5
    }
    
    private var stickView = UIImageView().then {
        $0.image = UIImage(named: "icn_stick")
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        initViewContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func initView() {
        addSubview(backgroundView)
        
        backgroundView.addSubview(blackView)
        backgroundView.addSubview(stickView)
        
        blackView.addSubview(titleLabel)
    }
    
    private func initViewContraints() {
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        blackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(31)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(11)
        }
        
        stickView.snp.makeConstraints {
            $0.top.equalTo(blackView.snp.bottom)
            $0.centerX.equalTo(blackView.snp.centerX)
            $0.width.equalTo(3)
        }
    }
}
