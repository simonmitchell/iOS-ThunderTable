//
//  TableInputTextViewRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputTextViewRow: TableInputRow {
   
    public var placeholder: String?
    public var cellHeight: Float
    
    init(placeholder: String?, inputId id: String, required req: Bool, cellHeight height: Float) {
        
        self.cellHeight = height
        super.init(title: nil, placeholder: placeholder, inputId: id, required: req)
        self.placeholder = placeholder
    }
    
    public override func tableViewCellClass() -> AnyClass? {
        return TableInputTextViewViewCell.self
    }
    
    public override func customise(cell: UITableViewCell) -> UITableViewCell {
        
        if let inputCell = cell as? TableInputTextViewViewCell {
            
            inputCell.placeholder = self.placeholder
            
            if self.rowValue() != nil {
                
                if !self.rowValue()!.isKindOfClass(NSNull.self) {
                    inputCell.textView.text = "\(self.rowValue()!)"
                }
            } else {
                inputCell.textView.text = nil
            }
        }
        
        return cell
    }
    
    //MARK: Extended table row datasource

    public override func estimatedCellHeight() -> CGFloat {
        return CGFloat(self.cellHeight)
    }
    
    public func cellHeightConstrainedBy(size: CGSize) -> Float {
        return self.cellHeight
    }
}
