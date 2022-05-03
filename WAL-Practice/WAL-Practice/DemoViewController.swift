//
//  DemoViewController.swift
//  WAL-Practice
//
//  Created by 소연 on 2022/05/02.
//

import UIKit

import SnapKit
import Then

final class DemoViewController: UIViewController {

//    private var circleButton = UIButton().then {
//        $0.setTitle("재설정", for: .normal)
//        $0.setTitleColor(.white, for: .normal)
//        $0.backgroundColor = .gray
//    }
    
    private lazy var circleButton = DoubleBorderCircleButton(type: .start)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(circleButton)
        
        circleButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(85)
        }
        
        circleButton.layer.cornerRadius = 85 / 2
        
//        circleButton.layer.borderWidth = 4.0
//        circleButton.layer.borderColor = UIColor.systemPink.cgColor
        

//        let borderLayer = CALayer()
//        borderLayer.frame = circleButton.bounds
//        borderLayer.borderColor = UIColor.systemMint.cgColor
//        borderLayer.borderWidth = 14.0
//        borderLayer.cornerRadius = borderLayer.frame.width / 2
//        circleButton.layer.insertSublayer(borderLayer, above: circleButton.layer)
    }
}

enum ButtonItemType {
    case lap
    case start
    
    var title: String {
        switch self {
        case .lap:
            return "랩"
        case .start:
            return "재설정"
        }
    }
    
    var color: UIColor {
        switch self {
        case .lap:
            return .gray
        case .start:
            return .green
        }
    }
}

fileprivate final class DoubleBorderCircleButton: UIButton {
    private lazy var type: ButtonItemType = .lap
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 2
    }
    
    private lazy var label = UILabel().then {
        $0.text = type.title
        $0.textColor = .green
    }
    
    init(type: ButtonItemType) {
        super.init(frame: .zero)
        self.type = type
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = type.color.withAlphaComponent(0.5)
        
        lineView.layer.cornerRadius = 85 / 2
    }
    
    private func setLayout() {
        addSubview(lineView)
        addSubview(label)
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(2)
        }
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
