//
//  CopenCycleRideViewController.m
//  CopenCycle
//
//  Created by Alex Winston on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CopenCycleRideViewController.h"


@implementation CopenCycleRideViewController
@synthesize loopCaloriesImage;
@synthesize loopFriendImage;
@synthesize loopPollutionImage;
@synthesize loopWeatherImage;
@synthesize currentModeImage;
@synthesize currentGearImage;
@synthesize currentSpeedLabel;
@synthesize currentMilesLabel;
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(currentSpeedHasChanged:) 
												 name:@"CCCurrentSpeedHasChangedNotification"
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(distanceTraveledHasChanged:) 
												 name:@"CCDistanceTraveledHasChangedNotification"
											   object:nil];
	
    [NSTimer scheduledTimerWithTimeInterval:5.0
									 target:self
								   selector:@selector(loopImages:)
								   userInfo:nil
									repeats:YES];

	currentGear = kCurrentGearMin;
}

- (void)loopImages:(NSTimer *)timer
{
	NSLog(@"loopImages:");
	CATransition *transition = [CATransition animation];
	transition.duration = 1.0;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	
	if (loopCounter == 0) {
		[loopFriendImage.layer addAnimation:transition forKey:nil];
		loopCaloriesImage.hidden = YES;
		loopFriendImage.hidden = NO;
	} else if (loopCounter == 1) {
		[loopPollutionImage.layer addAnimation:transition forKey:nil];
		loopFriendImage.hidden = YES;
		loopPollutionImage.hidden = NO;
	} else if (loopCounter == 2) {
		[loopWeatherImage.layer addAnimation:transition forKey:nil];
		loopPollutionImage.hidden = YES;
		loopWeatherImage.hidden = NO;
	} else if (loopCounter == 3) {
		[loopCaloriesImage.layer addAnimation:transition forKey:nil];
		loopWeatherImage.hidden = YES;
		loopCaloriesImage.hidden = NO;
	}
	
	loopCounter++; if (loopCounter >= 4) loopCounter = 0;
}

- (void)currentSpeedHasChanged:(NSNotification *)notification
{
	NSDictionary *userInfo = [notification userInfo];
	NSLog(@"%@", [userInfo objectForKey:@"CCCurrentSpeed"]);
	
	currentSpeedLabel.text = [userInfo objectForKey:@"CCCurrentSpeed"];
}

- (void)distanceTraveledHasChanged:(NSNotification *)notification
{
	NSDictionary *userInfo = [notification userInfo];
	NSLog(@"%@", [userInfo objectForKey:@"CCDistanceTraveled"]);
	
	currentMilesLabel.text = [userInfo objectForKey:@"CCDistanceTraveled"];
}

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

- (void)analyzeWasClicked:(id)sender
{
	[self postNotificationWithName:@"CCAnalyzeWasClickedNotification"];
}

- (void)shareWasClicked:(id)sender
{
	[self postNotificationWithName:@"CCShareWasClickedNotification"];
}

- (void)updateCurrentModeImage
{
	NSString *currentModeString;
	if (currentMode == 3) {
		currentModeString = @"m7";
		currentModeImage.image = [UIImage imageNamed:@"rideMotorAssist3.png"];
	} else if (currentMode == 2) {
		currentModeString = @"m6";
		currentModeImage.image = [UIImage imageNamed:@"rideMotorAssist2.png"];
	} else if (currentMode == 1) {
		currentModeString = @"m5";
		currentModeImage.image = [UIImage imageNamed:@"rideMotorAssist1.png"];
	} else if (currentMode == 0) {
		currentModeString = @"m4";
		currentModeImage.image = [UIImage imageNamed:@"rideMotorOff.png"];
	} else if (currentMode == -1) {
		currentModeString = @"m1";
		currentModeImage.image = [UIImage imageNamed:@"rideMotorExercise1.png"];
	} else if (currentMode == -2) {
		currentModeString = @"m2";
		currentModeImage.image = [UIImage imageNamed:@"rideMotorExercise2.png"];
	} else if (currentMode == -3) {
		currentModeString = @"m3";
		currentModeImage.image = [UIImage imageNamed:@"rideMotorExercise3.png"];
	}
	
	NSNotification *theNotification =
	[NSNotification notificationWithName:@"CCModeHasChangedNotification" 
								  object:self 
								userInfo:[NSDictionary dictionaryWithObject:currentModeString
																	 forKey:@"CCCurrentMode"]];
	[[NSNotificationCenter defaultCenter] postNotification:theNotification];
}

- (void)modeUpWasClicked:(id)sender
{
	NSLog(@"modeUpButtonClick:");
	if (currentMode < kCurrentModeMax) {
		currentMode++;

		[self updateCurrentModeImage];
		[self postNotificationWithName:@"CCModeUpWasClickedNotification"];
	}
}

- (void)modeDownWasClicked:(id)sender
{
	NSLog(@"modeDownButtonClick:");
	if (currentMode > kCurrentModeMin) {
		currentMode--;
		
		[self updateCurrentModeImage];
		[self postNotificationWithName:@"CCModeDownWasClickedNotification"];
	}
}

- (void)updateCurrentGearImage
{
	if (currentGear == 1)
		currentGearImage.image = [UIImage imageNamed:@"rideGear1.png"];
	else if (currentGear == 2)
		currentGearImage.image = [UIImage imageNamed:@"rideGear2.png"];
	else if (currentGear == 3)
		currentGearImage.image = [UIImage imageNamed:@"rideGear3.png"];
}

- (void)gearUpWasClicked:(id)sender
{
	NSLog(@"gearUpButtonClick:");
	if (currentGear < kCurrentGearMax) {
		currentGear++;
		
		[self updateCurrentGearImage];
		[self postNotificationWithName:@"CCGearUpWasClickedNotification"];
	}
}

- (void)gearDownWasClicked:(id)sender
{
	NSLog(@"gearDownButtonClick:");
	if (currentGear > kCurrentGearMin) {
		currentGear--;
		
		[self updateCurrentGearImage];
		[self postNotificationWithName:@"CCGearDownWasClickedNotification"];
	}
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
