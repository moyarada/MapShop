    //
//  PointAnnotationDelegate.m
//  MapShop
//
//  Created by Mike Bevz on 10/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PointAnnotationDelegate.h"



@implementation PointAnnotationDelegate 


@synthesize image, latitude, longitude;

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 37.786996;
    theCoordinate.longitude = -122.419281;
    return theCoordinate; 
}

- (NSString *)title
{
    return @"San Francisco";
}

// optional
- (NSString *)subtitle
{
    return @"Founded: June 29, 1776";
}


- (void)dealloc {
	[image release];
    [super dealloc];
}


@end
