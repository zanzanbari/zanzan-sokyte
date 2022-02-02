//
//  UIImage+.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/02.
//

import UIKit

extension UIImage {
    internal func resize(to length: CGFloat) -> UIImage {
        let newSize = CGSize(width: length, height: length)
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return image
    }
}
