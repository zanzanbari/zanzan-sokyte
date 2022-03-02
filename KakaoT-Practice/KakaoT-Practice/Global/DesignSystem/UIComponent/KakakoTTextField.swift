//
//  KakakoTTextField.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/02/24.
//

import UIKit

import SnapKit
import Then

class KakakoTTextField: UITextField {
    
    enum KakakoTTextFieldType {
        case here
        case destination
    }
    
    // MARK: - Properties
    
    var textFieldType: KakakoTTextFieldType = .here {
        didSet {
            switch textFieldType {
            case .here:
                self.setLeftIcon(8, 24, UIImage(named: "icn_circle_here")!)
            case .destination:
                self.setLeftIcon(8, 24, UIImage(named: "icn_circle_destination")!)
            }
        }
    }
    
    var isActivated: Bool = false {
        didSet {
            self.backgroundColor = isActivated ? .navy400 : .white
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setDefaultStyle()
    }
    
    // MARK: - Private Methods
    
    private func setDefaultStyle() {
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.font = KDSFont.body1
        self.backgroundColor = .white
        self.tintColor = .blue100
    }
    
    // MARK: - Public Method
    
    public func setPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}

