//
//  PointAnnotationDelegate.h
//  MapShop
//
//  Created by Mike Bevz on 10/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>

@interface PointAnnotationDelegate : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
    NSString * title;
    NSString * subtitle;
	
	UIImage *image;
    NSNumber *latitude;
    NSNumber *longitude;
	
	
	
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) NSString * title;
@property (nonatomic, readonly) NSString * subtitle;


@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;



@end
