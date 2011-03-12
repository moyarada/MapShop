//
//  AddPointViewController.m
//  MapShop
//
//  Created by Mike Bevz on 21/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddPointViewController.h"
#import "MapShopAppDelegate.h"
#import "SPoint.h"
#import <MapKit/MKAnnotation.h>
#import <MapKit/MapKit.h>
#import "PointAnnotationDelegate.h"

@implementation AddPointViewController

@synthesize item, parent, commentFld, latFld, longFld, altFld, 
			mapView, navigationController, navItem, parentId, viewController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.title = @"New point";
		
		locationManager = [[CLLocationManager alloc] init];
		locationManager.delegate = self;
		locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
		locationManager.desiredAccuracy = kCLLocationAccuracyBest; // or kCLLocationAccuracyBest
		
		
		
    }
    return self;
}

- (void)savePoint {
	NSLog(@"Saving Point");
	
	SPoint* point = [SPoint object];
	point.name = commentFld.text;
	point.shop_id = self.parentId;
	point.altitude = curAlt;
	point.latitude = curLat;
	point.longitude = curLong;
    point.shop = (Shop*)self.parent;
	point.sync = [NSNumber numberWithBool:YES];
    
    //[[RKObjectManager sharedManager].objectStore save];
    //[self.navigationController popViewControllerAnimated:YES];
	[[RKObjectManager sharedManager] postObject:point delegate:self]; 
	
	
}

- (IBAction) removeFocus {
	[commentFld resignFirstResponder];
}

#pragma mark -
#pragma mark RestKit


#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	//NSLog(@"Objects loaded");
	//[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
	//[[NSUserDefaults standardUserDefaults] synchronize];
	NSLog(@"Loaded items in add point: %@", objects);
	
    //[[RKObjectManager sharedManager].objectStore save];
    [self.viewController loadObjectsFromDataStore];
	[self.navigationController popViewControllerAnimated:YES];
	//[self loadObjectsFromDataStore];
	//[_tableView reloadData];
	
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
	
	//[self loadObjectsFromDataStore];
	//[_tableView reloadData];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePoint)];
	self.navigationItem.rightBarButtonItem = saveButton;
	
	//if (locationManager) {
		[locationManager startUpdatingLocation];
	//}
	
	mapView.showsUserLocation=TRUE;
	mapView.mapType=MKMapTypeHybrid;
	mapView.delegate = self;
	
	double lastLocationLat = [[NSUserDefaults standardUserDefaults] doubleForKey:@"LastLocationLatitude"];
	double lastLocationLong = [[NSUserDefaults standardUserDefaults] doubleForKey:@"LastLocationLongitude"];
	
	PointAnnotationDelegate * annotation = [[PointAnnotationDelegate alloc] init];
	[mapView addAnnotation:annotation];
	[annotation release];

	
	if (lastLocationLat) {
		
		//MKReverseGeocoder *reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:_coordinate];
		//reverseGeocoder.delegate = self;
		//[reverseGeocoder start];
		
		
		MKCoordinateRegion region;
		MKCoordinateSpan span;
		span.latitudeDelta=0.0039;
		span.longitudeDelta=0.0034;
		
		CLLocationCoordinate2D location=mapView.userLocation.coordinate;
		location.latitude = lastLocationLat;
		location.longitude = lastLocationLong;
		
		region.span = span;
		region.center = location;
		
		
		
		//[mapView setRegion:region animated:FALSE];
		//	[mapView regionThatFits:region];
		
		
	}
	
	[self gotoLocation]; 
	
}

- (void)gotoLocation
{
    // start off by default in San Francisco
	double lastLocationLat = [[NSUserDefaults standardUserDefaults] doubleForKey:@"LastLocationLatitude"];
	double lastLocationLong = [[NSUserDefaults standardUserDefaults] doubleForKey:@"LastLocationLongitude"];
	
	if (lastLocationLat) {
		MKCoordinateRegion newRegion;
		newRegion.center.latitude = lastLocationLat;
		newRegion.center.longitude = lastLocationLong;
		newRegion.span.latitudeDelta = 0.112872;
		newRegion.span.longitudeDelta = 0.109863;
		
		[mapView setRegion:newRegion animated:YES];
	}
}


#pragma mark -
#pragma mark MKMapViewDelegate

- (void)showDetails:(id)sender
{
    // the detail view does not want a toolbar so hide it
	NSLog(@"Show details");
    //[self.navigationController setToolbarHidden:YES animated:NO];
    
    //[self.navigationController pushViewController:self.detailViewController animated:YES];
}



#pragma mark -
#pragma mark MKReverseGeocoderDelegate methods

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)newPlacemark {
    //[self notifyCalloutInfo:newPlacemark];
    geocoder.delegate = nil;
    [geocoder release];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    //[self notifyCalloutInfo:nil];
    geocoder.delegate = nil;
    [geocoder release];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Location manager

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"Entering locationmanager did updatetolocation");
	
	NSTimeInterval howRecent = [newLocation.timestamp timeIntervalSinceNow];
	
	if (howRecent < -100) {
		return;
	}
	
	//if (newLocation.horizontalAccuracy > 100) { 
	//	return;
	//}
	
	curLong = [[NSNumber numberWithDouble:newLocation.coordinate.longitude] retain];
	curLat = [[NSNumber numberWithDouble:newLocation.coordinate.latitude] retain];
	curAlt = [[NSNumber numberWithDouble:newLocation.altitude] retain];
	
	
	int degrees = newLocation.coordinate.latitude;
	
	double decimal = fabs(newLocation.coordinate.latitude - degrees);
	int minutes = decimal * 60;
	double seconds = decimal * 3600 - minutes * 60;
	
	NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
					 degrees, minutes, seconds];

	latFld.text = lat;
	degrees = newLocation.coordinate.longitude;
	
	decimal = fabs(newLocation.coordinate.longitude - degrees);
	minutes = decimal * 60;
	seconds = decimal * 3600 - minutes * 60;
	NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
					   degrees, minutes, seconds];
	longFld.text = longt;
	
	altFld.text = [NSString stringWithFormat:@" %1.2f", curAlt];
	
	// Update map
	[[NSUserDefaults standardUserDefaults] setDouble: newLocation.coordinate.latitude forKey:@"LastLocationLatitude"];
	[[NSUserDefaults standardUserDefaults] setDouble: newLocation.coordinate.longitude forKey:@"LastLocationLongitude"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
}

-(void)locationManager:(CLLocationManager*)manager
	  didFailWithError:(NSError*)error {
	NSLog(@"Error ");
	
	if (error.code == kCLErrorDenied) {
		[[[[UIAlertView alloc] initWithTitle:@"Aw snap!"
									 message:@"User didn't allow location tracking"
									delegate:nil
						   cancelButtonTitle:@"OK"
						   otherButtonTitles:nil] autorelease] show];
		//self.toggle.on = NO;
		[locationManager stopUpdatingLocation];
	}
			
	
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	annView.animatesDrop=TRUE;
	return annView;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.commentFld = nil;
	self.latFld = nil;
	self.longFld = nil;
	self.altFld = nil;
	[locationManager stopUpdatingLocation];
	locationManager = nil;
	mapView.delegate = nil;
	mapView = nil;

}

- (void)dealloc {
	[commentFld release];
	[latFld release];
	[longFld release];
	[altFld release];
	[item release];
	[parent release];
	[locationManager stopUpdatingLocation];
	[locationManager release];
	mapView.delegate = nil;
	[mapView release];
	[parentId release];
	[curLat release];
	[curLong release];
	[curAlt release];
    [viewController release];
    [super dealloc];
}


@end
