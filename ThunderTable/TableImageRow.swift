//
//  TableImageRow.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public class TableImageRow: TableRow {
    
    public var contentMode: UIViewContentMode?
   
    public convenience init(image: UIImage?) {
        
        self.init(image: image, contentMode: nil)
    }
    
    public convenience init(image: UIImage?, backgroundColor: UIColor?) {
        
        self.init(image: image, contentMode:nil)
        self.backgroundColor = backgroundColor
    }
    
    public convenience init(imageURL: NSURL, placeholderImage: UIImage) {
        
        self.init(image: nil, contentMode: nil)
        self.imageURL = imageURL
        self.imagePlaceholder = placeholderImage
    }
    
    public init(image: UIImage?, contentMode: UIViewContentMode?) {
        
        self.contentMode = contentMode
        super.init(title: nil, subtitle: nil, image: image, selectionHandler: nil)
    }
    
    public override func tableViewCellClass() -> AnyClass? {
        return TableImageViewCell.self
    }
    
    
    public override func customise(cell: UITableViewCell) -> UITableViewCell {
        
        cell.imageView?.backgroundColor = self.backgroundColor
        
        if let contentMode = self.contentMode {
            cell.imageView?.contentMode = contentMode
        }
        
        return cell
    }
}
