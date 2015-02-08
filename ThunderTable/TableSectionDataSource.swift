//
//  TableSectionDataSource.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation

/**
All sections that can be added in a `TableViewController` must conform to the `TableSectionDataSource` protocol. This protocol is for defining what is added to a table section and the table sections common properties
*/
public protocol TableSectionDataSource {
    
    ///---------------------------------------------------------------------------------------
    /// @name General setup
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract The items displayed in the section. Items must conform to `TSCTableRowDataSource`.
    */
    func sectionItems() -> [TableRowDataSource]
    
    /**
    @abstract The header title of the section
    */
    func sectionHeader() -> String?
    
    /**
    @abstract The footer title of the section
    */
    func sectionFooter() -> String?
    
    /**
    @abstract The closure to be called when the user selects a row in the section
    */
    func sectionSelectionHandler() -> TableSelectionHandler?
}
