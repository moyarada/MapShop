//
//  RegionsViewController.m
//  MapShop
//
//  Created by Mike Bevz on 06/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegionsViewController.h"
#import "Region.h"
#import "City.h"
#import "CitiesViewController.h"
#import "AddRegionController.h"
//#import "GenericTableViewController.h"
#import "CitiesViewController.h"

@implementation RegionsViewController



#pragma mark -
#pragma mark View lifecycle

-(void) loadView {
	[super loadView];
	
	self.title = @"Regions";
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
		
	
	

}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIBarButtonItem* reloadItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonWasPressed:)];
	[self.navigationItem setLeftBarButtonItem:reloadItem];
	[reloadItem release];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
	
	[self loadData];
	[self loadObjectsFromDataStore];
	
	
}


#pragma mark -
#pragma mark Actions

- (void)addNewItem {
	AddRegionController *addRegionController = [[AddRegionController alloc] initWithNibName:@"AddRegionController" bundle:[NSBundle mainBundle]];
	addRegionController.item = @"Region";
	addRegionController.navigationController = self.navigationController;
	
	[self.navigationController pushViewController:addRegionController animated:YES];
	
	[addRegionController release];
}


#pragma mark -
#pragma mark RestKit

- (void)loadObjectsFromDataStore {
	[_statuses release];
	NSLog(@"Loading data from Store");
	NSFetchRequest* request = [Region fetchRequest];
	NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	_statuses = [Region objectsWithFetchRequest:request];
	
}

#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	NSLog(@"Objects loaded");
	[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	NSLog(@"Loaded regions: %@", objects);
	[self loadObjectsFromDataStore];
	[_tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
}

- (void)loadData {
	NSLog(@"Loading data");
	RKObjectManager* objectManager = [RKObjectManager sharedManager];
	[objectManager loadObjectsAtResourcePath:@"/regions.json" objectClass:[Region class] delegate:self];
	NSLog(@"Loading data");
}

- (void)reloadButtonWasPressed:(id)sender {
	// Load the object model via RestKit
	NSLog(@"push the button");
	[self loadData];
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self loadObjectsFromDataStore];
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
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_statuses count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* reuseIdentifier = @"Regions Cell";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (nil == cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
		cell.textLabel.font = [UIFont systemFontOfSize:14];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listbg.png"]];
	}
	cell.textLabel.text = [[_statuses objectAtIndex:indexPath.row] name];
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSDate* lastUpdatedAt = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastUpdatedAt"];
	NSString* dateString = [NSDateFormatter localizedStringFromDate:lastUpdatedAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
	if (nil == dateString) {
		dateString = @"Never";
	}
	return [NSString stringWithFormat:@"Last Load: %@", dateString];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //
		NSArray* record = [_statuses objectAtIndex:indexPath.row];
		Region* region = [Region objectWithPrimaryKeyValue:[record id]];
		NSLog(@"Delete %@", region.name);
		[[RKObjectManager sharedManager] deleteObject:region delegate:self];
		//[_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



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
	
	//CitiesViewController *cityViewController = [[CitiesViewController alloc] initWithNibName:@"CitiesViewController" bundle:[NSBundle mainBundle]];
	CitiesViewController* genericViewController = [[CitiesViewController alloc] initWithNibName:nil bundle:nil];
	Region* myregion = [Region objectWithPrimaryKeyValue:[[_statuses objectAtIndex:indexPath.row] id]];
	genericViewController.parentItem = myregion;
	genericViewController.parentId = [myregion id];

	genericViewController.navigationController = self.navigationController;
	genericViewController.title = [myregion name];

	[self.navigationController pushViewController:genericViewController animated:YES];
	
	[genericViewController release];

	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGSize size = [[[_statuses objectAtIndex:indexPath.row] name] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 9000)];
	return size.height + 10;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[_statuses release];
}


- (void)dealloc {
	[_tableView release];
	[_statuses release];
    [super dealloc];
}


@end

