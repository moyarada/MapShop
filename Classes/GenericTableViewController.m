//
//  GenericTableViewController.m
//  MapShop
//
//  Created by Mike Bevz on 07/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GenericTableViewController.h"
#import "AddRegionController.h"
#import "City.h"
#import "MapShopAppDelegate.h"

@implementation GenericTableViewController

@synthesize currentItem, parentItem;
@synthesize navigationController;
@synthesize parentId, entityName;



#pragma mark -
#pragma mark Actions

- (void)addNewItem {
	AddRegionController *addRegionController = [[AddRegionController alloc] initWithNibName:@"AddRegionController" bundle:[NSBundle mainBundle]];
	addRegionController.item = self.entityName;
	if ([self parentId]) {
		addRegionController.parentId = self.parentId;
	}
	
	addRegionController.viewController = self;
	addRegionController.parent = self.parentItem;
	addRegionController.navigationController = self.navigationController;
	
	[self.navigationController pushViewController:addRegionController animated:YES];

	[addRegionController release];
}



#pragma mark -
#pragma mark View lifecycle

-(void) loadView {
	[super loadView];
	
	MapShopAppDelegate *appDelegate = (MapShopAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.navigationController = [appDelegate navigationController];
	
	[self setOptions];

	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
	
	UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG.png"]];
	imageView.frame = CGRectOffset(imageView.frame, 0, -64);
	imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view insertSubview:imageView atIndex:0];
	[imageView release];

	
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
	_tableView.autoresizesSubviews = YES;
	_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
	
	_tableView.backgroundColor = [UIColor clearColor];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	
	
}

- (void) setOptions {
	//self.currentItem = [Region object];
	//self.entityName = @"Region";
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	
	[self loadObjectsFromDataStore];
}

- (void)viewDidUnload {
	_items = nil;
    parentItem = nil;
    currentItem = nil;
    entityName = nil;
    navigationController = nil;
    parentId = nil;    
    
    [super viewDidUnload];
}


- (void)dealloc {
	[_items release];
	[_tableView release];
	[parentItem release];
	[currentItem release];
	[parentId release];
    [entityName release];
    [navigationController release];
    [super dealloc];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[_tableView reloadData];
	//[self loadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
 */

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Remove";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_items count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* reuseIdentifier = [NSString stringWithFormat:@"%@ Cell", self.entityName];
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
		cell.textLabel.font = [UIFont systemFontOfSize:18];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listbg.png"]];    
	}
    
	cell.textLabel.text = [[_items objectAtIndex:indexPath.row] name];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGSize size = [[[_items objectAtIndex:indexPath.row] name] sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(300, 9000)];
	return size.height + 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger)section {
	return [NSString stringWithFormat:@"%@", self.entityName];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/







/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -
#pragma mark RestKit


#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	//NSLog(@"Objects loaded");
	//[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
	//[[NSUserDefaults standardUserDefaults] synchronize];
	//NSLog(@"Loaded items in generic: %@", objects);
    if ([objects count] > 0) {
        NSLog(@"Showing first object %@", [objects objectAtIndex:0]);
        NSObject *obj = [objects objectAtIndex:0];
        if (syncNow == YES) {
            if ([obj isKindOfClass:[Region class]]) {
                syncingEntity = @"City";
                [self syncData];
            } else if ([obj isKindOfClass:[City class]]) {
                syncingEntity = @"Area";
                [self syncData];
            } else if ([obj isKindOfClass:[Area class]]) {
                syncingEntity = @"Shop";
                [self syncData];
            } else if ([obj isKindOfClass:[Shop class]]) {
                syncingEntity = @"Point";
                [self syncData];
            } else if ([obj isKindOfClass:[SPoint class]]) {
                syncingEntity = nil;
                syncNow = NO;
                NSLog(@"Sync is finished");
            } 
        }
    }
    
    
    
	[self loadObjectsFromDataStore];
	[_tableView reloadData];
	
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
	
	[self loadObjectsFromDataStore];
	[_tableView reloadData];
	
}

- (void)loadObjectsFromDataStore {
	[_items release];
	NSLog(@"Loading data from Store in generic");
	NSFetchRequest* request = [[currentItem class] fetchRequest];
	NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	//[descriptor release];
    _items = (NSMutableArray*)[[[currentItem class] objectsWithFetchRequest:request] retain];
    //[request release];
	NSLog(@" Items in generic = %@", _items);
	
	
}

- (void)loadData {
	//NSLog(@"Loading data");
	//RKObjectManager* objectManager = [RKObjectManager sharedManager];
	//NSString* path = [NSString stringWithFormat:@"/regions/%@/cities.json", parentId];
	//[[objectManager loadObjectsAtResourcePath:path objectClass:[currentItem class] delegate:self] retain];

	
	//NSLog(@"Loading data");
}

- (void)reloadButtonWasPressed:(id)sender {
	// Load the object model via RestKit
	NSLog(@"push the button");
	//[self loadData];
    [self syncData];
}

#pragma mark -
#pragma mark Sync Data

- (void) syncData {
    NSLog(@"Sync data");
    syncNow = YES;
    
    //RKObjectManager* objectManager = [RKObjectManager sharedManager];
    if (syncingEntity == nil) {
        syncingEntity = @"Region";
    }
    
    //load all data
    if (syncingEntity == @"Region") {
        RKObjectManager* objectManager = [RKObjectManager sharedManager];
        NSString* path = [NSString stringWithFormat:@"/regions.json", parentId] ;
        [objectManager loadObjectsAtResourcePath:path objectClass:[Region class] delegate:self];
        //[path release];
    }
    
    if (syncingEntity == @"City") {
        RKObjectManager* objectManager = [RKObjectManager sharedManager];
        NSString* path = [NSString stringWithFormat:@"/cities.json", parentId];
        [objectManager loadObjectsAtResourcePath:path objectClass:[City class] delegate:self];
        //[path release];
    }
    
    if (syncingEntity == @"Area") {
        RKObjectManager* objectManager = [RKObjectManager sharedManager];
        NSString* path = [NSString stringWithFormat:@"/areas.json", parentId];
        [objectManager loadObjectsAtResourcePath:path objectClass:[Area class] delegate:self];
        //[path release];
    }
    
    if (syncingEntity == @"Shop") {
        RKObjectManager* objectManager = [RKObjectManager sharedManager];
        NSString* path = [NSString stringWithFormat:@"/shops.json", parentId];
        [objectManager loadObjectsAtResourcePath:path objectClass:[Shop class] delegate:self];
        //[path release];
    }
    
    if (syncingEntity == @"Point") {
        RKObjectManager* objectManager = [RKObjectManager sharedManager];
        NSString* path = [NSString stringWithFormat:@"/points.json", parentId];
        [objectManager loadObjectsAtResourcePath:path objectClass:[SPoint class] delegate:self];
        //[path release];
    }
    
    //1 push all changes to server
    //[self createNewRegions];
    
}

/*
- (void) createNewRegions {
    NSFetchRequest* request = [Region fetchRequest];
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"sync == true"];
	[request setPredicate:predicate];
	//[predicate release];
    
	NSMutableArray *regions = [[[Region objectsWithFetchRequest:request] mutableCopy] retain];
    
    if ([regions count] > 0) {
        for (Region *obj in regions) {
            NSLog(@"Creating a region: %@", [obj id]);
            [[RKObjectManager sharedManager] postObject:obj delegate:self]; 
        }
    }
    [regions release];
}

- (void) createNewCities {
    NSFetchRequest* request = [City fetchRequest];
	NSPredicate* predicate = [NSPredicate predicateWithFormat: @"sync == true"];
	[request setPredicate:predicate];
	
	NSMutableArray *items = [[[City objectsWithFetchRequest:request] mutableCopy] retain];
    
    if ([items count] > 0) {
        for (Region *obj in items) {
            NSLog(@"Creating a city: %@", [obj id]);
            [[RKObjectManager sharedManager] postObject:obj delegate:self]; 
        }
    }
    
    [items release];
}

*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}




@end

