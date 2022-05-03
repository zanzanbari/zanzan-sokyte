//
//  DefaultView.swift
//  WAL-Practice
//
//  Created by 소연 on 2022/05/01.
//

import UIKit

import SnapKit
import Then

final class DefaultView: UIView {
    
    
    private var imageView = UIImageView().then {
        $0.backgroundColor = .systemCyan
    }
    
    private var textLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    
    var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }
    
    var image: String = "" {
        didSet {
            imageView.image = UIImage(named: " ")
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
    }
    
    private func setLayout() {
        addSubview(imageView)
        addSubview(textLabel)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9)
            $0.width.height.equalTo(41)
            $0.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.bottom.equalToSuperview().inset(9)
        }
    }
}
