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
    @IBOutlet weak var ivPic: UIImageView!
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
            ivPic.image = pic
        }
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    func setupImage(pic: UIImage) {
        self.pic = pic
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / ivPic.bounds.width
        let heightScale = size.height / ivPic.bounds.height
        let minScale = min(widthScale, heightScale)
        self.minScale = minScale
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    fileprivate func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - ivPic.frame.height) / 2)
        ctImageViewTop.constant = yOffset
        ctImageViewBottom.constant = yOffset

        let xOffset = max(0, (size.width - ivPic.frame.width) / 2)
        ctImageViewLeft.constant = xOffset
        ctImageViewRight.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    @IBAction func closeVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doubleTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            UIView.animate(withDuration: 0.25) {
                self.scrollView.zoomScale = self.scrollView.zoomScale != self.minScale ? self.minScale : 1.0
                self.btnClose.isHidden = self.scrollView.zoomScale == self.minScale ? false : true
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func swipeToDismiss(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended, scrollView.zoomScale == minScale {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func pressedLongToShowMenu(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .changed {
            let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let saveBtn = UIAlertAction(title: "Save Picture", style: .default, handler: nil)
            let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(saveBtn)
            alertVC.addAction(cancelBtn)
            
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    
}

extension ZoomVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ivPic
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
