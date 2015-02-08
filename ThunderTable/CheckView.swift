//
//  CheckView.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class CheckView: UIControl {
    
    public var onTintColor: UIColor {
        didSet {
            
            if self.on {
                self.outerLayer.backgroundColor = self.onTintColor.CGColor
            }
        }
    }
    
    public var outerLayer: CALayer
    public var innerLayer: CALayer
    public var on: Bool
    public var checkIdentifier: Int? {
        
        didSet {
            
            if let id = self.checkIdentifier {
                
                let on = NSUserDefaults.standardUserDefaults().boolForKey("TSCCheckItem\(id)")
                self.setOn(on, animated: false, saveState: false)
            }
        }
    }

    override init(frame: CGRect) {
        
        self.onTintColor = ThemeManager.sharedTheme().mainColor()
        self.on = false
        self.outerLayer = CALayer()
        self.innerLayer = CALayer()
        super.init(frame: frame)
        
        self.tintColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)
        
        self.outerLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        self.innerLayer.frame = CGRectInset(self.outerLayer.frame, 1.5, 1.5)
        self.outerLayer.cornerRadius = frame.size.width/2
        self.innerLayer.cornerRadius = self.innerLayer.frame.size.width/2
        
        self.layer.addSublayer(self.outerLayer)
        self.layer.addSublayer(self.innerLayer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.addGestureRecognizer(tapGestureRecognizer)
        
        self.setOn(false, animated: false, saveState: false)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func handleTap(sender: UITapGestureRecognizer) {
        
    }
    
    public func setOn(on: Bool, animated anim: Bool) {
        self.setOn(on, animated: anim, saveState: false)
    }
    
    public func setOn(on: Bool, animated anim: Bool, saveState save: Bool) {
        
        self.on = on
        let duration = anim ? 0.25 : 0.0
        
        if on {
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                
                self.outerLayer.backgroundColor = ThemeManager.sharedTheme().mainColor().CGColor
            })
            self.sendActionsForControlEvents(.ValueChanged)
        } else {
            
            UIView.animateWithDuration(duration * 2.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                self.outerLayer.backgroundColor = self.tintColor.CGColor
                }, completion:nil)
            self.sendActionsForControlEvents(.ValueChanged)
        }
        
        if let id = self.checkIdentifier {
            
            if save {
                
                NSUserDefaults.standardUserDefaults().setBool(on, forKey: "TSCCheckItem\(id)")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    public override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        
        if self.userInteractionEnabled {
            return super.pointInside(point, withEvent: event)
        }
        
        return false
    }

}
