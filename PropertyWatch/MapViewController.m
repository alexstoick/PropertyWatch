//
//  MapViewController.m
//  PropertyWatch
//
//  Created by Stoica Alexandru on 12/29/13.
//  Copyright (c) 2013 Stoica Alexandru. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController()


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

-(void)viewDidLoad
{
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake( self.currentProperty.latitude, self.currentProperty.longitude) ;
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = center;
    mapRegion.span.latitudeDelta = 0.01;
    mapRegion.span.longitudeDelta = 0.01;
    [self.mapView setRegion:mapRegion animated: YES];
    
    MKPointAnnotation * pin = [[MKPointAnnotation alloc] init];
    
    [pin setCoordinate:center];
    
    [self.mapView addAnnotation:pin];
    
}

@end
