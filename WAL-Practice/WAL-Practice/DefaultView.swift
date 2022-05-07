//
//  DefaultView.swift
//  WAL-Practice
//
//  Created by 소연 on 2022/05/01.
//

import UIKit

import SnapKit
import Then

protocol DefaultViewDelegate: AnyObject {
    func touchUpView(content: String, index: Int)
}

final class DefaultView: UIView {
    
    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var content: String = ""
    var index: Int = 0 
    
    var imageName: String = "" {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    var canOpen: Bool = false {
        didSet {
            if canOpen { setGesture() }
        }
    }
    
    private var isSelected: Bool = false
    
    weak var delegate: DefaultViewDelegate?

    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 12
    }
    
    private func setLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
    }
    
    func setGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
        addGestureRecognizer(gesture)
    }
    
    @objc func tapView(_ : UITapGestureRecognizer) {
        isSelected.toggle()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = isSelected ? UIColor.orange.cgColor : UIColor.systemGray5.cgColor
        
        delegate?.touchUpView(content: self.content, index: self.index)
    }
}
