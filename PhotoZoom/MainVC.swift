//
//  ViewController.swift
//  PhotoZoom
//
//  Created by Thanapat Sorralump on 16/7/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let fadeAnimation = FadeVCAnimation()
    var pics: [UIImage] = [UIImage(named: "me")!, UIImage(named: "3")!, UIImage(named: "4")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension MainVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return fadeAnimation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return fadeAnimation
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageTableViewCell
        cell.configure(pic: pics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let zoomVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageZoomVC") as! ZoomVC
        zoomVC.transitioningDelegate = self
        zoomVC.setupImage(pic: pics[indexPath.row])
        
        DispatchQueue.main.async {
            self.present(zoomVC, animated: true, completion: nil)
        }
    }
}

