//
//  PointAnnotationDelegate.h
//  MapShop
//
//  Created by Mike Bevz on 10/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MKAnnotation.h>

@interface PointAnnotationDelegate : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	CLLocationCoordinate2D theCoordinate;
	UIImage *image;
	NSString *title;
	NSString *subtitle;
    NSNumber *latitude;
	NSNumber *longitude;
    NSNumber *point_id;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSNumber *point_id;

@end
