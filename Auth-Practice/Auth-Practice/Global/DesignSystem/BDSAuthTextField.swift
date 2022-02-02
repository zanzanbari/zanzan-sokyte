//
//  BDSAuthTextField.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/02.
//

import UIKit

import SnapKit
import Then

final class BDSAuthTextField: BDSTextField {
    
    // MARK: - Properties
    
    private var buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .horizontal
        $0.spacing = 2
    }
    
    private var clearButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: " "), for: .normal)
    }
    
    private var seeButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: " "), for: .normal)
    }
    
    private var warningLabel = UILabel().then {
        $0.textColor = .red100
        $0.font = .Pretendard(type: .regular, size: 14)
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
    
    // MARK: - Private Method
    
    private func setLayout() {
       
    }
    
    private func setDefaultStyle() {
        
    }
    
    // MARK: - Public Method
    
    public func setWarningLabel() {
        
    }
}
