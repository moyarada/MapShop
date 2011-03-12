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
#import <MapKit/MKReverseGeocoder.h>
#import "ShopPointsViewController.h"

@interface AddPointViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, MKAnnotation, RKObjectLoaderDelegate> {
	UITextField *commentFld;
	UITextField *latFld;
	UITextField  *longFld;
	UITextField  *altFld;
	NSString *item;
	RKManagedObject *parent;
	NSNumber *parentId;
	CLLocationManager *locationManager;
	NSNumber *curLat;
	NSNumber *curLong;
	NSNumber *curAlt;
	MKMapView *mapView;
	MKReverseGeocoder *geoCoder;
	MKPlacemark *mPlacemark;
	UINavigationItem *navItem;
    ShopPointsViewController *viewController;
}

@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UINavigationItem *navItem;
@property (nonatomic, retain) IBOutlet UITextField *commentFld;
@property (nonatomic, retain) IBOutlet UITextField *latFld;
@property (nonatomic, retain) IBOutlet UITextField  *longFld;
@property (nonatomic, retain) IBOutlet UITextField  *altFld;
@property (nonatomic, retain) NSString *item;
@property (nonatomic, retain) RKManagedObject *parent;
@property (nonatomic, retain) NSNumber *parentId;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) ShopPointsViewController *viewController;

- (IBAction) removeFocus;
- (void) gotoLocation;

@end
