//
//  BDSButton.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/02.
//

import UIKit

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
    
    init() {
        super.init(frame: .zero)
        setDefaultStyle()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setDefaultStyle()
    }
    
    // MARK: - Private Methods
    
    /// 디폴트 버튼 스타일 설정
    private func setDefaultStyle() {
        self.makeRounded(cornerRadius: 4.adjusted)
        self.titleLabel?.font = .Pretendard(type: .medium, size: 17)
        self.backgroundColor = self.normalBgColor
        self.tintColor = .white
        self.setTitleColor(self.normalFontColor, for: .normal)
    }
    
    // MARK: - Public Methods
    
    func setBtnColors(normalBgColor: UIColor, normalFontColor: UIColor, activatedBgColor: UIColor, activatedFontColor: UIColor) {
        self.normalBgColor = normalBgColor
        self.normalFontColor = normalFontColor
        self.activatedBgColor = activatedBgColor
        self.activatedFontColor = activatedFontColor
    }
    
    /// 버튼 타이틀과 스타일 변경 폰트 사이즈 adjusted 적용
    func setTitleWithStyle(title: String, size: CGFloat, weight: FontWeight = .regular) {
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
}
