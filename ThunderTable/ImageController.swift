//
//  ImageController.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 08/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation

private let _ImageControllerSharedInstance = ImageController()

public class ImageController: NSOperationQueue {
    
    private var imageCache: NSCache
    
    private override init() {
        
        self.imageCache = NSCache()
        super.init()
        self.maxConcurrentOperationCount = 30
    }
    
    public class func sharedController() -> ImageController {
        return _ImageControllerSharedInstance
    }
    
    public func requestImage(imageURL: NSURL, completion compl:ImageRequestOperationCompletion?) -> ImageRequestOperation {
        
        let operation = ImageRequestOperation(imageURL: imageURL)
        operation.completion = compl
        self.addOperation(operation)
        return operation
    }
    
    public func requestCachedImage(imageURL: NSURL) -> UIImage? {
        return self.imageCache.objectForKey(imageURL) as? UIImage
    }
    
    public func cacheImage(image: UIImage, imageURL url: NSURL) {
        self.imageCache.setObject(image, forKey: url)
    }
}
