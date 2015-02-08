//
//  TableInputRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputRow: TableRow, TableInputRowDataSource {
   
    public var value: AnyObject?
    public var required: Bool
    public var inputId: String
    
    public init(title: String?, placeholder: String?, inputId: String, required: Bool) {
        
        self.required = required
        self.inputId = inputId
        super.init(title: title, subtitle: nil, image: nil, selectionHandler: nil)
    }
    
    public func rowInputId() -> String {
        return self.inputId
    }
    

    public func rowValue() -> AnyObject? {
        return self.value
    }
    
    public func rowRequired() -> Bool {
        return self.required
    }
    
    public func setValue(value: AnyObject?) {
        self.value = value
    }
}
