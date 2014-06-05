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
    [[CCHContextEventManager sharedManager] setDelegate:self];
    
    //Use the datasource methods if you would like to add your own payload to the context event.
    [[CCHContextEventManager sharedManager] setDataSource:self];

    return YES;
}
							
#pragma mark - CCHContextEventManagerDelegate

- (void)contextEventManager:(CCHContextEventManager *)eventManager willPostEvent:(NSDictionary *)event {
    NSLog(@"will post event: %@", event);
}

- (void)contextEventManager:(CCHContextEventManager *)eventManager didPostEvent:(NSDictionary *)event {
    NSLog(@"did post event: %@", event);
}

#pragma mark - CCHContextEventManagerDataSource

- (BOOL)contextEventManager:(CCHContextEventManager *)eventManager shouldPostEvent:(NSDictionary *)event {
    //If you'd like to keep events from hitting the server, you can return NO here.
    //This is a good spot to filter events.
    NSLog(@"Should post event?");
    return YES;
}

- (NSDictionary*)contextEventManager:(CCHContextEventManager *)eventManager payloadForEvent:(NSDictionary *)event {
    //Add custom data structures to the events, and they will end up on the server.
    return @{@"Name": @"Kevin"};
}

@end
