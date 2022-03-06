//
//  TaxiMapCarBottomView.swift
//  KakaoT-Practice
//
//  Created by 소연 on 2022/03/07.
//

import UIKit

import SnapKit
import Then

final class TaxiMapCarView: UIView {
    
    private lazy var bubbleImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_bubble")
    }
    
    private lazy var bubbleTitleLabel = UILabel().then {
        $0.text = "지금 호출하면 벤티가 바로 배차돼요!"
        $0.textColor = .white
        $0.font = KDSFont.body8
    }
    
    private lazy var itemStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    var ventiCarView = CarItemView(carType: .venti)
    var blueCarView = CarItemView(carType: .blue)
    var normalCarView = CarItemView(carType: .normal)

    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .white
        
        [ventiCarView, blueCarView, normalCarView].forEach {
            itemStackView.addArrangedSubview($0)
        }
        
        addSubview(itemStackView)
        addSubview(bubbleImageView)
        
        bubbleImageView.addSubview(bubbleTitleLabel)
    }
    
    private func setLayout() {
        itemStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(32)
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(200)
            $0.height.equalTo(46)
        }
        
        bubbleTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(19)
            $0.centerX.equalToSuperview()
        }
    }
}

enum CarItemType {
    case blue
    case normal
    case venti
    
    var image: UIImage {
        switch self {
        case .blue:
            return UIImage(named: "img_car_blue")!
        case .normal:
            return UIImage(named: "img_car_nomal")!
        case .venti:
            return UIImage(named: "img_car_venti")!
        }
    }
    
    var title: String {
        switch self {
        case .blue:
            return "블루"
        case .normal:
            return "일반호출"
        case .venti:
            return "벤티"
        }
    }
    
    var subTitle: String {
        switch self {
        case .blue:
            return "부르면 바로 배차되는 블루"
        case .normal:
            return "주변 택시 호출"
        case .venti:
            return "더 넓고 편안한 벤티"
        }
    }
    
    var isCescoMember: Bool {
        switch self {
        case .blue, .venti:
            return true
        case .normal:
            return false
        }
    }
}

final class CarItemView: UIView {
    private lazy var type: CarItemType = .normal
    
    private lazy var carTypeImageView = UIImageView().then {
        $0.image = type.image
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = type.title
        $0.textColor = .black100
        $0.font = KDSFont.body4
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = type.subTitle
        $0.textColor = .navy100
        $0.font = KDSFont.body6
    }
    
    private lazy var cescoImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_cesco")
        $0.isHidden = !type.isCescoMember
    }
    
    private lazy var costLabel = UILabel().then {
        $0.textColor = .black100
        $0.font = KDSFont.body2
    }
    
    var cost: Int = 0 {
        didSet {
            costLabel.text = "예상 \(cost)원"
        }
        willSet {
            costLabel.text = "예상 \(cost)원"
        }
    }
    
    init(carType: CarItemType) {
        super.init(frame: .zero)
        self.type = carType
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.backgroundColor = .white
        
        [carTypeImageView, titleLabel, subTitleLabel, costLabel, cescoImageView].forEach {
            addSubview($0)
        }
        
        carTypeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(21)
            $0.width.equalTo(56)
            $0.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(carTypeImageView.snp.trailing).offset(12)
        }
        
        cescoImageView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.centerY.equalTo(titleLabel)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(carTypeImageView.snp.trailing).offset(12)
        }
        
        costLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
