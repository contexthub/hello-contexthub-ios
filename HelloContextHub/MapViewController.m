//
//  MapViewController.m
//  HelloContextHub
//
//  Created by Kevin Lee on 5/21/14.
//  Copyright (c) 2014 Context Hub. All rights reserved.
//

#import "MapViewController.h"

#import "HCHGlobals.h"

@interface MapViewController ()

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Actions

// Creates a geofence when button is tapped
- (IBAction)createDefaultGeofenceTapped:(id)sender {
    [self createSampleGeofence];
}

// Creates a geofence around the current location
- (void)createSampleGeofence {
    CLLocationDistance radius = 1000;
    CLCircularRegion *sampleGeofence = [[CLCircularRegion alloc] initWithCenter:self.mapView.centerCoordinate radius:radius identifier:@"sample"];

    // Create a geofence in ContextHub
    [[CCHGeofenceService sharedInstance] createGeofenceWithCenter:sampleGeofence.center radius:sampleGeofence.radius name:sampleGeofence.identifier tags:@[HelloContextHubGeofenceTag] completionHandler:^(NSDictionary *geofence, NSError *error) {
        
        if (!error){
            NSLog(@"Fence response from ContextHub %@", geofence);
            // Place the circle on the map
            [self placeGeofenceOnMap:sampleGeofence];
            
            // Synchronize the sensor pipeline with ContextHub (if you have push set up correctly, you can skip this step!)
            [[CCHSensorPipeline sharedInstance] synchronize:^(NSError *error) {
                
                if (!error) {
                    NSLog(@"Synchronization successful!");
                } else {
                    NSLog(@"There was an error synchronizing with ContextHub: %@", error);
                }
            }];
        } else {
            NSLog(@"There was an error while creating the geofence %@", error);
        }
    }];
}

// Places a geofence on a map with a pin and a circle
- (void)placeGeofenceOnMap:(CLCircularRegion *)geofence {
    // Add the pin
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = geofence.center;
    pin.title = HelloContextHubGeofeneName;
    [self.mapView addAnnotation:pin];
    
    // Add the circle
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:geofence.center radius:geofence.radius];
    [self.mapView addOverlay:circle];
}

#pragma mark - Map View Methods 

// Draws a circle on a map which represents a geofence
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay{
    if ([overlay isKindOfClass:[MKCircle class]]) {
        // Draw the circle on the map how we want it (light blue inside with darker blue border)
        MKCircleRenderer* aRenderer = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
        
        aRenderer.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.1];
        aRenderer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
        aRenderer.lineWidth = 3;
        return aRenderer;
    }
    return nil;
}

@end