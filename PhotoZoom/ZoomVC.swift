//
//  ZoomVC.swift
//  PhotoZoom
//
//  Created by Thanapat Sorralump on 16/7/2561 BE.
//  Copyright © 2561 Thanapat Sorralump. All rights reserved.
//

import UIKit

class ZoomVC: UIViewController {
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ctImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var ctImageViewBottom: NSLayoutConstraint!
    @IBOutlet weak var ctImageViewLeft: NSLayoutConstraint!
    @IBOutlet weak var ctImageViewRight: NSLayoutConstraint!
    
    var minScale: CGFloat = 1
    var pic: UIImage?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let pic = pic {
            imageView.image = pic
        }
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    func setupImage(pic: UIImage) {
        self.pic = pic
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        self.minScale = minScale
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        guard let pic = pic else { return }
        let yOffset: CGFloat = (size.height - pic.size.height * minScale) / 2
        ctImageViewTop.constant = yOffset
        ctImageViewBottom.constant = yOffset

        let xOffset = max(0, (size.width - pic.size.width * minScale) / 2)
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
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        btnClose.isHidden = true
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        btnClose.isHidden = scale == minScale ? false : true
    }
}
