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

class ShowingTableViewCellContent {
    var showed: Bool
 
    init() {
        self.showed = false
    }
}

final class HistoryTableViewCell: UITableViewCell {
    
    static var cellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private var backView = UIView().then {
        $0.backgroundColor = .green
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    private var view = UIView().then {
        $0.backgroundColor = .blue
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "받을 날짜"
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
        $0.text = "보낸 날짜"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.setTextSpacingBy(value: -0.3)
        $0.isHidden = true
    }
    
//    private var coverView = UIView().then {
//        $0.backgroundColor = .systemGray6
//        $0.isHidden = true
//    }
    
    var dateLabelColor: UIColor = .gray {
        didSet {
            titleLabel.textColor = dateLabelColor
        }
    }
    
    var isExpanded: Bool = false
    var isShowed: Bool = true {
        didSet {
//            coverView.isHidden = isShowed
        }
    }
    
    var radius: CGFloat = 0 {
        didSet {
//            backView.layer.cornerRadius = radius
//            backView.layer.masksToBounds = true
        }
    }
    
    // MARK: - Initializer
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
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
        contentView.backgroundColor = .yellow
    }
    
    private func setLayout() {
        contentView.addSubview(backView)
        
        backView.addSubview(titleLabel)
        backView.addSubview(contentLabel)
        backView.addSubview(dateLabel)
//        backView.addSubview(coverView)
        
        backView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(116)
        }
        
//        coverView.snp.makeConstraints {
//            $0.top.leading.trailing.bottom.equalToSuperview()
//        }
        
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
    
    internal func tapCell(isTapped: ExpandingTableViewCellContent) {
        isExpanded = isTapped.expanded
        
        if isTapped.expanded {
            backView.snp.updateConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.trailing.equalToSuperview().inset(20)
//                $0.bottom.equalToSuperview().inset(12)
                $0.height.equalTo(184)
            }
            
            contentLabel.snp.updateConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(15)
                $0.leading.trailing.equalToSuperview().inset(21)
                $0.bottom.equalToSuperview().inset(46)
            }
            contentLabel.numberOfLines = 0
            
            dateLabel.isHidden = false
        } else {
            backView.snp.updateConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.trailing.equalToSuperview().inset(20)
//                $0.bottom.equalToSuperview().inset(12)
                $0.height.equalTo(116)
            }
            
            contentLabel.snp.updateConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(15)
                $0.leading.trailing.bottom.equalToSuperview().inset(22)
            }
            contentLabel.numberOfLines = 2
            
            dateLabel.isHidden = true
        }
    }
    
    internal func pressCell(isPressed: ShowingTableViewCellContent) {
        isShowed = isPressed.showed
        
        if isPressed.showed {
            
        } else {
//            coverView.isHidden = false
        }
    }
    
    internal func setData(_ data: HistoryData) {
        guard let isHidden = data.hidden else { return }
        self.isShowed = !isHidden
        
        titleLabel.text = data.sendingDate
        titleLabel.setTextSpacingBy(value: -0.3)
        
        contentLabel.text = data.content
        contentLabel.setTextSpacingBy(value: -0.3)
        
        dateLabel.text = data.recieveDate
        dateLabel.setTextSpacingBy(value: -0.3)
    }
}
