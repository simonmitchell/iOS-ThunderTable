//
//  TableViewCell.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableViewCell: UITableViewCell {
    
    weak public var parentViewController: TableViewController?
    public var separatorTopView: UIView
    public var separatorBottomView: UIView
    public var shouldDisplaySeparators: Bool {
        
        didSet {
            self.separatorBottomView.hidden = !shouldDisplaySeparators
            self.separatorTopView.hidden = !shouldDisplaySeparators
        }
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.separatorTopView = UIView()
        self.separatorBottomView = UIView()
        self.shouldDisplaySeparators = true
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        
        self.separatorTopView.backgroundColor = ThemeManager.sharedTheme().tableSeperatorColor()
        self.contentView.addSubview(self.separatorTopView)
        
        self.separatorBottomView.backgroundColor = ThemeManager.sharedTheme().tableSeperatorColor()
        self.contentView.addSubview(self.separatorBottomView)
        
        self.textLabel?.numberOfLines = 0
        self.textLabel?.backgroundColor = UIColor.clearColor()
        
        self.detailTextLabel?.numberOfLines = 0
        self.detailTextLabel?.font = UIFont.systemFontOfSize(14)
        self.detailTextLabel?.textColor = UIColor.grayColor()
        
        self.contentView.superview?.clipsToBounds = false
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if UIScreen.mainScreen().respondsToSelector("scale") && UIScreen.mainScreen().scale == 1.00 {
            
            self.separatorTopView.frame = CGRectMake(0, 0, self.bounds.size.width, 1);
            self.separatorBottomView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 1);
        } else {
            
            self.separatorTopView.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
            self.separatorBottomView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 0.5);
        }
    }
}
