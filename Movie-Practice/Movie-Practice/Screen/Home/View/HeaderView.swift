//
//  HeaderView.swift
//  Movie-Practice
//
//  Created by 소연 on 2022/06/02.
//

import UIKit

import SnapKit
import Then

final class HeaderView: UICollectionReusableView {
    static var reuseIdentifier: String { return String(describing: self) }
    
    let label = UILabel().then {
        $0.text = "Popular Movie"
        $0.textColor = .black
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
    }
    
    let inset = CGFloat(10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configUI() {
        backgroundColor = .systemPink
    }
    
    private func setLayout() {
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
