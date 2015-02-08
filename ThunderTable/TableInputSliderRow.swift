//
//  TableInputSliderRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableInputSliderRow: TableInputRow, TableInputSliderRowDataSource {
   
    public var sliderMinValue: Float
    public var sliderMaxValue: Float
    public var currentValue: Float
    
    init(title: String?, inputId id: String, minValue min: Float, maxValue max: Float, currentValue val: Float, required req: Bool) {
        
        self.sliderMaxValue = max
        self.sliderMinValue = min
        self.currentValue = val
        super.init(title: title, placeholder: nil, inputId: id, required: req)
        self.setValue(val)
    }
    
    public func maximumValue() -> Float {
        return self.sliderMaxValue
    }
    
    public func minimumValue() -> Float {
        return self.sliderMinValue
    }
    
    public override func tableViewCellClass() -> AnyClass? {
        return TableInputSliderViewCell.self
    }
    
    public override func customise(cell: UITableViewCell) -> UITableViewCell {
        
        if let inputCell = cell as? TableInputSliderViewCell {
            
            inputCell.slider.maximumValue = self.maximumValue()
            inputCell.slider.minimumValue = self.minimumValue()
            
            if let value = self.value as? Float {
                inputCell.slider.setValue(value, animated: true)
            } else {
                inputCell.slider.setValue(self.currentValue, animated: true)
            }
        }
        return cell
    }
}
