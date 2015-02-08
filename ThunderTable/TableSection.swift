//
//  TableSection.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import Foundation

public class TableSection: TableSectionDataSource {
    
    var items: [TableRowDataSource]
    var title: String?
    var footer: String?
    var selectionHandler: TableSelectionHandler?
    
    public init (title: String?, footer foot: String?, items sectionItems:[TableRowDataSource], selectionHandler handler: TableSelectionHandler?) {
        
        self.title = title
        self.footer = foot
        self.items = sectionItems
        self.selectionHandler = handler
    }
    
    // MARK: - Table section datasource
    
    public func sectionItems() -> [TableRowDataSource] {
        return self.items
    }
    
    /**
    @abstract The header title of the section
    */
    public func sectionHeader() -> String? {
        return self.title
    }
    
    /**
    @abstract The footer title of the section
    */
    public func sectionFooter() -> String? {
        return self.footer
    }
    
    /**
    @abstract The closure to be called when the user selects a row in the section
    */
    public func sectionSelectionHandler() -> TableSelectionHandler? {
        return self.selectionHandler
    }
}
