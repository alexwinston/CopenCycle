//
//  CopenCycleMainViewController.m
//  CopenCycle
//
//  Created by Alex Winston on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CopenCycleMainViewController.h"


@implementation CopenCycleMainViewController
@synthesize rideButton;
@synthesize analyzeButton;
@synthesize shareButton;

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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
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

- (void)rideWasClicked:(id)sender
{
	[self postNotificationWithName:@"CCRideWasClickedNotification"];
}

- (void)analyzeWasClicked:(id)sender
{
	[self postNotificationWithName:@"CCAnalyzeWasClickedNotification"];
}

- (void)shareWasClicked:(id)sender
{
	[self postNotificationWithName:@"CCShareWasClickedNotification"];
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
