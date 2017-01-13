//
//  TransitionManager.swift
//  Assignment01
//
//  Created by Yiping Guo on 12/01/2017.
//  Copyright © 2017 au.rmit.s3177105. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animatedTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: <#T##UITransitionContextViewKey#>)!
        let toView = transitionContext.view(forKey: <#T##UITransitionContextViewKey#>)!
        
        // set up from 2D transforms that we'll use in the animation
        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
        let offScreenLeft = CGAffineTransformmakeTranslation(-container.fram.width, 0)
        
        // start the toView to the right of the screen
        toView.transform = offScreenRight
        
        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense
        // but for now it's important to just follow the approach
        let duration = self.transitionDuration(using: transitionContext)
        
        // perform the animation!
        UIView.animate(withDuration: duration, 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: <#T##() -> Void#>, completion: ((true) -> Void)?){
            
            fromView.transform = offScreenLeft
            toView.transform = CGAffineTransformIdentity
            
            // tell our transitionContext object that we've finished
            // transitionContext.completeTransition(true)
            
        }
        
    }
    
    // return how many seconds the transition animation will take
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animator when presenting a view controller
    // remember that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}
