//
//  HistoryCompleteCollectionReusableView.swift
//  WAL-History-Pratice
//
//  Created by 소연 on 2022/04/30.
//

import UIKit

final class HistoryCompleteCollectionReusableView: UICollectionReusableView {
    static var identifier: String { return String(describing: self) }
    
    var title: String = "" {
        didSet { titleLabel.text = title }
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    internal func initView() {
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initView()
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
