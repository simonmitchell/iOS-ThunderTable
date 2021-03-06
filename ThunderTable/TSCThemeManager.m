//
//  TSCThemeManager.m
//  American Red Cross Disaster
//
//  Created by Phillip Caudell on 16/08/2013.
//  Copyright (c) 2013 madebyphill.co.uk. All rights reserved.
//

#import "TSCThemeManager.h"
#import "TSCDefaultTheme.h"
#import "TSCCheckView.h"

@implementation TSCThemeManager

static id <TSCTheme> sharedController = nil;

+ (id <TSCTheme>)sharedTheme
{
    @synchronized(self) {
        
        if (!sharedController) {
            sharedController = [[TSCDefaultTheme alloc] init];
        }
    }
    
    return sharedController;
}

+ (void)setSharedTheme:(id <TSCTheme>)theme
{
    @synchronized(self) {
        sharedController = theme;
    }
}

+ (void)customizeAppAppearance
{
    id <TSCTheme> theme = [self sharedTheme];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    [navigationBar setTintColor:[theme mainColor]];
    
    UIToolbar *toolbar = [UIToolbar appearance];
    [toolbar setTintColor:[theme mainColor]];
    
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setSelectedImageTintColor:[theme mainColor]];
    [tabBar setTintColor:[theme mainColor]];
    
    
    UISwitch *switchView = [UISwitch appearance];
    [switchView setOnTintColor:[theme mainColor]];
    
    TSCCheckView *checkView = [TSCCheckView appearance];
    [checkView setOnTintColor:[theme mainColor]];
}

+ (BOOL)isOS7
{
    
    switch ([[[UIDevice currentDevice] systemVersion] compare:@"7.0.0" options:NSNumericSearch]) {
        case NSOrderedSame:
            return true;
            break;
        case NSOrderedDescending:
            return true;
        default:
            return false;
            break;
    }
}

+ (BOOL)isOS8
{
    switch ([[[UIDevice currentDevice] systemVersion] compare:@"8.0.0" options:NSNumericSearch]) {
        case NSOrderedSame:
            return true;
            break;
        case NSOrderedDescending:
            return true;
        default:
            return false;
            break;
    }
}

+ (NSTextAlignment)localisedTextDirectionForBaseDirection:(NSTextAlignment)textDirection
{
    return textDirection;
}

+ (BOOL)isRightToLeft
{
    return NO;
}

BOOL isPad() {
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        return YES;
    }
    
    return NO;
}

@end