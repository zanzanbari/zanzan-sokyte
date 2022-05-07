//
//  SpecialView.swift
//  WAL-Practice
//
//  Created by 소연 on 2022/05/01.
//

import UIKit

import SnapKit
import Then

protocol SpecialViewDelegate: AnyObject {
    func touchUpView(content: String)
}

final class SpecialView: UIView {

    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var imageName: String = "" {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }

    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 12
    }
    
    private func setLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
    }
}
