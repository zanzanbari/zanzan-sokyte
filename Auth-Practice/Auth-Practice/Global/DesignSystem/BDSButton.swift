//
//  BDSButton.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/02.
//

import UIKit

import SnapKit
import Then

final class BDSButton: UIButton {
    
    // MARK: - Properties
    
    var isActivated: Bool = false {
        didSet {
            self.backgroundColor = self.isActivated ? activatedBgColor : normalBgColor
            self.setTitleColor(self.isActivated ? activatedFontColor : normalFontColor, for: .normal)
            self.isEnabled = isActivated
        }
    }
    
    private var normalBgColor: UIColor = .gray300
    private var normalFontColor: UIColor = .white
    private var activatedBgColor: UIColor = .black200
    private var activatedFontColor: UIColor = .white
    
    private var leftIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    init() {
        super.init(frame: .zero)
        setLayout()
        setDefaultStyle()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setLayout()
        setDefaultStyle()
    }
    
    // MARK: - Private Methods
    
    /// 디폴트 버튼 스타일 설정
    private func setDefaultStyle() {
        self.makeRounded(cornerRadius: 12.adjusted)
        self.titleLabel?.font = .Pretendard(type: .medium, size: 17)
        self.backgroundColor = self.normalBgColor
        self.tintColor = .white
        self.setTitleColor(self.normalFontColor, for: .normal)
    }
    
    private func setLayout() {
        self.addSubview(leftIconImageView)
        leftIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
    }
    
    // MARK: - Public Methods
    
    public func setBtnColors(normalBgColor: UIColor, normalFontColor: UIColor, activatedBgColor: UIColor, activatedFontColor: UIColor) {
        self.normalBgColor = normalBgColor
        self.normalFontColor = normalFontColor
        self.activatedBgColor = activatedBgColor
        self.activatedFontColor = activatedFontColor
    }
    
    /// 버튼 타이틀과 스타일 변경 폰트 사이즈 adjusted 적용
    public func setTitleWithStyle(title: String, size: CGFloat, weight: FontWeight = .regular) {
        let font: UIFont
        
        switch weight {
        case .regular:
            font = .PretendardR(size: size.adjusted)
        case .medium:
            font = .PretendardM(size: size.adjusted)
        case .bold:
            font = .PretendardB(size: size.adjusted)
        case .semiBold:
            font = .PretendardSB(size: size.adjusted)
        }
        
        self.titleLabel?.font = font
        self.setTitle(title, for: .normal)
    }
    
    public func setLeftIcon(imageName: String) {
        leftIconImageView.isHidden = false
        leftIconImageView.image = UIImage(named: imageName)
    }
    
    public func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
