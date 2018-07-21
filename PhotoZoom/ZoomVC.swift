//
//  ZoomVC.swift
//  PhotoZoom
//
//  Created by Thanapat Sorralump on 16/7/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class ZoomVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ctImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var ctImageViewBottom: NSLayoutConstraint!
    @IBOutlet weak var ctImageViewLeft: NSLayoutConstraint!
    @IBOutlet weak var ctImageViewRight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        ctImageViewTop.constant = yOffset
        ctImageViewBottom.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        ctImageViewLeft.constant = xOffset
        ctImageViewRight.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    @IBAction func closeVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ZoomVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
}
