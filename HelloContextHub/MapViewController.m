//
//  MapViewController.m
//  HelloContextHub
//
//  Created by Kevin Lee on 5/21/14.
//  Copyright (c) 2014 Context Hub. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createDefaultGeofenceTapped:(id)sender {
    [self createSampleGeofence];
}

- (void)createSampleGeofence {
    CLLocationDistance radius = 50;
    CLCircularRegion *geofence = [[CLCircularRegion alloc] initWithCenter:self.mapView.centerCoordinate radius:radius identifier:@"sample"];

    // Create a geofence in ContextHub
    [CCHGeofenceService createGeofence:geofence completion:^(NSDictionary *fenceInfo, NSError *error) {
        if (error) {
            NSLog(@"There was an error while creating the geofence %@", error);
        } else {
            NSLog(@"Fence response from ContextHub %@", fenceInfo);
            // Place the circle on the map
            [self placeGeofenceOnMap:geofence];
        }
    }];
}

- (void)placeGeofenceOnMap:(CLCircularRegion *)geofence {
    // Place the circle on the map
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:geofence.center radius:geofence.radius];
    [self.mapView addOverlay:circle];
}

#pragma mark - Map View Methods 
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay{
    if ([overlay isKindOfClass:[MKCircle class]]) {
        // Draw the circle on the map how we want it (cyan inside with blue border)
        MKCircleRenderer* aRenderer = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
        
        aRenderer.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        aRenderer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        aRenderer.lineWidth = 3;
        return aRenderer;
    }
    return nil;
}

@end
