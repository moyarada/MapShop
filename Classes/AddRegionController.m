//
//  AddRegionController.m
//  MapShop
//
//  Created by Mike Bevz on 17/01/11.
//  Copyright 2011 AndAnts. All rights reserved.
//

#import "AddRegionController.h"
#import "MapShopAppDelegate.h"
#import "Region.h"
#import "City.h"
#import "Area.h"
#import "Shop.h"
#import "SPoint.h"


@implementation AddRegionController

@dynamic regionName;
@synthesize item, parent, navigationController, parentId, viewController;

#pragma mark -
#pragma mark App life cycle


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = [NSString stringWithFormat:@"New %@", item];
	regionName.text = @"";
	regionName.placeholder = [NSString stringWithFormat:@"Enter New %@", item];
	[regionName becomeFirstResponder];
	
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Actions

-(IBAction)saveData {
	
	if (item == @"Region") {

		Region* region = [Region object];
		region.name = regionName.text;
		region.comment = @"Some comment";
		region.sync = [NSNumber numberWithBool:YES];
        
        [[RKObjectManager sharedManager] postObject:region delegate:self]; 
        
        //[viewController loadObjectsFromDataStore];
        //[self.navigationController popViewControllerAnimated:YES];
        
	}	
	
	if (item == @"City") {
	//	cities *model = (cities *)[NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:context];
		
		
		City* city = [City object];
		city.name = regionName.text;
		city.comment = @"Some comment";
		city.region_id = self.parentId;
		city.sync = [NSNumber numberWithBool:YES];
        city.region = (Region*)parent;
        
        //[[RKObjectManager sharedManager].objectStore save];
        //[viewController loadObjectsFromDataStore];
        //[self.navigationController popViewControllerAnimated:YES];
        
		[[RKObjectManager sharedManager] postObject:city delegate:self]; 

	}
	
	if (item == @"Area") {
		Area* area = [Area object];
		area.name = regionName.text;
		area.comment = @"Some comment";
		area.city_id = self.parentId;
		area.city = (City*)parent;
        area.sync = [NSNumber numberWithBool:YES];
		[[RKObjectManager sharedManager] postObject:area delegate:self]; 
        //[[RKObjectManager sharedManager].objectStore save];
        //[viewController loadObjectsFromDataStore];
		//[self.navigationController popViewControllerAnimated:YES];
        
	}
	
	if (item == @"Shop") {
		Shop* shop = [Shop object];
		shop.name = regionName.text;
		shop.comment = @"Some comment";
		shop.area_id = self.parentId;
		shop.area = (Area*)self.parent;
        shop.sync = [NSNumber numberWithBool:YES];
        
		[[RKObjectManager sharedManager] postObject:shop delegate:self]; 
        //[[RKObjectManager sharedManager].objectStore save];
        //[viewController loadObjectsFromDataStore];
        //[self.navigationController popViewControllerAnimated:YES];
        
	}
	
	if (item == @"SPoint") {
		
		SPoint* point = [SPoint object];
		point.name = regionName.text;
		point.comment = @"Some comment";
		point.shop_id = self.parentId;
		point.shop = (Shop*)self.parent;
        point.sync = [NSNumber numberWithBool:YES];
        
		//[[RKObjectManager sharedManager] postObject:point delegate:self]; 
        [[RKObjectManager sharedManager].objectStore save];
        [viewController loadObjectsFromDataStore];
        [self.navigationController popViewControllerAnimated:YES];
        
        
	//	SPoint *model = (SPoint *)[NSEntityDescription insertNewObjectForEntityForName:@"SPoint" inManagedObjectContext:context];
		
	//	[model setName:regionName.text];
	//	[model setShop:(Shop *) parent];
		
	}
	
	
	
		
	//RootViewController *rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
	
	//[appDelegate.navigationController popViewControllerAnimated:YES];
	//[rootViewController release];
	
}


#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	//NSLog(@"Objects loaded");
	//[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
	//[[NSUserDefaults standardUserDefaults] synchronize];
	//NSLog(@"Loaded regions: %@", objects);
	
	[viewController loadObjectsFromDataStore];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
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
	self.regionName = nil;
}


- (void)dealloc {
	[item release];
	[parent release];
	[regionName release];
	[navigationController release];
	[viewController release];
    [super dealloc];
}



@end
