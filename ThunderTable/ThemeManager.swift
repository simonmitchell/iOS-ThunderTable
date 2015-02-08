//
//  ThemeManager.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation

private var themeManagerSharedInstance: Theme?

public func isPad() -> Bool {
    return (UIDevice.currentDevice().respondsToSelector("userInterfaceIdiom") ? UIDevice.currentDevice().userInterfaceIdiom : UIUserInterfaceIdiom.Phone) == UIUserInterfaceIdiom.Pad
}

public func isOS8() -> Bool {
    
    switch NSString(format: "%@",UIDevice.currentDevice().systemName).compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        
    case .OrderedSame:
        return true
    case .OrderedDescending:
        return true
    default:
        return false
    }
}

public class ThemeManager {
    
    public class func sharedTheme() -> Theme {
        
        if (themeManagerSharedInstance == nil) {
            themeManagerSharedInstance = DefaultTheme()
        }
        return themeManagerSharedInstance!
    }
    
    class func setSharedTheme(theme: Theme) {
        themeManagerSharedInstance = theme
    }
    
    
}
