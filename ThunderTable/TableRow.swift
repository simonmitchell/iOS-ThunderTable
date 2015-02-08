//
//  TableRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation

/**
`TableRow` is the primary class for creating rows within a `TSCTableViewController`. Each row must be contained within a `TSCTableSection`.
*/

public class TableRow: TableRowDataSource {
    
    /**
    @abstract The amount of padding around the contents of the cell
    */
    public var padding: UIEdgeInsets?
    
    /**
    @abstract The text to be displayed in the cells `textLabel`
    */
    public var title: String?
    
    /**
    @abstract The text to be displayed in the cells `detailTextLabel`
    */
    public var subtitle: String?
    
    /**
    @abstract The `UIImage` to be displayed in the cell
    */
    public var image: UIImage?
    
    /**
    @abstract The URL of the image to be loaded into the image area of the cell
    */
    public var imageURL: NSURL?
    
    /**
    @abstract The placeholder image that is displayed whilst the cell is asynchronously loading the image defined by the `imageURL`
    */
    public var imagePlaceholder: UIImage?
    
    /**
    @abstract The `UIColor` to apply to the text in the cell
    */
    public var textColor: UIColor?
    
    /**
    @abstract The `UIColor to apply to the background of the cell`
    */
    public var backgroundColor: UIColor?
    
    /**
    @abstract The `UITableViewCellStyle` to display the cell as
    */
    public var style: UITableViewCellStyle
    
    /**
    @abstract The link that a row should attempt to push when selected
    */
//    public var link: TSCLink?
    
    ///---------------------------------------------------------------------------------------
    /// @name Handling selection
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract The row handler for when the row is selected
    */
    public var selectionHandler: TableSelectionHandler?
    
    /**
    @abstract A boolean to configure whether the cell shows the selection indicator when it is selectable
    @discussion The default value of this property is `YES`
    */
    public var shouldDisplaySelectionIndicator: Bool?

    ///---------------------------------------------------------------------------------------
    /// @name Initializing a TSCTableRow Object
    ///---------------------------------------------------------------------------------------
    
    /**
    Initializes the row with a single title.
    @param title The title to display in the row
    @discussion The title will populate the `textLabel` text property of a `UITableViewCell`
    */
    public convenience init (title: String!) {
        self.init(title: title, subtitle: nil, image: nil, selectionHandler: nil)
    }
    
    /**
    Initializes the row with a single title in a custom color
    @param title The title to display in the row
    @param A 'UIColor' to color the text with
    @discussion The title will populate the `textLabel` text property of a `UITableViewCell`. The textColor will be applied to the text.
    */
    public convenience init (title: String!, textColor: UIColor?) {
        
        self.init(title: title, subtitle: nil, image: nil, selectionHandler: nil)
        self.textColor = textColor
    }
    
    /**
    Initializes the row with a single title.
    @param title The title to display in the row
    @param subtitle The URL of the image to be displayed to the left hand side of the cell. Loaded asynchronously
    @discussion The title will populate the `textLabel` text property and the subtitle will populate the `detailTextLabel` text property of the `UITableViewCell`
    @note Please set the `imagePlaceholder` property when using this method. This is required because the image width and height is used at layout to provide appropriate space for your loaded image.
    */
    public convenience init (title: String?, subtitle: String?, imageURL: NSURL?) {
        
        self.init(title: title, subtitle: subtitle, image: nil, selectionHandler: nil)
        self.imageURL = imageURL
    }
    
    /**
    Initializes the row with a single title.
    @param title The title to display in the row
    @param subtitle The subtitle to display beneath the title in the row
    @param image The image to be displayed to the left hand side of the cell
    @param handler The selection handler to be used for the cell
    @discussion The title will populate the `textLabel` text property and the subtitle will populate the `detailTextLabel` text property of the `UITableViewCell`
    */
    public init (title: String?, subtitle: String?, image: UIImage?, selectionHandler: TableSelectionHandler?) {
        
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.selectionHandler = selectionHandler
        self.shouldDisplaySelectionIndicator = true
        self.style = UITableViewCellStyle.Subtitle
    }
    
    //mark - TableRowDataSource methods
    
    public func rowTitle() -> String? {
        return self.title
    }
    
    public func rowSubtitle() -> String? {
        return self.subtitle
    }
    
    public func rowImage() -> UIImage? {
        return self.image
    }
    
    public func rowImageURL() -> NSURL? {
        return self.imageURL
    }
    
    public func rowImagePlaceholder() -> UIImage? {
        return self.imagePlaceholder
    }
    
    public func tableViewCellClass() -> AnyClass? {
        return TableViewCell.self
    }
    
    public func rowTextColor() -> UIColor? {
        return self.textColor
    }
    
    ///---------------------------------------------------------------------------------------
    /// @name Row configuration
    ///---------------------------------------------------------------------------------------
    
    public func customise(cell: UITableViewCell) -> UITableViewCell {
        
        cell.textLabel?.textColor = self.textColor
        return cell
    }
    
    public func rowPadding() -> UIEdgeInsets? {
        return self.padding
    }
    
    public func rowBackgroundColor() -> UIColor? {
        return self.backgroundColor
    }
    
    public func rowSelectionHandler() -> TableSelectionHandler? {
        return self.selectionHandler
    }
    
    public func rowShouldDisplaySelectionIndicator() -> Bool? {
        return self.shouldDisplaySelectionIndicator
    }
    
    public func rowStyle() -> UITableViewCellStyle? {
        return self.style
    }
    
    public func estimatedCellHeight() -> CGFloat? {
        return 44.0
    }
}
