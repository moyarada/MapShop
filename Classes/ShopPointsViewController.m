//
//  ShopPointsViewController.m
//  MapShop
//
//  Created by Mike Bevz on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShopPointsViewController.h"
#import "AddPointViewController.h"
#import "SPoint.h"

@implementation ShopPointsViewController

@synthesize navigationItem;

- (void) setOptions {
	self.currentItem = [SPoint object];
	self.entityName = @"SPoint";
}


#pragma mark -
#pragma mark Actions

- (void)addNewItem {
	AddPointViewController *addPointViewController = [[AddPointViewController alloc] initWithNibName:@"AddPointViewController" bundle:[NSBundle mainBundle]];
	//addRegionController.item = self.entityName;
	//if ([self parentId]) {
	//	addRegionController.parentId = self.parentId;
	//}
	
	//addRegionController.viewController = self;
	
	addPointViewController.navItem = self.navigationItem;
	addPointViewController.navigationController = self.navigationController;
	[self.navigationController pushViewController:addPointViewController animated:YES];
	
	[addPointViewController release];
}

#pragma mark -
#pragma mark App life cycle


- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
	self.navigationItem.rightBarButtonItem = addButton;
	
	
	
	self.parentId = [parentItem id];
	//[self loadData];
	
}



#pragma mark -
#pragma mark RKObjectLoaderDelegate

- (void)loadObjectsFromDataStore {
	[_items release];
	NSLog(@"Loading data from Store");
	NSFetchRequest* request = [[currentItem class] fetchRequest];
	NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"shop_id=%@", parentId];
	[request setPredicate:predicate];
	
	_items = [[[[currentItem class] objectsWithFetchRequest:request] mutableCopy] retain];
	NSLog(@" Items = %@", _items);
	
	
}

- (void)loadData {
	//NSLog(@"Loading data");
	RKObjectManager* objectManager = [RKObjectManager sharedManager];
	NSString* path = [NSString stringWithFormat:@"/shops/%@/points.json", parentId];
	[[objectManager loadObjectsAtResourcePath:path objectClass:[currentItem class] delegate:self] retain];
	
	NSLog(@"Loading data");
}

#pragma mark -
#pragma mark Table view delegate

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        NSArray* record = [_items objectAtIndex:indexPath.row];
		SPoint* region = [SPoint objectWithPrimaryKeyValue:[record id]];
		
		[_items removeObjectAtIndex:indexPath.row];
		[_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		NSLog(@"Delete %@", region.name);
		[[RKObjectManager sharedManager] deleteObject:region delegate:self];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	ShopsViewController* genericViewController = [[ShopsViewController alloc] initWithNibName:nil bundle:nil];
	Area* record = [Area objectWithPrimaryKeyValue:[[_items objectAtIndex:indexPath.row] id]];
	genericViewController.parentItem = record;
	genericViewController.parentId = [record id];
	
	//genericViewController.navigationController = self.navigationController;
	genericViewController.title = [record name];
	
	[self.navigationController pushViewController:genericViewController animated:YES];
	
	[genericViewController release];
	*/
	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger)section {
	return [NSString stringWithFormat:@"Points"];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[navigationItem release];	
    [super dealloc];
}



@end

