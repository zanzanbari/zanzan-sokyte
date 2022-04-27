//
//  HistoryTableViewCell.swift
//  WAL-History-Pratice
//
//  Created by 소연 on 2022/04/27.
//

import UIKit

import SnapKit
import Then

class ExpandingTableViewCellContent {
 
    var expanded: Bool
 
    init() {
        self.expanded = false
    }
}

final class HistoryTableViewCell: UITableViewCell {
    
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private var backView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "04. 11 (월) 오후 5:00 • 전송 예정"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.setTextSpacingBy(value: -0.3)
    }
    
    private var contentLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 2
        $0.setTextSpacingBy(value: -0.3)
    }
    
    private var dateLabel = UILabel().then {
        $0.text = "2022.03.12"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.setTextSpacingBy(value: -0.3)
        $0.isHidden = true
    }
    
    var dateLabelColor: UIColor = .gray {
        didSet {
            titleLabel.textColor = dateLabelColor
        }
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        
    }
    
    private func setLayout() {
        contentView.addSubview(backView)
        
        backView.addSubview(titleLabel)
        backView.addSubview(contentLabel)
        backView.addSubview(dateLabel)
        
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.height.equalTo(116)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(22)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview().inset(22)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    
    // MARK: - Custom Method
    
    internal func initCell(isClicked :ExpandingTableViewCellContent) {
        if isClicked.expanded {
            backView.snp.updateConstraints {
                $0.top.bottom.equalToSuperview().inset(6)
                $0.height.equalTo(184)
                $0.leading.trailing.equalToSuperview().inset(20)
            }
            
            contentLabel.snp.updateConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(15)
                $0.leading.trailing.equalToSuperview().inset(22)
                $0.bottom.equalToSuperview().inset(46)
            }
            contentLabel.numberOfLines = 0
            
            dateLabel.isHidden = false
        } else {
            
        }
    }
    
    internal func setData(_ data: String) {
        contentLabel.text = data
        contentLabel.setTextSpacingBy(value: -0.3)
    }
}
