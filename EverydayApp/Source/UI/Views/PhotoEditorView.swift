//
//  PhotoEditorView.swift
//  EverydayApp
//
//  Created by Danijel on 17/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoEditorDelegate {
    
}

class PhotoEditorView: UIView, UIGestureRecognizerDelegate {
    
    var backgroundImageView: UIImageView!
    var rotateResizeImageView: UIImageView!
    
    var overImageView: UIImageView?
    var frameImageView: UIImageView?
    
    var backgroundImage: UIImage?
    
    
    required init?(coder aDecoder: NSCoder) {
        
        let resizeRotateImage = UIImage(named: "handle_rotate_resize")!
        self.rotateResizeImageView = UIImageView(image: resizeRotateImage)
        self.rotateResizeImageView.isUserInteractionEnabled = true
        
        super.init(coder: aDecoder)
        
        let tapHandler = UITapGestureRecognizer(target: self, action: #selector(PhotoEditorView.handleTap(recognizer:)))
        self.addGestureRecognizer(tapHandler)
        
        let panHandler = UITapGestureRecognizer(target: self, action: #selector(PhotoEditorView.handlePan(recognizer:)))
        panHandler.delegate = self
        rotateResizeImageView.addGestureRecognizer(panHandler)
        
        setupViewUI()
    }
    
    func setupViewUI() {
        backgroundImageView = UIImageView(frame: self.frame)
        backgroundImageView.contentMode = .scaleAspectFit
        self.addSubview(backgroundImageView)
    }
    
    func setBackgroundImage(image: UIImage) {
        self.backgroundImage = image
        self.backgroundImageView.image = image
    }
    
    //MARK: - UIGestureRecognizer methods
    func handleTap(recognizer: UITapGestureRecognizer) {
        
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        
    }
    
    func addFilterEffect(filterName: String) {
        
        guard let image = backgroundImage else {
            return
        }
        let inputCIImage = CIImage(image: image)
        
        let ciEffect = CIFilter(name: filterName)
        ciEffect?.setValue(inputCIImage, forKey: kCIInputImageKey)
        
        guard let effect = ciEffect else {
            return
        }
        
        guard let ciImage = effect.outputImage else {
            return
        }
        
        self.backgroundImageView.image = UIImage(ciImage: ciImage)
        
    }
    
    func addSticker(stickerName: String) {
        if let image = UIImage(named: stickerName) {
            let stickerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            stickerImageView.image = image
            stickerImageView.contentMode = .scaleAspectFit
            
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(stickerDragged(recognizer:)))
            stickerImageView.addGestureRecognizer(gesture)
            
            let gesturePinch = UIPinchGestureRecognizer(target: self, action: #selector(stickerPinched(recognizer:)))
            stickerImageView.addGestureRecognizer(gesturePinch)
            
            let gestureRotation = UIRotationGestureRecognizer(target: self, action: #selector(stickerRotation(recognizer:)))
            stickerImageView.addGestureRecognizer(gestureRotation)
            
            stickerImageView.isUserInteractionEnabled = true
            gesture.delegate = self
            
            self.addSubview(stickerImageView)
        }
    }
    
    func stickerDragged(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began || recognizer.state == .changed {
            let translation = recognizer.translation(in: self)
            recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self)
        }
    }
    
    func stickerPinched(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    func stickerRotation(recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    func addFrame(frameName: String) {
        if let image = UIImage(named: frameName) {
            frameImageView?.removeFromSuperview()
            frameImageView = nil
            frameImageView = UIImageView(frame: self.frame)
            frameImageView!.image = image
            
            self.addSubview(frameImageView!)
        }
    }
    
    func getScreenShot() -> UIImage? {
        
        UIGraphicsBeginImageContext(self.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
