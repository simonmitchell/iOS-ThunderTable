//
//  TableInputSwitchRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public protocol TableInputSwitchRowDelegate: class {
    
    func inputSwitchRow(row: TableInputSwitchRow, changedToState: Bool)
}

public class TableInputSwitchRow: TableInputRow {
    
    public var on: Bool
    public weak var delegate: TableInputSwitchRowDelegate?
    
    public convenience init(title: String?, inputIdentifier inputId: String, required: Bool) {
        
        self.init(title: title, image: nil, inputIdentifier: inputId, required: required)
    }
    
    public init(title: String?, image: UIImage?, inputIdentifier inputId: String, required: Bool) {
        
        self.on = false
        super.init(title: title, placeholder: nil, inputId: inputId, required: required)
        self.image = image
    }
   
    public override func tableViewCellClass() -> AnyClass? {
        return TableInputSwitchViewCell.self
    }
    
    public override func customise(cell: UITableViewCell) -> UITableViewCell {
        
        if let inputCell = cell as? TableInputSwitchViewCell {
            
            if let val: AnyObject = self.value {
                inputCell.inputRow?.setValue(val)
            } else {
                inputCell.inputRow?.setValue(false)
            }
            
            if let boolValue: Bool = self.value as? Bool {
                
                inputCell.primarySwitch.on = boolValue
            }
        }
        return cell
    }
}
