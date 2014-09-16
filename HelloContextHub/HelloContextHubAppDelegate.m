//
//  HelloContextHubAppDelegate.m
//  HelloContextHub
//
//  Created by Kevin Lee on 5/21/14.
//  Copyright (c) 2014 Context Hub. All rights reserved.
//

#import "HelloContextHubAppDelegate.h"

#import "HCHGlobals.h"

@implementation HelloContextHubAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    // The debug flag is automatically set by the compiler, indicating which push gateway server your device will use
    // Xcode deployed builds use the sandbox/development server
    // TestFlight/App Store builds use the production server
    // ContextHub records which environment a device is using so push works properly
    // This must be called BEFORE [ContextHub registerWithAppId:]
    [[ContextHub sharedInstance] setDebug:TRUE];
#endif
    
    // Register the app id of the application you created on https://app.contexthub.com
    [ContextHub registerWithAppId:@"YOUR-APP-ID-HERE"];
    
    // The sensor pipeline registers contexts and sends event data to the server.
    // The delegate will be called during the lifecycle of sending context events to the server.
    // Use the datasource methods if you would like to add your own payload to the context event.
    [[CCHSensorPipeline sharedInstance] setDelegate:self];
    [[CCHSensorPipeline sharedInstance] setDataSource:self];
    
    // Add a subscription to the Hello ContextHub geofence tag so we start generating events on the server
    if ([[CCHSensorPipeline sharedInstance] addElementsWithTags:@[HelloContextHubGeofenceTag]]) {
        NSLog(@"Successfully added elements with tags '%@' to CCHSensorPipeline", HelloContextHubGeofenceTag);
    } else {
        NSLog(@"Error adding elements with tags '%@' to CCHSensorPipeline", HelloContextHubGeofenceTag);
    }
    
    return YES;
}

#pragma mark - Sensor Pipeline Delegate

- (BOOL)sensorPipeline:(CCHSensorPipeline *)sensorPipeline shouldPostEvent:(NSDictionary *)event {
    // If you'd like to keep events from hitting the server, you can return NO here.
    // This is a good spot to filter events.
    NSLog(@"Should post event?");
    return YES;
}

- (void)sensorPipeline:(CCHSensorPipeline *)sensorPipeline willPostEvent:(NSDictionary *)event {
    // If you want to access event data directl before it will be posted to the server, you can do that here
    NSLog(@"Will post event: %@", event);
}

- (void)sensorPipeline:(CCHSensorPipeline *)sensorPipeline didPostEvent:(NSDictionary *)event {
    // If you want to access event data directly after it has been posted to the server, you can do that here
    NSLog(@"Did post event: %@", event);
}

#pragma mark - Sensor Pipeline Data Source

- (NSDictionary*)sensorPipeline:(CCHSensorPipeline *)sensorPipeline payloadForEvent:(NSDictionary *)event {
    // Add custom data structures to the events, and they will end up on the server.
    return @{@"Name": @"Kevin"};
}

@end