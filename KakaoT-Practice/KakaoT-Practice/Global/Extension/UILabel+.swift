//
//  UILabel+.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/03.
//

import UIKit

extension UILabel {
    /// 자간 설정 메서드
    func setCharacterSpacing(_ spacing: CGFloat){
        let attributedStr = NSMutableAttributedString(string: self.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedStr.length))
        self.attributedText = attributedStr
    }
}
