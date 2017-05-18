//
//  CustomPresentationController.swift
//  Demo
//
//  Created by sycf_ios on 2017/5/18.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import UIKit
enum PresentingDirection {
    case top,right,left,bottom
    var bounds: CGRect {
        return UIScreen.main.bounds
    }
    func offsetWithFrame(viewFrame: CGRect) -> CGRect {
        switch self {
        case .top:
            return viewFrame.offsetBy(dx: 0, dy: -bounds.size.height)
        case .bottom:
            return viewFrame.offsetBy(dx: 0, dy: bounds.size.height)
        case .left:
            return viewFrame.offsetBy(dx: -bounds.size.width, dy: 0)
        case .right:
            return viewFrame.offsetBy(dx: bounds.size.width, dy: 0)
        }
    }
}
class CustomPresentationController: NSObject, UIViewControllerAnimatedTransitioning {
    var presentingDirection: PresentingDirection
    init(direction: PresentingDirection) {
        self.presentingDirection = direction
    }
    
    //代理方法
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalVCFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        
        toViewController.view.frame = presentingDirection.offsetWithFrame(viewFrame: finalVCFrame)
        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0.1;
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: { 
            fromViewController.view.alpha = 0.1
            toViewController.view.frame = finalVCFrame
            toViewController.view.alpha = 1;
        }) { (finished) in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        }
        
    }
}
