//
//  TableInputTextFieldViewCell.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputTextFieldViewCell: TableInputViewCell, UITextFieldDelegate {

    public var textField: UITextField
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.textField = UITextField()
        self.textField.textAlignment = .Right
        self.textField.autocapitalizationType = .Sentences
        self.textField.autocorrectionType = .Yes
        self.textField.clearButtonMode = .WhileEditing
        self.textField.returnKeyType = .Next
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textField.delegate = self
        self.setEditing(false, animated: false)
        self.contentView.addSubview(self.textField)
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if let textLabel = self.textLabel {
            
            if textLabel.text == nil {
                
                self.textField.textAlignment = .Left
                self.textField.frame = CGRectMake(10, 10, self.contentView.bounds.size.width-20, 24)
            } else {
                
                self.textField.textAlignment = .Right
                self.textField.frame = CGRectMake(textLabel.bounds.size.width + 20, 10, self.contentView.bounds.size.width - textLabel.bounds.size.width - 30, 24)
                self.textField.center = CGPointMake(self.textField.center.x, textLabel.center.y)
            }
        }
    }

    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let range: Range = Range<String.Index>(start: advance(textField.text.startIndex, range.location), end: advance(textField.text.startIndex, range.location + range.length))
        
        textField.text = textField.text.stringByReplacingCharactersInRange(range, withString: string)
        textField.text = textField.text.stringByReplacingOccurrencesOfString(" ", withString: "\\u00a0", options: NSStringCompareOptions.CaseInsensitiveSearch, range: Range<String.Index>(start: textField.text.startIndex, end: textField.text.endIndex))
        
        self.inputRow?.setValue(textField.text.stringByReplacingOccurrencesOfString("\\u00a0", withString: " ", options: NSStringCompareOptions.CaseInsensitiveSearch, range: Range<String.Index>(start: textField.text.startIndex, end: textField.text.endIndex)))
        
        return false
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        self.inputRow?.setValue(textField.text)
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if let delegate = self.delegate {
            delegate.tableInputViewCellDidFinish(cell: self)
        }
        return true
    }
    
    public override func setEditing(editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        self.textField.userInteractionEnabled = editing
        
        if !editing {
            self.textField.resignFirstResponder()
        }
    }
}
