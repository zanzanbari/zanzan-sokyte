//
//  TaxiLocationCollectionViewCell.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/03.
//

import UIKit

import SnapKit
import Then

final class TaxiLocationCollectionViewCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    private lazy var cellView = TaxiLocationCellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        initViewContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        contentView.addSubview(cellView)
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
    }
    
    private func initViewContraints() {
        cellView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func setCell(type: TaxiLocationCellViewType) {
        cellView.setCellType(type: type)
    }
}

enum TaxiLocationCellViewType {
    case home
    case company
    case none
    
    var image: UIImage {
        switch self {
        case .home, .none:
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
        case .none:
            return ""
        }
    }
}

final class TaxiLocationCellView: UIView {
    
    // MARK: - Properties
    
    private lazy var locationImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var locationLabel = UILabel().then {
        $0.textColor = .black100
        $0.font = KDSFont.body6
    }

    // MARK: - Initializer
    init() {
        super.init(frame: .zero)

        initView()
        initViewContraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Method
    
    private func initView() {
        backgroundColor = .gray500
        
        [locationImageView, locationLabel].forEach {
            addSubview($0)
        }
    }
    
    private func initViewContraints() {
        locationImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(7)
            $0.width.height.equalTo(24)
        }

        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImageView.snp.trailing).offset(6)
            $0.centerY.equalTo(locationImageView.snp.centerY)
        }
    }

    // MARK: - Public Method
    
    func setCellType(type: TaxiLocationCellViewType) {
        locationImageView.image = type.image
        locationLabel.text = type.text
    }
}
