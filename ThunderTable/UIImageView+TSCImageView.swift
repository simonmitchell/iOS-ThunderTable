//
//  UIImageView+TSCImageView.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 08/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation
import ObjectiveC

private var imageRequestAssociationKey: UInt8 = 0

extension UIImageView {
    
    public func setImageURL(imageURL: NSURL, placeholderImage placeholder: UIImage?) {
        self.setImageURL(imageURL, placeholderImage: placeholder, animated: false)
    }
    
    public func setImageURL(imageURL: NSURL, placeholderImage placeholder: UIImage?, animated anim: Bool) {
        
        self.cancelCurrentRequestOperation()
        self.contentMode = .ScaleAspectFill
        self.image = placeholder
        
        let operation = ImageController.sharedController().requestImage(imageURL, completion: { (image: UIImage?, error: NSError?, cached: Bool) -> () in
            
            if let newImage = image {
                self.image = newImage
            }
            
            if anim && !cached {
                
                let transition = CATransition()
                transition.type = kCATransitionFade
                transition.duration = 0.25
                self.layer.addAnimation(transition, forKey: nil)
            }
        })
        self.setCurrentImageRequestOperation(operation)
    }
    
    private func cancelCurrentRequestOperation() {
        
        if let operation = self.currentImageRequestOperation() {
            
            operation.cancel()
            self.setCurrentImageRequestOperation(nil)
        }
    }
    
    private func setCurrentImageRequestOperation(operation: ImageRequestOperation?) {
        objc_setAssociatedObject(self, &imageRequestAssociationKey, operation, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
    }
    
    private func currentImageRequestOperation() -> ImageRequestOperation? {
        return objc_getAssociatedObject(self, &imageRequestAssociationKey) as? ImageRequestOperation
    }
}