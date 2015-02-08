//
//  TableInputSwitchViewCell.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputSwitchViewCell: TableInputViewCell {

    public var primarySwitch: UISwitch
    override public var inputRow: TableInputRowDataSource? {
        
        didSet {
            
            if let switchInputRow = self.inputRow {
                
                if let switchRowVal = switchInputRow.rowValue() as? Bool {
                    self.primarySwitch.on = switchRowVal
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.primarySwitch = UISwitch()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.primarySwitch.addTarget(self, action: "handleSwitch:", forControlEvents: .ValueChanged)
        self.contentView.addSubview(self.primarySwitch)
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let imageWidth = self.imageView != nil ? self.imageView!.frame.size.width : 0
        let constrainedSize = CGSizeMake(self.contentView.frame.size.width - 78 - 20 - imageWidth, 999999)
        if let label = self.textLabel {
            
            let textLabelSize = label.sizeThatFits(constrainedSize)
            label.frame = CGRectMake(15 + imageWidth, label.frame.origin.y, textLabelSize.width, textLabelSize.height + 10)
            label.center = self.contentView.center
        }
        self.primarySwitch.frame = CGRectMake(self.contentView.bounds.size.width - 78 - 5, self.contentView.bounds.size.height/2 - 28, 78, 28)
    }
    
    internal func handleSwitch(sender: UISwitch) {
        
        if let switchRow = self.inputRow as? TableInputSwitchRow {
            
            switchRow.on = self.primarySwitch.on
            switchRow.value = switchRow.on
            
            if let switchRowDelegate = switchRow.delegate {
                
                switchRowDelegate.inputSwitchRow(switchRow, changedToState: switchRow.on)
            }
            
            if let switchRowSelectionHandler = switchRow.selectionHandler {
                
                var indexPath = NSIndexPath(forItem: 0, inSection: 0)
                if let parentTableView = self.parentViewController {
                    indexPath = self.parentViewController?.tableView.indexPathForCell(self)
                }
                switchRowSelectionHandler(row: switchRow, cell: self, indexPath: indexPath)
            }
        }
        
        self.inputRow?.setValue(sender.on)
    }
    
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, withEvent: event)
        if !self.primarySwitch.pointInside(self.convertPoint(point, toView: self.primarySwitch), withEvent: event) {
            return nil
        }
        return hitView
    }
}
