//
//  TableInputViewCell.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

public protocol TableInputViewCellDelegate: class {
    func tableInputViewCellDidFinish(cell tableViewCell: TableViewCell)
}

public class TableInputViewCell: TableViewCell {

    weak public var inputRow: TableInputRowDataSource?
    weak public var delegate: TableInputViewCellDelegate?
}
