//
//  HistoryTableCompleteHeaderView.swift
//  WAL-History-Pratice
//
//  Created by 소연 on 2022/04/27.
//

import UIKit

import SnapKit
import Then

final class HistoryCompleteHeaderView: UIView {
    
    // MARK: - Properties
    
    private var lineView = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    private var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = "\(title)"
        }
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        backgroundColor = .white
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        addSubview(lineView)
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(26)
            $0.leading.equalToSuperview().inset(20)
        }
    }
}

