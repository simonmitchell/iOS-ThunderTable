//
//  TableInputSliderViewCell.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputSliderViewCell: TableInputViewCell {

    public var slider: UISlider
    public var valueLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.slider = UISlider()
        self.valueLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.valueLabel.backgroundColor = ThemeManager.sharedTheme().mainColor()
        self.valueLabel.textAlignment = .Center
        self.valueLabel.textColor = UIColor.whiteColor()
        self.valueLabel.layer.cornerRadius = 5
        self.valueLabel.layer.masksToBounds = true
        self.contentView.addSubview(self.valueLabel)
        
        self.slider.addTarget(self, action: "handleSliderValueChanged:", forControlEvents: .ValueChanged)
        self.contentView.addSubview(self.slider)
    }

    public override func layoutSubviews() {
        
        super.layoutSubviews()
        self.valueLabel.text = NSString(format: "%.2f", self.slider.value)
        let valueSize = self.valueLabel.sizeThatFits(CGSizeMake(self.contentView.bounds.size.width, self.contentView.bounds.size.height))
        
        if let textLabel = self.textLabel {
            
            textLabel.frame = CGRectMake(self.contentView.frame.origin.x + 16, textLabel.frame.origin.y, textLabel.frame.size.width, textLabel.frame.size.height)
        }
        
        self.valueLabel.frame = CGRectMake(self.textLabel != nil ? CGRectGetMaxX(self.textLabel!.frame) + 10 : 14, self.contentView.frame.size.height / 2 - (valueSize.height + 2)/2, valueSize.width + 10, valueSize.height + 5)
        self.slider.frame = CGRectMake(CGRectGetMaxX(self.valueLabel.frame) + 10, 0, self.contentView.bounds.size.width - CGRectGetMaxX(self.valueLabel.frame), self.contentView.frame.size.height)
    }
    
    public func handleSliderValueChanged(sender: UISlider) {
        
        self.inputRow?.setValue(slider.value)
        self.layoutSubviews()
    }
}
