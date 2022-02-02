//
//  UIFont+.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/01/29.
//

import UIKit

enum FontWeight {
    case regular, medium, bold, semiBold
}

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
    
    // MARK: - Pretendard Font
    
    class func PretendardR(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Regular", size: size)!
    }
    
    class func PretendardM(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Medium", size: size)!
    }
    
    class func PretendardB(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Bold", size: size)!
    }
    
    class func PretendardSB(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-SemiBold", size: size)!
    }
}

