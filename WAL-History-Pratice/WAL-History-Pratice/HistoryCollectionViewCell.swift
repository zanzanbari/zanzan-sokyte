//
//  HistoryCollectionViewCell.swift
//  WAL-History-Pratice
//
//  Created by 소연 on 2022/04/30.
//

import UIKit

import SnapKit
import Then

class ExpandingCollectionViewCellContent {
    var expanded: Bool
 
    init() {
        self.expanded = false
    }
}

final class HistoryCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String { return String(describing: self) }

    private var receiveDateLabel = UILabel().then {
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
    
    private var sendDateLabel = UILabel().then {
        $0.text = "보낸 날짜"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.setTextSpacingBy(value: -0.3)
        $0.isHidden = true
    }

    var dateLabelColor: UIColor = .gray {
        didSet {
            receiveDateLabel.textColor = dateLabelColor
        }
    }
    
    var isExpanded: Bool = false
    
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
//                    self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: 184)
//                }, completion: { success in
//                    self.isExpanded = true
//                })
//            } else {
//                UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
//                      self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: 116)
//                    }, completion: { success in
//                      self.isExpanded = false
//                    })
//            }
//        }
//    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        receiveDateLabel.preferredMaxLayoutWidth = receiveDateLabel.frame.size.width
        contentLabel.preferredMaxLayoutWidth = contentLabel.frame.size.width
        sendDateLabel.preferredMaxLayoutWidth = sendDateLabel.frame.size.width
        super.layoutSubviews()
    }
    
    private func configUI() {
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 10
    }

    private func setLayout() {
        contentView.addSubview(receiveDateLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(sendDateLabel)
        
        receiveDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(22)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(22)
        }
        
        sendDateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    
    // MARK:  - Custom Method
    
    internal func setData(_ data: HistoryData) {
        guard let isHidden = data.hidden else { return }
        
        receiveDateLabel.text = data.sendingDate
        receiveDateLabel.setTextSpacingBy(value: -0.3)
        
        contentLabel.text = data.content
        contentLabel.setTextSpacingBy(value: -0.3)
        print("label count: ", contentLabel.text?.count)
        guard let count = contentLabel.text?.count else { return }
        if count > 26 {
            contentLabel.snp.updateConstraints {
                $0.leading.trailing.bottom.equalToSuperview().inset(22)
            }
        } else {
            contentLabel.snp.updateConstraints {
                $0.leading.leading.equalToSuperview().inset(22)
                $0.bottom.equalToSuperview().inset(33)
            }
        }
        
        sendDateLabel.text = data.recieveDate
        sendDateLabel.setTextSpacingBy(value: -0.3)
    }
    
    internal func tapCell(isTapped: ExpandingCollectionViewCellContent) {
        isExpanded = isTapped.expanded
        
        if isTapped.expanded {
            contentLabel.snp.updateConstraints {
                $0.top.equalTo(receiveDateLabel.snp.bottom).offset(15)
                $0.leading.trailing.equalToSuperview().inset(21)
                $0.bottom.equalToSuperview().inset(46)
            }
            contentLabel.numberOfLines = 0
            
            sendDateLabel.isHidden = false
        } else {
            contentLabel.snp.updateConstraints {
                $0.top.equalTo(receiveDateLabel.snp.bottom).offset(15)
                $0.leading.trailing.bottom.equalToSuperview().inset(22)
            }
            contentLabel.numberOfLines = 2
            
            sendDateLabel.isHidden = true
        }
    }
}
