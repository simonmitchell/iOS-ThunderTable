//
//  TableInputDatePickerViewCell.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputDatePickerViewCell: TableInputViewCell {

    public var dateFormatter: NSDateFormatter
    public var dateLabel: UITextField
    public var datePicker: UIDatePicker
    override public var inputRow: TableInputRowDataSource? {
        didSet {
            
            if let row = self.inputRow {
                
                if let datePickerRow = self.inputRow as? TableInputDatePickerRow {
                    
                    switch datePickerRow.datePickerMode {
                    case .Date:
                        self.dateFormatter.dateStyle = .LongStyle
                    case .Time:
                        self.dateFormatter.dateStyle = .ShortStyle
                    case .DateAndTime:
                        self.dateFormatter.dateStyle = .MediumStyle
                        self.dateFormatter.timeStyle = .ShortStyle
                    case .CountDownTimer:
                        self.dateFormatter.dateFormat = "'Every' HH 'hours' mm 'minutes'"
                    default:
                        self.dateFormatter.dateStyle = .MediumStyle
                    }
                    
                    if let rowValue = datePickerRow.value as? NSDate {
                        self.dateLabel.text = self.dateFormatter.stringFromDate(rowValue)
                    }
                    
                    self.datePicker.datePickerMode = datePickerRow.datePickerMode
                }
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.dateFormatter = NSDateFormatter()
        self.dateLabel = UITextField()
        self.dateLabel.backgroundColor = UIColor.clearColor()
        self.datePicker = UIDatePicker()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.datePicker.addTarget(self, action: "handleDatePicker:", forControlEvents: UIControlEvents.ValueChanged)
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.inputView = self.datePicker
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        self.dateLabel.frame = CGRectMake(self.contentView.frame.size.width - 180 - 10, 10, 180, 20)
        self.dateLabel.adjustsFontSizeToFitWidth = true
        
        if let textLabel = self.textLabel {
            
            self.dateLabel.center = CGPointMake(self.dateLabel.center.x, textLabel.center.y)
        }
    }
    
    public override func setEditing(editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        if !editing {
            self.dateLabel.resignFirstResponder()
        }
    }
    
    func handleDatePicker(datePicker: UIDatePicker) {
        
        self.dateLabel.text = self.dateFormatter.stringFromDate(datePicker.date)
        self.inputRow?.setValue(datePicker.date)
    }
}
