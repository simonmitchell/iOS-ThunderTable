//
//  TableInputPickerRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputPickerRow: TableInputRow {
    
    public var values: [String]
    public var placeholder: String?
    private var cell: TableInputPickerViewCell?
    
    public init(rowTitle title: String?, inputIdentifier inputId: String, pickerValues values: [String], required: Bool) {
        
        self.values = values
        super.init(title: title, placeholder: nil, inputId: inputId, required: required)
    }
    
    public override func tableViewCellClass() -> AnyClass? {
        return TableInputPickerViewCell.self
    }
    
    public override func customise(cell: UITableViewCell) -> UITableViewCell {
        
        if let pickerCell = cell as? TableInputPickerViewCell {
            
            self.cell = pickerCell
            pickerCell.inputRow = self
            pickerCell.values = self.values
            pickerCell.placeholder = self.placeholder
        }
        
        return cell
    }
}
