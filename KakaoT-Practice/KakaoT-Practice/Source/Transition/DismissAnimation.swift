//
//  DismissAnimation.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/03.
//

import UIKit

class DisMissAnimation: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning{
    let animationDuration = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 사라지는 뷰(종료되는 뷰)
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
            fromView.frame = CGRect(
                x: 0,
                y: 500,
                width: fromView.frame.width,
                height: fromView.frame.height)
        }) { (completed) in
            fromView.alpha = 0
            transitionContext.completeTransition(completed)
        }
    }
}
