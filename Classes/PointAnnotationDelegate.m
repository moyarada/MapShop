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

// Implementing this method ensures the Key-Value observers will be notified when the properties
// from which coordinate is derived have changed.
//
+ (NSSet *)keyPathsForValuesAffectingCoordinate
{
    return [NSSet setWithObjects:@"latitude", @"longitude", nil];
}

-(id)init
{
    [super init];
    
	return self;
}



- (void)dealloc {
	//[image release];
    //[latitude release];
    //[longitude release];
    //[title release];
    //[subtitle release];
    [super dealloc];
}

@end
