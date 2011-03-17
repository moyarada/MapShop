//
//  AddPointViewController.m
//  MapShop
//
//  Created by Mike Bevz on 21/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddPointViewController.h"


@implementation AddPointViewController

@synthesize parent, mapView;

#pragma mark -
#pragma mark Application init

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		//self.title = @"New point";
    }
    return self;
}
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePoint)];
	self.navigationItem.rightBarButtonItem = saveButton;
	
	mapView.showsUserLocation = YES;
	mapView.mapType = MKMapTypeHybrid;
	//mapView.delegate = self;
    
    NSFetchRequest* request = [SPoint fetchRequest];
	NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(shop=%@) AND (del == false)", parent];
	[request setPredicate:predicate];
    
	
	NSArray *pins = [SPoint objectsWithFetchRequest:request];
    
    if ([pins count] > 0) {
        
        MKMapRect flyTo = MKMapRectNull;
        
        for(SPoint *pin in pins) {
            PointAnnotationDelegate *annot = [[PointAnnotationDelegate alloc] init];
            annot.latitude = pin.latitude;
            annot.longitude = pin.longitude;
            annot.title = pin.name;
            annot.subtitle = pin.comment; 
            annot.point_id = pin.id;
            [mapView addAnnotation:annot];
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annot.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
            if (MKMapRectIsNull(flyTo)) {
                flyTo = pointRect;
            } else {
                flyTo = MKMapRectUnion(flyTo, pointRect);
            }
            [annot release];
        }
        mapView.visibleMapRect = flyTo;
    } else {
        showUserLocation = true;
    }
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dropPin:)];
    [mapView addGestureRecognizer:longPressGesture];
    [longPressGesture release];
    
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    NSLog(@"Unload view");
	self.mapView.delegate = nil;
	self.mapView = nil;
    parent = nil;
    
}

- (void)dealloc {
    
    NSLog(@"De Alloc View");
	[self.parent release];
    self.mapView.delegate = nil;
	[self.mapView release];
    
    [super dealloc];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Actions

- (void)dropPin:(UILongPressGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        NSLog(@"Drop a pin");
        
        CGPoint location = [gestureRecognizer locationInView:self.mapView];
        CLLocationCoordinate2D coordinate = [mapView convertPoint:location toCoordinateFromView:self.mapView];
        
        
        PointAnnotationDelegate * mapannotation = [[PointAnnotationDelegate alloc] init];
        mapannotation.latitude = [NSNumber numberWithDouble:coordinate.latitude];
        mapannotation.longitude = [NSNumber numberWithDouble:coordinate.longitude];
        mapannotation.title = @"New point";
        mapannotation.subtitle = @"Subtitle";
        [mapView addAnnotation:mapannotation];
        //[mapannotation release];
    }
}

- (void)savePoints {
	NSLog(@"Saving Point");
	
	
    
    for(PointAnnotationDelegate *annot in mapView.annotations) {
        if ([annot isKindOfClass:[PointAnnotationDelegate class]]) {
            if ([annot point_id]) {
                SPoint* point = [SPoint objectWithPrimaryKeyValue:[annot point_id]];
                if (point) {
                    point.shop_id = [self.parent id];
                    point.shop = (Shop*)self.parent;
                    point.latitude = annot.latitude;
                    point.longitude = annot.longitude;
                    point.sync = [NSNumber numberWithBool:YES];
                    
                    NSLog(@"Updating a Point: %@", point);
                    [[RKObjectManager sharedManager] putObject:point delegate:self];
                }
                
            } else {
                SPoint* point = [SPoint object];
                point.name = @"Point";
                point.shop_id = [self.parent id];
                point.shop = (Shop*)self.parent;
                point.latitude = annot.latitude;
                point.longitude = annot.longitude;
                point.sync = [NSNumber numberWithBool:YES];
                
                NSLog(@"Creating a Point: %@", point);
                [[RKObjectManager sharedManager] postObject:point delegate:self];
                //[point release];
            }
        }
    }
    
    NSLog(@"Points to save = %@", mapView.annotations);
    
    //TODO this alert must popup when we saved out pins. Otherwise it craches the app
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Pins saved/updated" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [alert show];
    
	//[[RKObjectManager sharedManager] postObject:point delegate:self];
}

- (IBAction) removeFocus {
	//[commentFld resignFirstResponder];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	NSLog(@"Loaded items in add point: %@", objects);
    //[self.viewController loadObjectsFromDataStore];
	//[self.navigationController popViewControllerAnimated:YES];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
}


#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (showUserLocation == YES) {
        [self gotoLocation];
        showUserLocation = NO;
    }
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView 
    didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
}


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[PointAnnotationDelegate class]]) {
        static NSString* PointAnnotationIdentifier = @"pointAnnotationIdentifier";
        
        MKPinAnnotationView* pinView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:PointAnnotationIdentifier];
        
        if (!pinView) {
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PointAnnotationIdentifier] autorelease];
            [customPinView setPinColor:MKPinAnnotationColorRed];
            [customPinView setAnimatesDrop:YES];
            [customPinView setDraggable:YES];
            [customPinView setCanShowCallout:YES];
            [customPinView setSelected:YES animated:YES];
            
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
            //[rightButton setImage:[UIImage imageNamed:@""] forState:<#(UIControlState)#>]
            //[rightButton setTitle:@"Delete"];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            //[rightButton release];
            
            return customPinView;
        } else
        {
            pinView.annotation = annotation;
        }
        
        return pinView;
        
    } 
    
    return nil;
}

- (void)showDetails: (id)sender {
    NSLog(@"Touched the button");
}

- (void)mapView:(MKMapView *)mView annotationView:(MKAnnotationView *)annoView calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Pin was touched: %@", [(PointAnnotationDelegate *)annoView.annotation point_id]);
    
    //TODO Send request to server to remove a pin;
    SPoint *point = [SPoint objectWithPrimaryKeyValue:[(PointAnnotationDelegate *)annoView.annotation point_id]];
    if (point) {
        [[RKObjectManager sharedManager] deleteObject:point delegate:self];
    }
    
    [mView removeAnnotation:annoView.annotation];
    
}


#pragma mark -
#pragma mark Maps

- (IBAction)gotoLocation
{
    MKCoordinateRegion newRegion;
	newRegion.center = mapView.userLocation.coordinate;
	newRegion.span.latitudeDelta = 0.0010;
	newRegion.span.longitudeDelta = 0.0010;
	
	[mapView setRegion:newRegion animated:YES];
}

#pragma mark -
#pragma mark MKReverseGeocoderDelegate methods
/*
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)newPlacemark {
    //[self notifyCalloutInfo:newPlacemark];
    NSLog(@"newPlacemark: %@", newPlacemark);
    addressFld.text = [NSString stringWithFormat:@"%@, %@, %@, %@, %@", [newPlacemark thoroughfare], [newPlacemark subThoroughfare], [newPlacemark locality], [newPlacemark postalCode], [newPlacemark country]];
    geocoder.delegate = nil;
    [geocoder release];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    //[self notifyCalloutInfo:nil];
    geocoder.delegate = nil;
    [geocoder release];
}

- (IBAction)reverseGeocodeCurrentLocation {
    if (!self.reverseGeocoder) {
        self.reverseGeocoder = [[[MKReverseGeocoder alloc] initWithCoordinate:mapView.userLocation.location.coordinate] autorelease];
        reverseGeocoder.delegate = self;
        [reverseGeocoder start];
    }
}
*/

#pragma mark -
#pragma mark Location manager
/*
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"Entering locationmanager did updatetolocation");
	
	NSTimeInterval howRecent = [newLocation.timestamp timeIntervalSinceNow];
	
	if (howRecent < -100) {
		return;
	}
	
	if (newLocation.horizontalAccuracy > 100) { 
		return;
	}
    [curLong release];
    [curLat release];
    [curAlt release];
    
	
	curLong = [[NSNumber numberWithDouble:newLocation.coordinate.longitude] retain];
	curLat = [[NSNumber numberWithDouble:newLocation.coordinate.latitude] retain];
	curAlt = [[NSNumber numberWithDouble:newLocation.altitude] retain];
	
	
	//int degrees = newLocation.coordinate.latitude;
	
	//double decimal = fabs(newLocation.coordinate.latitude - degrees);
	//int minutes = decimal * 60;
	//double seconds = decimal * 3600 - minutes * 60;
	
	//NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
	//				 degrees, minutes, seconds];

	//latFld.text = lat;
	//degrees = newLocation.coordinate.longitude;
	
	//decimal = fabs(newLocation.coordinate.longitude - degrees);
	//minutes = decimal * 60;
	//seconds = decimal * 3600 - minutes * 60;
	//NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
	//				   degrees, minutes, seconds];
	//longFld.text = longt;
	
	//altFld.text = [NSString stringWithFormat:@" %1.2f", curAlt];
	
	// Update map
	//[[NSUserDefaults standardUserDefaults] setDouble: newLocation.coordinate.latitude forKey:@"LastLocationLatitude"];
	//[[NSUserDefaults standardUserDefaults] setDouble: newLocation.coordinate.longitude forKey:@"LastLocationLongitude"];
	//[[NSUserDefaults standardUserDefaults] synchronize];
	
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
		//[locationManager stopUpdatingLocation];
	}
			
	
}
 */
/*

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	annView.animatesDrop=TRUE;
    annView.draggable = TRUE;
	return annView;
}
 */







@end
