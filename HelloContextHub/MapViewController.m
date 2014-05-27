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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createDefaultGeofenceTapped:(id)sender{
    [self createSampleGeofence];
}

- (void)createSampleGeofence {
    
    CLLocationDistance radius = 100;
    CLCircularRegion *geofence = [[CLCircularRegion alloc] initWithCenter:self.mapView.centerCoordinate radius:radius identifier:@"sample"];

    [CCHGeofenceService createGeofence:geofence completion:^(NSDictionary *fenceInfo, NSError *error) {
        if (error) {
            NSLog(@"There was an error while creating the geofence %@", error);
        } else {
            NSLog(@"Fence Info Response from ContextHub %@", fenceInfo);
        }
    }];
}
@end
