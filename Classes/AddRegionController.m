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
@synthesize item, parent;

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
	
	//MapShopAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	//NSManagedObjectContext *context = [appDelegate managedObjectContext];
	
	//NSManagedObject *newRegion;
	//newRegion = [NSEntityDescription insertNewObjectForEntityForName:@"regions" inManagedObjectContext:context];
	//[newRegion setValue:regionName.text forKey:@"name"];
	if (item == @"Region") {
	//	regions *model = (regions *)[NSEntityDescription insertNewObjectForEntityForName:item inManagedObjectContext:context];
	//	[model setName:regionName.text];
	}	
	
	if (item == @"City") {
	//	cities *model = (cities *)[NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:context];
		
	//	[model setName: regionName.text];
	//	[model setRegion: (regions *)parent];
		//(regions*)[parent addCitiesObject: model];
		//regions *regs = (regions *)[NSEntityDescription entityForName:parent inManagedObjectContext:context];
		//[model regions:regs];
	}
	
	if (item == @"Area") {
	//	Area *model = (Area *)[NSEntityDescription insertNewObjectForEntityForName:@"Area" inManagedObjectContext:context];
		
	//	[model setName:regionName.text];
	//	[model setCity:(cities *)parent];
		
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
	
	//NSError *error;
	
	//if (![context save:&error]) {
	//	NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
	//}
	
	//RootViewController *rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
	
	//[appDelegate.navigationController popViewControllerAnimated:YES];
	//[rootViewController release];
	
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
    [super dealloc];
}



@end
