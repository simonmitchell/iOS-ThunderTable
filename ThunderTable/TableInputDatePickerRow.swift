//
//  TableInputDatePickerRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputDatePickerRow: TableInputRow {
    
    public var datePickerMode: UIDatePickerMode
//    override public var value: NSDate?
    
    public init(title: String?,datePickerMode mode: UIDatePickerMode,inputIdentifier inputId: String, required: Bool) {
        
        self.datePickerMode = mode
        super.init(title: title, placeholder: nil, inputId: inputId, required: required)
    }
    
    public override func tableViewCellClass() -> AnyClass? {
        return TableInputDatePickerViewCell.self
    }
}
