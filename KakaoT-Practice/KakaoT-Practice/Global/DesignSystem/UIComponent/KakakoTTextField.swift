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
    
    // MARK: - Properties

    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setDefaultStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
        setDefaultStyle()
    }
    
    // MARK: - Private Methods
    
    private func setLayout() {

    }
    
    private func setDefaultStyle() {

    }
    
    // MARK: - Public Method
    
    public func setPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}

