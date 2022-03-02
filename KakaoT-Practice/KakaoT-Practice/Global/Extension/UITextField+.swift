//
//  UITextField+.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/03.
//

import UIKit

extension UITextField {
    /// UITextField의 상태를 리턴함
    var isEmpty: Bool {
        if text?.isEmpty ?? true {
            return true
        }
        return false
    }
    
    /// UITextField 왼쪽에 여백 주는 메서드
    func addLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    /// UITextField 오른쪽에 여백 주는 메서드
    func addRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    /// UITextField 왼쪽 아이콘 설정 메서드
    func setLeftIcon(_ padding: CGFloat, _ size: CGFloat, _ icon: UIImage) {
        let padding = padding
        let size = size
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size + padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
    /// 자간 설정 메서드
    func setCharacterSpacing(_ spacing: CGFloat){
        let attributedStr = NSMutableAttributedString(string: self.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedStr.length))
        self.attributedText = attributedStr
    }
}
