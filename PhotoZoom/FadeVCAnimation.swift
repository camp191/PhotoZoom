//
//  FadeVCAnimation.swift
//  PhotoZoom
//
//  Created by Thanapat Sorralump on 17/7/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class FadeVCAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.25
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let contextView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        toView.alpha = 0
        
        contextView.addSubview(toView)
        contextView.bringSubviewToFront(toView)
        
        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    
}
