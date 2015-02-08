//
//  ImageRequestOperation.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 08/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation

public typealias ImageRequestOperationCompletion = (image: UIImage?, error: NSError?, cached: Bool) -> ()

public class ImageRequestOperation: NSOperation, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    public var imageURL: NSURL
    public var connection: NSURLConnection?
    public var data: NSMutableData?
    public var image: UIImage?
    public var cached: Bool?
    
    public var isConcurrent: Bool
    public var isFinished: Bool
    
    public var completion: ImageRequestOperationCompletion?
    
    public init(imageURL: NSURL) {
        
        self.isConcurrent = true
        self.imageURL = imageURL
        self.isFinished = false
        super.init()
    }
    
    public override func start() {
        
        if let cachedImage = ImageController.sharedController().requestCachedImage(self.imageURL) {
            
            self.cached = true
            self.image = cachedImage
            self.complete(error: nil)
        } else {
            
            let imageURLRequest = NSURLRequest(URL: self.imageURL)
            self.connection = NSURLConnection(request: imageURLRequest, delegate: self, startImmediately: false)
            self.connection?.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            self.connection?.start()
            
            self.isFinished = true
        }
    }
    
    public override func cancel() {
        self.connection?.cancel()
    }
    
    //MARK: Connection delegate
    
    private func complete(error err: NSError?) {
        
        self.data = nil
        self.connection = nil
        self.isFinished = true
        self.isConcurrent = false
        
        if let completionBlock = self.completion {
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completionBlock(image: self.image, error: err, cached: self.cached != nil ? self.cached! : false)
            })
        }
    }
    
    public func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        if let alreadyData = self.data {
            alreadyData.appendData(data)
        } else {
            self.data = NSMutableData(data: data)
        }
    }
    
    public func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        self.complete(error: error)
    }
    
    public func connectionDidFinishLoading(connection: NSURLConnection) {
        
        self.cached = false
        if let data = self.data {
            self.image = UIImage(data: data)
        }
        if let image = self.image {
            
            ImageController.sharedController().cacheImage(image, imageURL: self.imageURL)
            self.complete(error: nil)
        } else {
            self.complete(error: NSError(domain: "com.threesidedcube.thundertable", code: 1001, userInfo: [NSLocalizedDescriptionKey:"The server did not return a valid image"]))
        }
    }
}
