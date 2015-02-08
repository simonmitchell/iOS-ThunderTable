//
//  TableInputTextFieldRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputTextFieldRow: TableInputRow {
   
    public var placeholder: String?
    public var keyboardType: UIKeyboardType
    public var returnKeyType: UIReturnKeyType
    public var secure: Bool
    public var autoCorrectionType: UITextAutocorrectionType
    public var autoCapitalizationType: UITextAutocapitalizationType
    
    override init(title: String?, placeholder: String?, inputId: String, required: Bool) {
        
        self.keyboardType = .NumbersAndPunctuation
        self.returnKeyType = .Default
        self.secure = false
        self.autoCorrectionType = .Default
        self.autoCapitalizationType = .Sentences
        super.init(title: title, placeholder: placeholder, inputId: inputId, required: required)
    }
    
    public override func customise(cell: UITableViewCell) -> UITableViewCell {
        
        if let inputCell = cell as? TableInputTextFieldViewCell {
            
            inputCell.textField.placeholder = self.placeholder
            inputCell.textField.keyboardType = self.keyboardType
            inputCell.textField.returnKeyType = self.returnKeyType
            inputCell.textField.secureTextEntry = self.secure
            inputCell.textField.autocapitalizationType = self.autoCapitalizationType
            inputCell.textField.autocorrectionType = self.autoCorrectionType
            
            if self.rowValue() != nil {
                
                if !self.rowValue()!.isKindOfClass(NSNull.self) {
                    inputCell.textField.text = "\(self.rowValue()!)"
                }
            } else {
                inputCell.textField.text = nil
            }
        }
        
        return cell
    }
}
