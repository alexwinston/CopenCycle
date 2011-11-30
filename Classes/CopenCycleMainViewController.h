//
//  CopenCycleMainViewController.h
//  CopenCycle
//
//  Created by Alex Winston on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CopenCycleMainViewController : UIViewController {
	IBOutlet UIButton *rideButton;
	IBOutlet UIButton *analyzeButton;
	IBOutlet UIButton *shareButton;
}
@property (readwrite, retain) IBOutlet UIButton *rideButton;
@property (readwrite, retain) IBOutlet UIButton *analyzeButton;
@property (readwrite, retain) IBOutlet UIButton *shareButton;
- (void)rideWasClicked:(id)sender;
- (void)analyzeWasClicked:(id)sender;
- (void)shareWasClicked:(id)sender;
@end
