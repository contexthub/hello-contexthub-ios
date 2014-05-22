//
//  CCHAppDelegate.m
//  HelloContextHub
//
//  Created by Kevin Lee on 5/21/14.
//  Copyright (c) 2014 Context Hub. All rights reserved.
//

#import "CCHAppDelegate.h"


@implementation CCHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Register your app id
    [ContextHub registerWithAppId:@"9629bd80-2db1-420a-bc61-a8a1008ef292"];
    [[CCHContextEventManager sharedManager] setDelegate:self];
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
