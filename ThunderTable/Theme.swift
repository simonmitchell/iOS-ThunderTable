//
//  Theme.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation

public protocol Theme {
    
    func mainColor() -> UIColor
    func secondaryColor() -> UIColor
    func backgroundColor() -> UIColor
    func freeTextColor() -> UIColor
    func headerTextColor() -> UIColor
    func tableCellBackgroundColor() -> UIColor
    func tableSeperatorColor() -> UIColor
    func primaryLabelColor() -> UIColor
    func secondaryLabelColor() -> UIColor
    func detailLabelColor() -> UIColor
    func titleTextColor() -> UIColor
    func disabledCellTextColor() -> UIColor
    func redColor() -> UIColor
    func yellowColor() -> UIColor
    func greenColor() -> UIColor
    func blueColor() -> UIColor
    func darkBlueColor() -> UIColor
    
    func primaryLabelFont() -> UIFont
    func secondaryLabelFont() -> UIFont
    func detailLabelFont() -> UIFont
    func lightFont(size: CGFloat) -> UIFont
}