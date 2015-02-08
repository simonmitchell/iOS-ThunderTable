//
//  TableInputPickerViewCell.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputPickerViewCell: TableInputViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

    
    public var selectionLabel: UITextField
    public var pickerView: UIPickerView
    public var values: [String]
    public var placeholder: String?
    override public var inputRow: TableInputRowDataSource? {
        didSet {
            
            if let value = self.inputRow?.rowValue() as? String {
                self.selectionLabel.text = value
            } else {
                self.selectionLabel.text = nil
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.selectionLabel = UITextField()
        self.selectionLabel.textAlignment = .Right
        self.selectionLabel.backgroundColor = UIColor.clearColor()
        self.selectionLabel.text = nil
        
        self.pickerView = UIPickerView()
        self.values = []
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.selectionLabel.frame = CGRectMake(self.contentView.frame.size.width - 180 - 10, 10, 180, 35);
        self.selectionLabel.center = CGPointMake(self.selectionLabel.center.x, self.contentView.center.y);
        
        if let rowValue: String = self.inputRow?.rowValue() as? String {
            self.selectionLabel.text = rowValue
        }
    }
    
    public override func setEditing(editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        if editing {
            self.selectionLabel.textColor = ThemeManager.sharedTheme().mainColor()
        } else {
            self.selectionLabel.textColor = ThemeManager.sharedTheme().primaryLabelColor()
        }
    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.values.count + 1
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        let placeholderString = self.placeholder != nil ? self.placeholder : "Please Select"
        return row == 0 ? "-- \(self.placeholder!) --" : self.values[row-1]
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row != 0 {
            
            self.selectionLabel.text = self.values[row-1]
            self.inputRow?.setValue(self.values[row - 1])
        }
    }
}

