//
//  DismissAnimation.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/03.
//

import UIKit

class DisMissAnimation: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 사라지는 뷰(종료되는 뷰)
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        UIView.animate(withDuration: 0.2, animations: { fromView.alpha = 0 }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
}
