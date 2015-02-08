//
//  DefaultTheme.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation

public class DefaultTheme: Theme {
    
    public func mainColor() -> UIColor {
        return UIColor(red: 0.894, green: 0.000, blue: 0.010, alpha: 1.000)
    }
    
    public func secondaryColor() -> UIColor {
        return UIColor(white: 0.25, alpha: 1.0)
    }
    
    public func backgroundColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    public func freeTextColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    public func headerTextColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    public func tableCellBackgroundColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    public func tableSeperatorColor() -> UIColor {
        return UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0)
    }
    
    public func primaryLabelColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    public func secondaryLabelColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    public func detailLabelColor() -> UIColor {
        return UIColor.darkGrayColor()
    }
    
    public func titleTextColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    public func disabledCellTextColor() -> UIColor {
        return UIColor(white: 0.6, alpha: 0.6)
    }
    
    public func redColor() -> UIColor {
        return UIColor.redColor()
    }
    
    public func yellowColor() -> UIColor {
        return UIColor.yellowColor()
    }
    
    public func greenColor() -> UIColor {
        return UIColor.greenColor()
    }
    
    public func blueColor() -> UIColor {
        return UIColor.blueColor()
    }
    
    public func darkBlueColor() -> UIColor {
        return UIColor(red: 5.0/255.0, green: 56.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    }
    
    public func primaryLabelFont() -> UIFont {
        return UIFont.systemFontOfSize(UIFont.systemFontSize())
    }
    
    public func secondaryLabelFont() -> UIFont {
        return UIFont.systemFontOfSize(UIFont.systemFontSize())
    }
    
    public func detailLabelFont() -> UIFont {
        return UIFont.systemFontOfSize(UIFont.systemFontSize())
    }
    
    public func lightFont(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
}
