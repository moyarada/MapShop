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
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark Actions

- (void)addNewItem {
	AddRegionController *addRegionController = [[AddRegionController alloc] initWithNibName:@"AddRegionController" bundle:[NSBundle mainBundle]];
	addRegionController.item = self.entityName;
	if ([self parentId]) {
		addRegionController.parentId = self.parentId;
	}
	
	addRegionController.navigationController = self.navigationController;
	
	[self.navigationController pushViewController:addRegionController animated:YES];

	[addRegionController release];
}



#pragma mark -
#pragma mark View lifecycle

-(void) loadView {
	[super loadView];
	
	[self setOptions];
	
	//self.title = @"Items";
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
	
	UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG.png"]];
	imageView.frame = CGRectOffset(imageView.frame, 0, -64);
	
	[self.view insertSubview:imageView atIndex:0];
	[imageView release];
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-64) style:UITableViewStylePlain];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
	
	_tableView.backgroundColor = [UIColor clearColor];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	MapShopAppDelegate *appDelegate = (MapShopAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.navigationController = [appDelegate navigationController];
	
	
}

- (void) setOptions {
	//self.currentItem = [Region object];
	//self.entityName = @"Region";
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
	self.navigationItem.rightBarButtonItem = addButton;
	
	[addButton release];
	
	
	//[self loadObjectsFromDataStore];
	[self loadData];
	
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
		cell.textLabel.font = [UIFont systemFontOfSize:14];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listbg.png"]];    
	}
    
	cell.textLabel.text = [[_items objectAtIndex:indexPath.row] name];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGSize size = [[[_items objectAtIndex:indexPath.row] name] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 9000)];
	return size.height + 10;
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
	[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	NSLog(@"Loaded items in generic: %@", objects);
	[self loadObjectsFromDataStore];
	[_tableView reloadData];
	
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
}

- (void)loadObjectsFromDataStore {
	[_items release];
	NSLog(@"Loading data from Store in generic");
	NSFetchRequest* request = [[currentItem class] fetchRequest];
	NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	
	//NSPredicate *predicate = [NSPredicate predicateWithFormat: @"region_id=%@", parentId];
	//[request setPredicate:predicate];
	
	_items = [[[currentItem class] objectsWithFetchRequest:request] retain];
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
	[self loadData];
}



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

- (void)viewDidUnload {
	[_items release];
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[_items release];
	[_tableView release];
	[parentItem release];
	[currentItem release];
	[parentId release];
    [super dealloc];
}


@end

