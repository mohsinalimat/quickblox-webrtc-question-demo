//
//  LocalView.swift
//  QuickbloxDemo
//
//  Created by 默司 on 2016/12/12.
//  Copyright © 2016年 默司. All rights reserved.
//

import UIKit

class LocalView: UIView {

    var videoLayer: AVCaptureVideoPreviewLayer!
    var container: UIView!
    
    func set(_ previewlayer: AVCaptureVideoPreviewLayer) {
        self.videoLayer = previewlayer
        self.videoLayer.videoGravity = AVLayerVideoGravityResizeAspect
        self.subviews.forEach({$0.removeFromSuperview()})
        self.container = UIView(frame: self.bounds)
        self.container.backgroundColor = UIColor.clear
        self.container.layer.addSublayer(self.videoLayer)
        self.insertSubview(self.container, at: 0)
    }

}
