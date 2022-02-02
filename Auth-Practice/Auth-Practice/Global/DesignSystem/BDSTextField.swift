//
//  BDSTextField.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/01.
//

import UIKit

import SnapKit
import Then

class BDSTextField: UITextField {
    
    // MARK: - Properties
    
    private lazy var underlineView = UIView().then {
        $0.backgroundColor = .black200
    }
    
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
        self.addSubview(underlineView)
        
        underlineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func setDefaultStyle() {
        self.font = .PretendardR(size: 15)
        self.addLeftPadding(8)
        self.backgroundColor = .white
        self.tintColor = .black200
        self.borderStyle = .none
    }
    
    // MARK: - Public Method
    
    public func setPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}
