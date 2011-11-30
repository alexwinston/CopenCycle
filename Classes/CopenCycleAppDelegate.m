//
//  CopenCycleAppDelegate.m
//  CopenCycle
//
//  Created by Alex Winston on 11/18/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "CopenCycleAppDelegate.h"
#import "CopenCycleViewController.h"

@implementation CopenCycleAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
