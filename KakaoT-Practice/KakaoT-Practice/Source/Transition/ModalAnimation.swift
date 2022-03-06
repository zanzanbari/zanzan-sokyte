//
//  AnimationTransition.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/03.
//

import UIKit

class ModalAnimation: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    let animationDuration = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)!
        transitionContext.containerView.addSubview(toVC.view)
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = CGRect(
            x: 0,
            y: 500,
            width: finalFrame.size.width,
            height: finalFrame.size.height)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toVC.view.frame.origin = CGPoint(x: 0,y: 0)
            },
            completion: transitionContext.completeTransition)
    }
}

