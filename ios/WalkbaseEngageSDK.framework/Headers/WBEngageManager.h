//
//  WBEngageManager.h
//  WalkbaseEngageSDK
//
//  Copyright (c) 2019 Walkbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBEngageManagerDelegate.h"

/** This document explains the how to integrate **Walkbase Engage SDK** into your application. Also, the documentation of `WalkbaseEngage` class, which contains the main functionality for Walkbase Engage SDK.
 
 ## Walkbase Engage SDK
 
 See the repository `README.md` for details.
 
 */

@interface WBEngageManager : NSObject

/**---------------------------------------------------------------------------------------
 * @name Properties
 *  ---------------------------------------------------------------------------------------
 */

/** Returns the current API key.
 */
@property (nonatomic, readonly, copy) NSString *apiKey;

/** Returns the current user identifier.
 */
@property (nonatomic, readonly, strong) NSString *userIdentifier;

/** The base URL that the API is currently using. Default is `https://sdk.walkbase.com/api/v2´.
 */
@property (nonatomic, strong) NSURL *apiBaseURL;

/** The application name returned from the server.
 */
@property (nonatomic, readonly, copy) NSString *applicationName;

/** Returns a version of this SDK.
 */
@property (nonatomic, readonly, copy) NSString *version;

/** Sets debugging flag, for debugging purposes.
 */
@property (nonatomic, assign) BOOL debugMode;

/** Sets network data compression, default is off (NO).
 */
@property (nonatomic, assign) BOOL compressData;

/** Data about the detected beacons is sent to this delegate. See the definition of `WBEngageManagerDelegate` for details.
 */
@property (nonatomic, weak) id <WBEngageManagerDelegate> delegate;

/** The current state of the Walkbase SDK.
 */
@property (nonatomic, readonly, assign) WBEngageManagerState state;

/** A list of detected iBeacons by iBeacon identifier (an `NSString` with UUID, major and minor separated by "-").
 */
@property (nonatomic, readonly, strong) NSMutableDictionary *detectedBeacons;

/** A list of `CLBeaconRegion` objects that the server returns
 */
@property (nonatomic, readonly, strong) NSArray *beaconRegions;

/** A set of monitored `CLRegion` objects which can be either `CLBeaconRegion` or `CLCircularRegion`
 */
@property (nonatomic, readonly, strong) NSSet<__kindof CLRegion *> *monitoredRegions;

/** A set of ranged `CLRegion` objects which can be either `CLBeaconRegion` or `CLCircularRegion`
 */
@property (nonatomic, readonly, strong) NSSet<__kindof CLRegion *> *rangedRegions;

/**---------------------------------------------------------------------------------------
 * @name Instance methods
 *  ---------------------------------------------------------------------------------------
 */

/** Returns a singleton instance of the `WBEngageManager` class.
 
 @return An instance of `WBEngageManager`
 */

+ (instancetype)sharedInstance;

/** Starts the beacon tracking with the specified `apiKey`.
 
 If beacon monitoring fails, the `WBEngageManagerDelegate` will be called.
 
 @param apiKey The API key
 @return An instance of `WBEngageManager`
 */
+ (WBEngageManager *)startWithAPIKey:(NSString *)apiKey;

/** Sets a custom identifier that uniquely identifies the user. The identifier can be
 any non-nil string. Default is `nil`.
 
 @param userIdentifier The custom user identifier
 */
+ (void)setUserIdentifier:(NSString *)userIdentifier;

/** Pauses the beacon tracking temporarily. */
+ (void)pause;

/** Forces the location manager to start location updates. */
+ (void)startUpdatingLocation;

/** Forces the location manager to stop location updates. */
+ (void)stopUpdatingLocation;

/** Forces the manager to start scanning all known beacon regions. This is useful if you want to be sure positioning is enabled without relying on a `didEnterRegion` event. */
+ (void)startRangingAllRegions;

/** Resumes the beacon tracking.
 
 @return Returns NO if the WBEngageManager hasn't been previously successfully started.
 */
+ (BOOL)resume;

/** Sets debugging flag, for debugging purposes. */
+ (void)setDebugMode:(BOOL)debugMode;

/** Sets network data compression, default is off (NO). */
+ (void)setCompressData:(BOOL)compressdata;

- (NSDictionary *)debugInformationPublic;
- (NSDictionary *)debugInformationPrivate;


@end
