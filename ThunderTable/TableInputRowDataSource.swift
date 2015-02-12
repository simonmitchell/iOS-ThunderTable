//
//  TableInputRowDataSource.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation

/**
All input row objects that can be displayed in a `TableViewController` must conform to the `TableInputRowDataSource` protocol. This protocol is required to access the input values of the row.
*/
@objc public protocol TableInputRowDataSource: class, TableRowDataSource {
    
    ///---------------------------------------------------------------------------------------
    /// @name General setup
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract The unique id of the input row. Required for extracting a value
    */
    func rowInputId() -> String
    
    /**
    @abstract The value of the input row
    */
    func rowValue() -> AnyObject?
    
    /**
    @abstract If the input row needs to have a value entered
    */
    func rowRequired() -> Bool
    
    /**
    @abstract Sets the value of the input row
    */
    func setValue(value: AnyObject?)
}

/**
The `TableInputSliderRowDataSource` inhertis the `TableInputRowDataSource` protocol and is specific to slider input types.
*/
public protocol TableInputSliderRowDataSource: TableInputRowDataSource {
    
    ///---------------------------------------------------------------------------------------
    /// @name General setup
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract The maximum value the slider can reach
    */
    func maximumValue() -> Float
    
    /**
    @abstract The minimum value the slider can reach
    */
    func minimumValue() -> Float
}
