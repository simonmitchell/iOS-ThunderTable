//
//  UITableViewCellGenerator.m
//  ThunderTable
//
//  Created by Simon Mitchell on 08/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

#import "UITableViewCellGenerator.h"

@implementation UITableViewCellGenerator

+ (id)cellWithClassString:(NSString *)string style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    return [UITableViewCellGenerator cellWithClass:NSClassFromString(string) style:style reuseIdentifier:reuseIdentifier];
}

+ (id)cellWithClass:(Class)cellClass style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[cellClass alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
}

@end
