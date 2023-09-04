//
//  WBEngageManagerDelegate.h
//  WalkbaseEngageSDK
//
//  Copyright (c) 2019 Walkbase. All rights reserved.
//

@class WBEngageManager;

FOUNDATION_EXPORT NSString * const WBErrorDomain;

/** The state of the Engage engine
 */
typedef NS_ENUM(NSUInteger, WBEngageManagerState) {
    /** State is not determined */
    WBEngageManagerStateNotDetermined,
    /** The Engage engine is currently initializing */
    WBEngageManagerStateInitializing,
    /** The Engage engine is currently active and scanning for iBeacons */
    WBEngageManagerStateScanning,
    /** The Engage engine is currently paused */
    WBEngageManagerStatePaused,
    /** The Engage engine is currently in error state */
    WBEngageManagerStateFailed
};

/** Error codes returned by the WBEngageManager
 */
typedef NS_ENUM(NSInteger, WBError) {
    /** Unused error state */
    WBErrorInvalid = 0,
    /** The user has not authorized this application to use Location Services */
    WBErrorLocationServicesUnauthorized,
    /** The user has disabled Location Services */
    WBErrorLocationServicesDisabled,
    /** The user has turned Bluetooth off */
    WBErrorBluetoothOff,
    /** The device doesn't have Bluetooth LE implemented */
    WBErrorBluetoothUnsupported,
    /** The user has not authorized this application to use Bluetooth LE */
    WBErrorBluetoothUnauthorized,
    /** The user has disabled background refresh for this application */
    WBErrorBackgroundRefreshDenied,
    /** Background updates are unavailable and the user cannot enable them again. For example, this status can occur when parental controls are in effect for the current user. */
    WBErrorBackgroundRefreshRestricted,
    /** The API key that the user provided is invalid */
    WBErrorInvalidAPIKey,
    /** An unknown error, the actual error is embedded */
    WBErrorUnknown,
    /** Running in Simulator, features not available */
    WBErrorSimulator,
    /** API request timed out */
    WBErrorAPIRequestTimedOut,
    /** There are no regions configured in Engage admin */
    WBErrorNoRegionsConfigured,
    /** Cannot connect to the Engage server at the moment */
    WBErrorCannotConnectToServer
};

/** The `WBEngageManagerDelegate` will notify the controller about anything that happens inside `WBEngageManager`.
 */

@protocol WBEngageManagerDelegate <NSObject>

@optional

/** This method gets called if an error occurs in `WBEngageManager`.
 
 @param engageEngine The current instance of the Engage engine in use.
 @param error The error.
 */
- (void)engageEngine:(id)engageEngine didFailWithError:(NSError *)error;

/** `didDetermineState:` gets called every time the state of the Engange engine changes.
 
 This method can be used to track when the beacons are actually scanned.
 */
- (void)engageEngine:(id)engageEngine didDetermineState:(WBEngageManagerState)state;

@end
