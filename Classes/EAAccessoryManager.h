//
//  EAAccessoryManager.h
//  ExternalAccessory
//
//  Copyright 2008 Apple, Inc. All rights reserved.
//


// EAAccessoryManager Notifications
extern NSString *const EAAccessoryDidConnectNotification;
extern NSString *const EAAccessoryDidDisconnectNotification;
// Keys in the EAAccessoryDidArriveNotification/EAAccessoryDidDisconnectNotification userInfo
extern NSString *const EAAccessoryKey; // EAAccessory

@interface EAAccessoryManager : NSObject {
@private
    NSMutableArray *_connectedAccessories;
}

+ (EAAccessoryManager*)sharedAccessoryManager;
- (void)registerForLocalNotifications;
- (void)unregisterForLocalNotifications;

@property (nonatomic, readonly) NSArray *connectedAccessories;
@end
