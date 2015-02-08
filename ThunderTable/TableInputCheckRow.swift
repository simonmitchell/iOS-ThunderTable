//
//  TableInputCheckRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputCheckRow: TableInputRow {
   
    public init(title: String?, inputId id: String, required req: Bool) {
        
        super.init(title: title, placeholder: nil, inputId: id, required: req)
    }
    
    public override func tableViewCellClass() -> AnyClass? {
        return TableInputCheckViewCell.self
    }
}