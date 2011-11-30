//
//  CopenCycleAnalyzeViewController.m
//  CopenCycle
//
//  Created by Alex Winston on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CopenCycleAnalyzeViewController.h"


@implementation CopenCycleAnalyzeViewController
@synthesize backButton;
@synthesize infoButton;
@synthesize mapView;
@synthesize analyzeTitleImage;
@synthesize analyzeDetailImage;
@synthesize milesButton;
@synthesize healthButton;
@synthesize environmentButton;
@synthesize communityButton;
@synthesize shareThisButton;
@synthesize rideButton;
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	CLLocationManager *locationManager=[[CLLocationManager alloc] init];
	locationManager.delegate=self;
	locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
	
	[locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	MKCoordinateRegion region;
	region.center.latitude = newLocation.coordinate.latitude;
	region.center.longitude = newLocation.coordinate.longitude;
	region.span.latitudeDelta = 0.005;
	region.span.longitudeDelta = 0.005;
	
	[mapView setRegion:region animated:TRUE];
}

- (void)postNotificationWithName:(NSString *)name
{
	NSNotification *theNotification =
	[NSNotification notificationWithName:name 
								  object:self 
								userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotification:theNotification];
}

- (void)enableAnalyzeButtons
{
	milesButton.enabled = YES;
	healthButton.enabled = YES;
	environmentButton.enabled = YES;
	communityButton.enabled = YES;
	infoButton.enabled = NO;
}

- (void)disableAnalyzeButtons
{
	milesButton.enabled = NO;
	healthButton.enabled = NO;
	environmentButton.enabled = NO;
	communityButton.enabled = NO;
	infoButton.enabled = YES;
}

- (void)backWasClicked:(id)sender
{
	NSLog(@"backWasClicked:");
	analyzeTitleImage.image = [UIImage imageNamed:@"titleAnalyze.png"];
	analyzeDetailImage.hidden = YES;
	shareThisButton.hidden = YES;
	[self enableAnalyzeButtons];
}

- (void)infoWasClicked:(id)sender
{
	NSLog(@"infoWasClicked:");
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Analyze"
													message:@"Analyze your data to keep track of your personal fitness, to find out which routes are the least congested or polluted or to meet up with friends on the go!"
												   delegate:nil
										  cancelButtonTitle:@"Okay"
										  otherButtonTitles:nil];
	[alert show];
	[alert autorelease];
}

- (void)milesWasClicked:(id)sender
{
	NSLog(@"milesWasClicked:");
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Collecting Green Miles"
													message:@"As you ride, you automatically collect Green Miles – it’s similar to a frequent flyer program, but good for the environment! Trade your miles for things or use them to help your city reach its Green Mile targets."
												   delegate:nil
										  cancelButtonTitle:@"Okay"
										  otherButtonTitles:nil];
	[alert show];
	[alert autorelease];
}

- (void)healthWasClicked:(id)sender
{
	NSLog(@"healthWasClicked:");
	analyzeTitleImage.image = [UIImage imageNamed:@"titleAnalyzeHealth.png"];
	analyzeDetailImage.image = [UIImage imageNamed:@"analyzeHealthDetail.png"];
	analyzeDetailImage.hidden = NO;
	shareThisButton.hidden = NO;
	[self disableAnalyzeButtons];
}

- (void)environmentWasClicked:(id)sender
{
	NSLog(@"environmentWasClicked:");
	analyzeTitleImage.image = [UIImage imageNamed:@"titleAnalyzeEnvironment.png"];
	analyzeDetailImage.image = [UIImage imageNamed:@"analyzeEnvironmentDetail.png"];
	analyzeDetailImage.hidden = NO;
	shareThisButton.hidden = NO;
	[self disableAnalyzeButtons];
}

- (void)communityWasClicked:(id)sender
{
	NSLog(@"communityWasClicked:");
	analyzeTitleImage.image = [UIImage imageNamed:@"titleAnalyzeCommunity.png"];
	analyzeDetailImage.image = [UIImage imageNamed:@"analyzeCommunityDetail.png"];
	analyzeDetailImage.hidden = NO;
	shareThisButton.hidden = NO;
	[self disableAnalyzeButtons];
}

- (void)shareThisWasClicked:(id)sender
{
	NSLog(@"shareThisWasClicked:");
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
															 delegate:self
													cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:nil
													otherButtonTitles:@"Share with Your Friends", @"Share with the City", @"About Data Sharing", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
														message:@"Your data has been shared with your friends."
													   delegate:nil
											  cancelButtonTitle:@"Okay"
											  otherButtonTitles:nil];
		[alert show];
		[alert autorelease];
	} else if (buttonIndex == 1) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
															message:@"Your data has been shared with the city."
														   delegate:nil
												  cancelButtonTitle:@"Okay"
												  otherButtonTitles:nil];
			[alert show];
			[alert autorelease];
	} else if (buttonIndex == 2) {
		[self postNotificationWithName:@"CCShareWasClickedNotification"];
	} else {
		//NSLog(@"Cancel");
	}
}

- (void)homeWasClicked:(id)sender
{
	[self postNotificationWithName:@"CCHomeWasClickedNotification"];
}

- (void)rideWasClicked:(id)sender
{
	NSLog(@"rideWasClicked:");
	[self postNotificationWithName:@"CCRideWasClickedNotification"];
}

- (void)shareWasClicked:(id)sender
{
	NSLog(@"shareWasClicked:");
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
