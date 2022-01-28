//
//  UIFont+.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/01/29.
//

import UIKit

extension UIFont {
    enum PretendardType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
        
        var name: String {
            return "Pretendard-" + self.rawValue
        }
    }
    
    enum PPNeueMachinaType: String {
        case ultrabold = "Ultrabold"
        case regular = "Regular"
        
        var name: String {
            return "PPNeueMachina-" + self.rawValue
        }
    }
    
    class func Pretendard(type: PretendardType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.name, size: size) else { return UIFont.init() }
        
        return font
    }

    class func PPNeueMachina(type: PPNeueMachinaType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.name, size: size) else { return UIFont.init() }
        
        return font
    }
}
