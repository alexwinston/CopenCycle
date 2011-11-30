//
//  CopenCycleViewController.h
//  CopenCycle
//
//  Created by Alex Winston on 11/18/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CopenCycleSplashViewController.h"
#import "CopenCycleMainViewController.h"
#import "CopenCycleRideViewController.h"
#import "CopenCycleAnalyzeViewController.h"
#import "CopenCycleShareViewController.h"
#import "ExternalAccessory.h"


@interface CopenCycleViewController : UIViewController {
	EASession *eaSession;
	
	unsigned char receivingBuffer[7];
	
	CopenCycleSplashViewController *splashController;
	CopenCycleMainViewController *mainController;
	CopenCycleRideViewController *rideController;
	CopenCycleAnalyzeViewController *analyzeController;
	CopenCycleShareViewController *shareController;
}
@end

