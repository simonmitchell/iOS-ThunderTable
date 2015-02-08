//
//  UITableViewCellGenerator.h
//  ThunderTable
//
//  Created by Simon Mitchell on 08/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

@import UIKit;

@interface UITableViewCellGenerator : NSObject

+ (id)cellWithClassString:(NSString *)string style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+ (id)cellWithClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
