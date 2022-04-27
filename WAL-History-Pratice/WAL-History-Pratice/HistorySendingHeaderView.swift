//
//  HistoryTableHeaderView.swift
//  WAL-History-Pratice
//
//  Created by 소연 on 2022/04/27.
//

import UIKit

import SnapKit
import Then

final class HistorySendingHeaderView: UIView {
    
    // MARK: - Properties
    
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
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(20)
        }
    }
}
