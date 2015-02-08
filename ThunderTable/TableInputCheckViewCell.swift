//
//  TableInputCheckViewCell.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputCheckViewCell: TableInputViewCell {

    public var checkView: CheckView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.checkView = CheckView(frame: CGRectMake(0, 0, 30, 30))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.checkView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self.checkView, action: "handleTap:")
        self.checkView.addTarget(self, action: "handleCheck", forControlEvents: .ValueChanged)
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        self.checkView.frame = CGRectMake(10, self.contentView.bounds.size.height/2 - 15, 30, 30)
        
        if var textLabelFrame: CGRect = self.textLabel?.frame {
            
            let textLabelSize = self.textLabel!.sizeThatFits(CGSizeMake(self.contentView.frame.size.width - CGRectGetMaxX(self.checkView.frame), 999999))
            textLabelFrame = CGRectMake(18, 5, textLabelSize.width, textLabelSize.height)
            
            self.textLabel!.frame = textLabelFrame
        }
    }
    
    internal func handleCheck() {
        
        self.inputRow?.setValue(self.checkView.on)
    }
}
