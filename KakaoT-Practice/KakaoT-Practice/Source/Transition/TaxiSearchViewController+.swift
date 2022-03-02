//
//  TaxiSearchViewController+.swift
//  KakaoT-Practice
//
//  Created by soyeon on 2022/03/03.
//

import UIKit

// MARK: - UIViewControllerTransitioningDelegate

extension TaxiSearchViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    /// present될때 실행애니메이션
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = AnimationTransition()
        return transition
    }
    
    /// dismiss될때 실행애니메이션
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DisMissAnimation()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // Presenting usually doesn't have any interactivity
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? { return nil
    }
    
    // UINavigationControllerDelegate push/pop 애니메이션
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
