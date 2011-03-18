    //
//  PointAnnotationDelegate.m
//  MapShop
//
//  Created by Mike Bevz on 10/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PointAnnotationDelegate.h"



@implementation PointAnnotationDelegate 


@synthesize image, latitude, longitude, title, subtitle, point_id;

- (CLLocationCoordinate2D)coordinate;
{
    theCoordinate.latitude = [self.latitude doubleValue];
    theCoordinate.longitude = [self.longitude doubleValue];
    return theCoordinate; 
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    self.latitude = [NSNumber numberWithDouble:newCoordinate.latitude];
    self.longitude = [NSNumber numberWithDouble:newCoordinate.longitude];
}

-(id)init
{
    [super init];
    
	return self;
}


- (void)dealloc {
    NSLog(@"De Alloc Annotation: %@", title);
	[title release];
    [subtitle release];
    [image release];
    [latitude release];
    [longitude release];
    [point_id release];
    [super dealloc];
}

@end
