#include "AppDelegate.h"

#include "GeneratedPluginRegistrant.h"
@import WalkbaseEngageSDK; // Objective-C

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
  
  FlutterMethodChannel* deviceIdChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"example.com/flutterbase"
                                            binaryMessenger:controller];
  
  __weak typeof(self) weakSelf = self;
  [deviceIdChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
      if ([@"getDeviceId" isEqualToString:call.method]) {
          result([weakSelf getDeviceId]);
      } else {
          result(FlutterMethodNotImplemented);
      }
  }];
  
  @try
  {
    [WBEngageManager startWithAPIKey:@"VZHkscRFhAjkScc"];
    [WBEngageManager setUserIdentifier:[weakSelf getDeviceId]];
    NSLog(@"Started Successfully");
  }
  @catch (NSException *e)
  {
    //one of the objects/keys was NULL
      NSLog(@"An Exception was occurred");
  }
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSString *)getDeviceId {
    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if (!deviceId) {
        deviceId = @"userId";
    }
    return deviceId;
}

@end
