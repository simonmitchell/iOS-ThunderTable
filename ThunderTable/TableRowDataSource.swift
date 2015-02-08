//
//  TableRowDataSource.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation
import UIKit

public typealias TableSelectionHandler = (row: TableRowDataSource, cell: UITableViewCell?, indexPath: NSIndexPath) -> ()

/**
All objects that can be displayed in a `TSCTableViewController` must conform to the `TableRowDataSource` protocol. This protocol is useful for defining how a object should represent itself in a tableview without the need to build a custom cell for display in a number of circumstances
*/
@objc public protocol TableRowDataSource: class {
    
    ///---------------------------------------------------------------------------------------
    /// @name General setup
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract Provide an estimated cell height to improve tableView loading performance where possible
    */
    optional func estimatedCellHeight() -> CGFloat
    
    /**
    @abstract The text to be displayed in the cells `textLabel`
    */
    func rowTitle() -> String?
    
    /**
    @abstract The text to be displayed in the cells `detailTextLabel`
    */
    optional func rowSubtitle() -> String?
    
    /**
    @abstract The `UIImage` to be displayed in the cell
    */
    optional func rowImage() -> UIImage?
    
    /**
    @abstract The URL of the image to be loaded into the image area of the cell
    */
    optional func rowImageURL() -> NSURL?
    
    /**
    @abstract The placeholder image that is displayed whilst the cell is asynchronously loading the image defined by the `imageURL`
    */
    optional func rowImagePlaceholder() -> UIImage?
    
    /**
    @abstract The table view cell style for the cell to be displayed
    */
    optional func rowStyle() -> Int
    
    /**
    @abstract The text color to use for the textLabel (Main label) of the cell
    */
    optional func rowTextColor() -> UIColor?
    
    ///---------------------------------------------------------------------------------------
    /// @name Overriding cell layout behaviour
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract The `Class` to override the UITableViewCell with when displaying the row.
    @discussion Provide a custom class to have `TSCTableViewController` use this class when rendering the row in the table view
    */
    func tableViewCellClass() -> AnyClass?
    
    /**
    @abstract This method delivers the `cell` which has been rendered based on the other methods in the protocol.
    @discussion This is the last chance to further customise the cell before it is rendered in the `TableViewController`
    @param cell The cell that will be rendered, please return this when you are finished customising
    @note If you have overidden the class used by the row, this method will return a cell of that class type
    */
    optional func customise(cell: UITableViewCell) -> UITableViewCell
    
    /**
    @abstract The amount of padding to apply to the contents of the cell.
    @discussion You may find that adjusting this padding value on the cell improves the look and feel of your app
    */
    optional func rowPadding() -> UIEdgeInsets
    
    /**
    @abstract The background color of the row
    */
    optional func rowBackgroundColor() -> UIColor?
    
    ///---------------------------------------------------------------------------------------
    /// @name Selection and editing behaviour
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract The closure to be called when the user selects the row
    */
    optional func rowSelectionHandler() -> TableSelectionHandler?
    
    /**
    @abstract The link that a row should attempt to push when selected
    */
//    func rowLink() -> TSCLink
    
    /**
    @abstract A boolean indicating if the cell should display the accessory view.
    @note This is only respected if the row handler is not nil. Otherwise neither are displayed
    */
    optional func rowShouldDisplaySelectionIndicator() -> Bool
    
    /**
    @abstract A boolean indicating if the cell should display the highlight state for selection
    @note This is only respected if the row selection target and row selector are both not nil. Otherwise neither are displayed
    */
    optional func shouldDisplaySelectionCell() -> Bool
    
    /**
    @abstract A boolean indicating if the cell should display remain selected after being tapped
    */
    optional func shouldRemainSelected() -> Bool
    
    /**
    @abstract A boolean indicating if the cell should display the seperator between itself and it's surrounding cells
    */
    optional func shouldDisplaySeperators() -> Bool
    
    /**
    @abstract A boolean indicating whether or not the cell should allow editing
    */
    optional func canEditRow() -> Bool
    
    /**
    @abstract The level of indentation to enable in the cell
    @discussion The default value is `0`
    */
    optional func indentationLevel() -> Int
    
    /**
    @abstract The type of accessory to be shown on the cell if the row is selectable
    */
    optional func rowAccessoryType() -> UITableViewCellAccessoryType
    
    ///---------------------------------------------------------------------------------------
    /// @name Optimizing performance
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract Provides a height for the constrained size sent to it
    */
    optional func cellHeightConstrainedBy(size: CGSize) -> Float
}

