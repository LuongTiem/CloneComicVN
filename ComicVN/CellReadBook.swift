//
//  CellReadBook.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/15/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellReadBook: UICollectionViewCell,UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
        configureImage()
        
        
    }
    
    
    
    
    func initialize(){
        
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 0
        self.scrollView.maximumZoomScale = 4
        
        
    }
    
    
    //--
    
    func configureImage(){
        imageViews.contentMode = .scaleAspectFit
        imageViews.isUserInteractionEnabled  = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapGestureRecognizer(_:)))
        tapGesture.numberOfTapsRequired = 2
        imageViews.addGestureRecognizer(tapGesture)
        
        setZoomScale()
        scrollViewDidZoom(scrollView)
        
        
    }
    
    func setZoomScale(){
        let imageViewSize = imageViews.bounds.size
        let scrollViewSize = scrollView.bounds.size
        
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: false)
    }
    
    
    // MARK: Delegate ScrollView
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let imageViewSize = imageViews.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height)/2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width)/2 : 0
        
        
        if (verticalPadding >= 0) {
            //-- can giua man hinh
            scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        }else{
            
            scrollView.contentSize = imageViewSize
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.imageViews
    }
    
    
    
    
    
}

extension CellReadBook {
    
    // MARK: Gesture double tap
    
    func doubleTapGestureRecognizer(_ locationGesture : UITapGestureRecognizer){
        //--zoom in , zoom out
        if (scrollView.zoomScale >= scrollView.maximumZoomScale/2) {
            
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }else{
            let center = locationGesture.location(in: locationGesture.view)
            let zoomRect = zoomRectForScale(scrollView.minimumZoomScale * 2, center: center)
            scrollView.zoom(to: zoomRect, animated: true)
            
        }
        
    }
    
    
    func zoomRectForScale(_ scale :CGFloat, center : CGPoint ) -> CGRect{
        var zoomRect = CGRect.zero
        
        zoomRect.size.height = scrollView.frame.size.height / scale
        zoomRect.size.width =  scrollView.frame.size.width / scale
        
        
        //-- choose origin so as to get the right center
        
        zoomRect.origin.x =  center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        
        return zoomRect
    }
    
    
}

