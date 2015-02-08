//
//  TableInputTextViewViewCell.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputTextViewViewCell: TableInputViewCell, UITextViewDelegate {

    public var textView: UITextView
    public var placeholder: String? {
        
        didSet {
            
            self.textViewDidEndEditing(self.textView)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.textView = UITextView()
        self.textView.textAlignment = .Right
        self.textView.textColor = UIColor.blackColor()
        self.textView.returnKeyType = .Next
        self.placeholder = ""
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textView.delegate = self
        self.contentView.addSubview(self.textView)
        self.setEditing(false, animated: false)
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if self.textLabel?.text == nil {
            
            self.textView.textAlignment = .Left
            self.textView.frame = CGRectMake(10, 0, self.contentView.bounds.size.width - 20, self.contentView.bounds.size.height)
        } else {
            
            self.textView.textAlignment = .Right;
            self.textView.frame = CGRectMake(self.textLabel!.bounds.size.width + 20, 0, self.contentView.bounds.size.width - self.textLabel!.bounds.size.width - 30, self.contentView.bounds.size.height);
        }
    }
    
    public override func setEditing(editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        self.textView.userInteractionEnabled = editing
        if !editing {
            self.textView.resignFirstResponder()
        }
    }
    
    //MARK: - UITextView delegates
    
    public func textViewDidEndEditing(textView: UITextView) {
        
        self.inputRow?.setValue(textView.text)
        
        if textView.text == "" {
            
            self.textView.text = self.placeholder
            self.textView.textColor = UIColor.lightGrayColor()
        }
        
        self.inputRow?.setValue(textView.text)
    }
    
    public func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        self.textView.textColor = UIColor.blackColor()
        
        if(self.textView.text == self.placeholder) {
            self.textView.text = ""
        }
        
        return true
    }
}
