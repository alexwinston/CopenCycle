//
//  CopenCycleShareViewController.m
//  CopenCycle
//
//  Created by Alex Winston on 12/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CopenCycleShareViewController.h"


@implementation CopenCycleShareViewController
@synthesize rideButton;
@synthesize analyzeButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)postNotificationWithName:(NSString *)name
{
	NSNotification *theNotification =
	[NSNotification notificationWithName:name 
								  object:self 
								userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotification:theNotification];
}

- (void)homeWasClicked:(id)sender
{
	[self postNotificationWithName:@"CCHomeWasClickedNotification"];
}

- (void)rideWasClicked:(id)sender
{
	[self postNotificationWithName:@"CCRideWasClickedNotification"];
}

- (void)analyzeWasClicked:(id)sender
{
	[self postNotificationWithName:@"CCAnalyzeWasClickedNotification"];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
