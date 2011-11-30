//
//  CopenCycleAnalyzeViewController.h
//  CopenCycle
//
//  Created by Alex Winston on 11/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface CopenCycleAnalyzeViewController : UIViewController <CLLocationManagerDelegate, UIActionSheetDelegate> {
	IBOutlet UIButton *backButton;
	IBOutlet UIButton *infoButton;
	IBOutlet MKMapView *mapView;
	IBOutlet UIImageView *analyzeTitleImage;
	IBOutlet UIImageView *analyzeDetailImage;
	IBOutlet UIButton *milesButton;
	IBOutlet UIButton *healthButton;
	IBOutlet UIButton *environmentButton;
	IBOutlet UIButton *communityButton;
	IBOutlet UIButton *shareThisButton;
	IBOutlet UIButton *rideButton;
	IBOutlet UIButton *shareButton;
}
@property (readwrite, retain) IBOutlet UIButton *backButton;
@property (readwrite, retain) IBOutlet UIButton *infoButton;
@property (readwrite, retain) IBOutlet MKMapView *mapView;
@property (readwrite, retain) IBOutlet UIImageView *analyzeTitleImage;
@property (readwrite, retain) IBOutlet UIImageView *analyzeDetailImage;
@property (readwrite, retain) IBOutlet UIButton *milesButton;
@property (readwrite, retain) IBOutlet UIButton *healthButton;
@property (readwrite, retain) IBOutlet UIButton *environmentButton;
@property (readwrite, retain) IBOutlet UIButton *communityButton;
@property (readwrite, retain) IBOutlet UIButton *shareThisButton;
@property (readwrite, retain) IBOutlet UIButton *rideButton;
@property (readwrite, retain) IBOutlet UIButton *shareButton;
- (void)backWasClicked:(id)sender;
- (void)infoWasClicked:(id)sender;
- (void)milesWasClicked:(id)sender;
- (void)healthWasClicked:(id)sender;
- (void)environmentWasClicked:(id)sender;
- (void)communityWasClicked:(id)sender;
- (void)homeWasClicked:(id)sender;
- (void)shareThisWasClicked:(id)sender;
- (void)rideWasClicked:(id)sender;
- (void)shareWasClicked:(id)sender;
@end
