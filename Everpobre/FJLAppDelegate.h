//
//  AppDelegate.h
//  Everpobre
//
//  Created by Fran Lucena on 18/02/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@class FJLSimpleCoreDataStack;

@interface FJLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FJLSimpleCoreDataStack *model;


@end

