//
//  RNBatteryStatus.m
//  RNBatteryStatus
//  Created by Ross Haker on 9/08/15.
//

#import "RNBatteryStatus.h"

@implementation RNBatteryStatus

// Expose this module to the React Native bridge
RCT_EXPORT_MODULE()

// Persist data
RCT_EXPORT_METHOD(batteryStatus:(NSString *)batteryDesc
                  errorCallback:(RCTResponseSenderBlock)failureCallback
                  callback:(RCTResponseSenderBlock)successCallback) {
    
    // Get the device
    UIDevice* currentDevice = [UIDevice currentDevice];
    UIDeviceBatteryState currentState = [currentDevice batteryState];
    
    // Check if the device is being charged
    if (currentState == UIDeviceBatteryStateCharging) {
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"Device is currently plugged in."
                                      };
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultsDict]);
        return;
    }
    
    // Handle the start case
    if ([batteryDesc isEqual: @"getLevel"]) {
        
        // Ensure monitoring is on
        currentDevice.batteryMonitoringEnabled = YES;
        
        // Get the level
        float currentLevel = currentDevice.batteryLevel;
        float percent = currentLevel * 100;
        
        // Check if level is -1 (which is unknown state)
        if (currentLevel == -1) {
            
            // Show failure message
            NSDictionary *resultsDict = @{
                                          @"success" : @NO,
                                          @"errMsg"  : @"Battery level is unknown. Battery monitoring may be off or you are running the simulator."
                                          };
            
            // Execute the JavaScript failure callback handler
            failureCallback(@[resultsDict]);
            return;
            
        }
        
        // Prettify the return level
        NSString *returnString = [NSString stringWithFormat:@"Battery level is %f percent", percent];
        
        // Show success message that screen has been put to sleep
        NSDictionary *resultsDict = @{
                                      @"success" : @YES,
                                      @"successMsg"  : returnString
                                      };
        
        // Call the JavaScript sucess handler
        successCallback(@[resultsDict]);
        return;
        
    } else if ([batteryDesc isEqual: @"turnOff"]) {
        
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
        
        // Show success message that monitoring is turned off
        NSDictionary *resultsDict = @{
                                      @"success" : @YES,
                                      @"successMsg"  : @"Battery monitoring turned off."
                                      };
        
        // Call the JavaScript sucess handler
        successCallback(@[resultsDict]);
        return;
        
    } else {
        
        // Show failure message
        NSDictionary *resultsDict = @{
                                      @"success" : @NO,
                                      @"errMsg"  : @"Invalid description type. Set to either getLevel or turnOff."
                                      };
        
        // Execute the JavaScript failure callback handler
        failureCallback(@[resultsDict]);
        return;
        
    }
}

@end
