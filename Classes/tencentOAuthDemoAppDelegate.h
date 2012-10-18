//
//  tencentOAuthDemoAppDelegate.h
//  tencentOAuthDemo
//
//  Created by wanglin on 11-11-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class tencentOAuthDemoViewController;

@interface tencentOAuthDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    tencentOAuthDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet tencentOAuthDemoViewController *viewController;

@end

