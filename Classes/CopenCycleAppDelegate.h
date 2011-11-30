//
//  CopenCycleAppDelegate.h
//  CopenCycle
//
//  Created by Alex Winston on 11/18/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CopenCycleViewController;

@interface CopenCycleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CopenCycleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CopenCycleViewController *viewController;

@end

