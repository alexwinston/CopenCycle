//
//  CopenCycleRideViewController.h
//  CopenCycle
//
//  Created by Alex Winston on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCurrentModeMin -3
#define kCurrentModeMax 3
#define kCurrentGearMin 1
#define kCurrentGearMax 3

@interface CopenCycleRideViewController : UIViewController {
	int currentMode;
	int currentGear;
	
	int loopCounter;
	
	IBOutlet UIImageView *loopCaloriesImage;
	IBOutlet UIImageView *loopFriendImage;
	IBOutlet UIImageView *loopPollutionImage;
	IBOutlet UIImageView *loopWeatherImage;
	IBOutlet UIImageView *currentModeImage;
	IBOutlet UIImageView *currentGearImage;
	IBOutlet UILabel *currentSpeedLabel;
	IBOutlet UILabel *currentMilesLabel;
	IBOutlet UIButton *analyzeButton;
	IBOutlet UIButton *shareButton;
}
@property (readwrite, retain) IBOutlet UIImageView *loopCaloriesImage;
@property (readwrite, retain) IBOutlet UIImageView *loopFriendImage;
@property (readwrite, retain) IBOutlet UIImageView *loopPollutionImage;
@property (readwrite, retain) IBOutlet UIImageView *loopWeatherImage;
@property (readwrite, retain) IBOutlet UIImageView *currentModeImage;
@property (readwrite, retain) IBOutlet UIImageView *currentGearImage;
@property (readwrite, retain) IBOutlet UILabel *currentSpeedLabel;
@property (readwrite, retain) IBOutlet UILabel *currentMilesLabel;
@property (readwrite, retain) IBOutlet UIButton *analyzeButton;
@property (readwrite, retain) IBOutlet UIButton *shareButton;
- (void)modeUpWasClicked:(id)sender;
- (void)modeDownWasClicked:(id)sender;
- (void)gearUpWasClicked:(id)sender;
- (void)gearDownWasClicked:(id)sender;
- (void)homeWasClicked:(id)sender;
- (void)analyzeWasClicked:(id)sender;
- (void)shareWasClicked:(id)sender;
@end
