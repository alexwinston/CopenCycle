//
//  CopenCycleShareViewController.h
//  CopenCycle
//
//  Created by Alex Winston on 12/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CopenCycleShareViewController : UIViewController {
	IBOutlet UIButton *rideButton;
	IBOutlet UIButton *analyzeButton;
}
@property (readwrite, retain) IBOutlet UIButton *rideButton;
@property (readwrite, retain) IBOutlet UIButton *analyzeButton;
- (void)homeWasClicked:(id)sender;
- (void)rideWasClicked:(id)sender;
- (void)analyzeWasClicked:(id)sender;
@end
