//
//  ViewController.swift
//  PhotoZoom
//
//  Created by Thanapat Sorralump on 16/7/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var ivPic: UIImageView!
    
    let fadeAnimation = FadeVCAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPicTap()
    }
    
    func setupPicTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedPic))
        ivPic.addGestureRecognizer(tapGesture)
    }

    @objc func tappedPic() {
        performSegue(withIdentifier: "goToZoom", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToZoom" {
            if let vc = segue.destination as? ZoomVC {
                vc.transitioningDelegate = self
            }
        }
    }

}

extension MainVC: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return fadeAnimation
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}

