//
//  CopenCycleViewController.m
//  CopenCycle
//
//  Created by Alex Winston on 11/18/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "CopenCycleViewController.h"

@implementation CopenCycleViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	splashController = [[[CopenCycleSplashViewController alloc]
						 initWithNibName:@"CopenCycleSplashViewController" bundle:[NSBundle mainBundle]] retain];
	mainController = [[[CopenCycleMainViewController alloc]
					   initWithNibName:@"CopenCycleMainViewController" bundle:[NSBundle mainBundle]] retain];
	rideController = [[[CopenCycleRideViewController alloc]
					   initWithNibName:@"CopenCycleRideViewController" bundle:[NSBundle mainBundle]] retain];
	analyzeController = [[[CopenCycleAnalyzeViewController alloc]
					   initWithNibName:@"CopenCycleAnalyzeViewController" bundle:[NSBundle mainBundle]] retain];
	shareController = [[[CopenCycleShareViewController alloc]
					   initWithNibName:@"CopenCycleShareViewController" bundle:[NSBundle mainBundle]] retain];
	
	[self.view addSubview:splashController.view];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(homeWasClicked:) 
												 name:@"CCHomeWasClickedNotification"
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(rideWasClicked:) 
												 name:@"CCRideWasClickedNotification"
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(analyzeWasClicked:) 
												 name:@"CCAnalyzeWasClickedNotification"
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(shareWasClicked:) 
												 name:@"CCShareWasClickedNotification"
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(modeHasChanged:) 
												 name:@"CCModeHasChangedNotification"
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(gearUpWasClicked:) 
												 name:@"CCGearUpWasClickedNotification"
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(gearDownWasClicked:) 
												 name:@"CCGearDownWasClickedNotification"
											   object:nil];
	
	[NSTimer scheduledTimerWithTimeInterval:3.0
									 target:self
								   selector:@selector(splashTimer:)
								   userInfo:nil
									repeats:NO];
	//[splashTimer release];
	
    EAAccessoryManager *eaManager = [EAAccessoryManager sharedAccessoryManager];
	[eaManager registerForLocalNotifications];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(accessoryDidConnect:)
												 name:EAAccessoryDidConnectNotification
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(accessoryDidDisconnect:)
												 name:EAAccessoryDidDisconnectNotification
											   object:nil];
	//[self accessoryDidConnect:nil];
}

- (void)viewAnimationTransition:(UIView *)aView
{
	NSLog(@"viewAnimationTransition:");
	UIView *theView = [[self.view subviews] objectAtIndex:0];
	[UIView beginAnimations:nil context:NULL]; 
	[UIView setAnimationDuration:0.5]; 
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES]; 
	
	[self.view addSubview:aView]; 
	[theView removeFromSuperview];
	[UIView commitAnimations]; 
}

- (void)splashTimer:(NSTimer *)timer
{
	NSLog(@"splashTimer");
	[self viewAnimationTransition:mainController.view];
}

- (void)accessoryDidConnect:(NSNotification *)notification {
	EAAccessory *accessory = (EAAccessory *)[[notification userInfo] valueForKey:EAAccessoryKey];
	
	NSLog(@"accessoryDidConnect");	
	// TODO: If the EASession is not bound to an EAAccessory disconnect receives EXC_BAD_ACCESS 
	eaSession = [[[EASession alloc] initWithAccessory:accessory forProtocol:@"com.progical.idata"] retain];
	[[eaSession inputStream] setDelegate:self];
	[[eaSession inputStream] open];
	[[eaSession outputStream] open];
}

- (void)accessoryDidDisconnect:(NSNotification *)notification {
	NSLog(@"accessoryDidDisconnect");
	
	[[eaSession inputStream] close];
	[[eaSession outputStream] close];
	[eaSession release];
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
	
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
			unsigned char bytes[512];
			int bytesLength = [(NSInputStream *)stream read:bytes maxLength:512];
			if (bytesLength > 0) {				
				for (int i = 0; i < bytesLength; i++) {
					if (bytes[i] == 0xff)
						continue;
					
					receivingBuffer[0] = receivingBuffer[1];
					receivingBuffer[1] = receivingBuffer[2];
					receivingBuffer[2] = receivingBuffer[3];
					receivingBuffer[3] = receivingBuffer[4];
					receivingBuffer[4] = receivingBuffer[5];
					receivingBuffer[5] = receivingBuffer[6];
					receivingBuffer[6] = bytes[i];
					
					// Received distance traveled command
					if (receivingBuffer[0] == 'A' && receivingBuffer[1] == '1') {
						NSString *receivingBufferString = [NSString stringWithCString:(char *)receivingBuffer length:7];
						NSLog(@"%@", receivingBufferString);
						
						NSString *distanceTraveledString = [receivingBufferString substringFromIndex:2];
						distanceTraveledString = [distanceTraveledString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]];
						
						NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
						NSString *trimmed = [distanceTraveledString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
						BOOL isNumeric = trimmed.length > 0 && [trimmed rangeOfCharacterFromSet:nonNumberSet].location == NSNotFound;
						
						if (isNumeric) {
							NSNotification *theNotification =
							[NSNotification notificationWithName:@"CCDistanceTraveledHasChangedNotification" 
														  object:self 
														userInfo:[NSDictionary dictionaryWithObject:distanceTraveledString
																							 forKey:@"CCDistanceTraveled"]];
							[[NSNotificationCenter defaultCenter] postNotification:theNotification];
						}
					}
					
					// Received current speed command
					if (receivingBuffer[0] == 'A' && receivingBuffer[1] == '2') {
						NSString *receivingBufferString = [NSString stringWithCString:(char *)receivingBuffer length:7];
						NSLog(@"%@", receivingBufferString);
						
						NSString *currentSpeedString = [receivingBufferString substringFromIndex:2];
						currentSpeedString = [currentSpeedString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]];
						
						NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
						NSString *trimmed = [currentSpeedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
						BOOL isNumeric = trimmed.length > 0 && [trimmed rangeOfCharacterFromSet:nonNumberSet].location == NSNotFound;
						
						if (isNumeric) {
							NSNotification *theNotification =
							[NSNotification notificationWithName:@"CCCurrentSpeedHasChangedNotification" 
														  object:self 
														userInfo:[NSDictionary dictionaryWithObject:currentSpeedString
																							 forKey:@"CCCurrentSpeed"]];
							[[NSNotificationCenter defaultCenter] postNotification:theNotification];
						}
					}
					
					// Received battery level command
					if (receivingBuffer[0] == 'A' && receivingBuffer[1] == '4') {
						NSString *receivingBufferString = [NSString stringWithCString:(char *)receivingBuffer length:7];
						NSLog(@"%@", receivingBufferString);
						
						NSString *batteryLevelString = [receivingBufferString substringFromIndex:2];
						batteryLevelString = [batteryLevelString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]];
						
						NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
						NSString *trimmed = [batteryLevelString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
						BOOL isNumeric = trimmed.length > 0 && [trimmed rangeOfCharacterFromSet:nonNumberSet].location == NSNotFound;
						
						if (isNumeric) {
							/*CGRect frame = batteryLevel.frame;
							frame.size.height = 180 * ([batteryLevelString floatValue]/100.0);
							batteryLevel.frame = frame;*/
						}
					}
				}
			}
		}
	}
}

- (void)homeWasClicked:(NSNotification *)aNotification
{
	NSLog(@"homeWasClicked:");
	[self viewAnimationTransition:mainController.view];
}

- (void)rideWasClicked:(NSNotification *)aNotification
{
	NSLog(@"rideWasClicked:");
	[self viewAnimationTransition:rideController.view];
}

- (void)analyzeWasClicked:(NSNotification *)aNotification
{
	NSLog(@"analyzeWasClicked:");
	[self viewAnimationTransition:analyzeController.view];
}

- (void)shareWasClicked:(NSNotification *)aNotification
{
	NSLog(@"shareWasClicked:");
	[self viewAnimationTransition:shareController.view];
}

- (void)modeHasChanged:(NSNotification *)notification
{
	NSLog(@"modeHasChanged:");
	NSDictionary *userInfo = [notification userInfo];
	NSLog(@"%@", [userInfo objectForKey:@"CCModeHasChangedNotification"]);
	
	NSString *currentModeString = [userInfo objectForKey:@"CCCurrentMode"];
	
	unsigned char gearDownCommand[] = { 0x02, 0x06, 0x06, [currentModeString characterAtIndex:0], [currentModeString characterAtIndex:1], 0x00 };
	[[eaSession outputStream] write:gearDownCommand maxLength:6];
}

- (void)gearUpWasClicked:(id)sender
{
	NSLog(@"gearUpWasClicked:");
	unsigned char gearDownCommand[] = { 0x02, 0x06, 0x06, 'S', '1', 0x00 };
	[[eaSession outputStream] write:gearDownCommand maxLength:6];
}

- (void)gearDownWasClicked:(id)sender
{
	NSLog(@"gearDownWasClicked:");
	unsigned char gearUpCommand[] = { 0x02, 0x06, 0x06, 'S', '2', 0x00 };
	[[eaSession outputStream] write:gearUpCommand maxLength:8];
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
