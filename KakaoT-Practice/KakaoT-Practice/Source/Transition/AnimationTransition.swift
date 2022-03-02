//
//  AnimationTransition.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/03.
//

import UIKit

class AnimationTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    var originPoint: CGPoint?
    var originFrame: CGRect?
    
    func setPoint(point: CGPoint?) {
        self.originPoint = point
    }
    
    func setFrame(frame: CGRect?) {
        self.originFrame = frame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    /// 애니메이션 효과정의
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("✅ 커스텀 화면 전환")
        
        let containerView = transitionContext.containerView
        // 다음 보여질뷰 참조
        guard let toView = transitionContext.view(forKey: .to) else { return }
        containerView.addSubview(toView)
    }
}

