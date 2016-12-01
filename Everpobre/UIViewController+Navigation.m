//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by Fran Lucena on 08/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(UINavigationController *) wrappedInNavigation{
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: self];
    
    return nav;
}


@end
