//
//  HellowcontextHubAppDelegate.m
//  HelloContextHub
//
//  Created by Kevin Lee on 5/21/14.
//  Copyright (c) 2014 Context Hub. All rights reserved.
//

#import "HelloContextHubAppDelegate.h"


@implementation HelloContextHubAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Register your app id
    [ContextHub registerWithAppId:@"YOUR-APP-ID-HERE"];
    
    //The context event manager registers contexts and sends event data to the server.
    
    //The delegate will be called during the lifecycle of sending context events to the server.
    [[CCHSensorPipeline sharedInstance] setDelegate:self];
    
    //Use the datasource methods if you would like to add your own payload to the context event.
    [[CCHSensorPipeline sharedInstance] setDataSource:self];

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
    NSLog(@"Will post event: %@", event);
}

- (void)sensorPipeline:(CCHSensorPipeline *)sensorPipeline didPostEvent:(NSDictionary *)event {
    NSLog(@"Did post event: %@", event);
}

#pragma mark - Sensor Pipeline Data Source

- (NSDictionary*)sensorPipeline:(CCHSensorPipeline *)sensorPipeline payloadForEvent:(NSDictionary *)event {
    // Add custom data structures to the events, and they will end up on the server.
    return @{@"Name": @"Kevin"};
}

@end
