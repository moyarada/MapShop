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
#import "City.h";
#import "Area.h"
#import "Shop.h"
#import "SPoint.h"


@implementation AddRegionController

@dynamic regionName, submitBtn;
@synthesize item, parent, navigationController, parentId;

#pragma mark -
#pragma mark App life cycle


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"New item";
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	
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
		
		[[RKObjectManager sharedManager] postObject:region delegate:self]; 
		
	}	
	
	if (item == @"City") {
	//	cities *model = (cities *)[NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:context];
		
		
		City* city = [City object];
		city.name = regionName.text;
		city.comment = @"Some comment";
		city.region_id = self.parentId;
		
		[[RKObjectManager sharedManager] postObject:city delegate:self]; 

	}
	
	if (item == @"Area") {
		Area* area = [Area object];
		area.name = regionName.text;
		area.comment = @"Some comment";
		area.city_id = self.parentId;
		
		[[RKObjectManager sharedManager] postObject:area delegate:self]; 
		
	}
	
	if (item == @"Shop") {
	//	Shop *model = (Shop *)[NSEntityDescription insertNewObjectForEntityForName:@"Shop" inManagedObjectContext:context];
		
	//	[model setName:regionName.text];
	//	[model setArea:(Area *)parent];
	}
	
	if (item == @"SPoint") {
	//	SPoint *model = (SPoint *)[NSEntityDescription insertNewObjectForEntityForName:@"SPoint" inManagedObjectContext:context];
		
	//	[model setName:regionName.text];
	//	[model setShop:(Shop *) parent];
		
	}
	
	regionName.text = @"";
	
		
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
	[self.navigationController popViewControllerAnimated:YES];
	
	
	//[self loadObjectsFromDataStore];
	//[_tableView reloadData];
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
	self.submitBtn = nil;
	self.regionName = nil;
}


- (void)dealloc {
	[item release];
	[parent release];
	[regionName release];
	[submitBtn release];
	[navigationController release];
    [super dealloc];
}



@end
