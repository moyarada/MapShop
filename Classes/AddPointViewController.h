//
//  AddPointViewController.h
//  MapShop
//
//  Created by Mike Bevz on 21/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "RestKit/RestKit.h"
#import "PointAnnotationDelegate.h"
#import "Shop.h"
#import <CoreData/CoreData.h>
#import "MapShopAppDelegate.h"
#import "SPoint.h"

@interface AddPointViewController : UIViewController <MKMapViewDelegate, RKObjectLoaderDelegate> {
	Shop *parent;
    MKMapView *mapView;
    BOOL showUserLocation;
}

@property (nonatomic, retain) Shop *parent;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

- (IBAction) removeFocus;
- (void) gotoLocation;
- (void) savePoints;
- (void)showDetails: (id)sender;

@end