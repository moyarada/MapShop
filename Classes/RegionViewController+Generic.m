    //
//  RegionViewController+Generic.m
//  MapShop
//
//  Created by Mike Bevz on 08/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegionViewController+Generic.h"
#import "Region.h"
#import "CitiesViewController.h"

@implementation RegionViewController_Generic



- (void) setOptions {
	//self.currentItem = [Region object];
	self.entityName = @"Region";
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
	self.navigationItem.rightBarButtonItem = addButton;
	
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonWasPressed:)];
	self.navigationItem.leftBarButtonItem = refreshButton;
	
	//[self loadObjectsFromDataStore];
	//[self loadData];
	
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		
        NSArray* record = [_items objectAtIndex:indexPath.row];
		Region* region = [Region objectWithPrimaryKeyValue:[record id]];
		
		[_items removeObjectAtIndex:indexPath.row];
		[_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		
		NSLog(@"Delete %@", region.name);
		[[RKObjectManager sharedManager] deleteObject:region delegate:self];
		
		
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
		//[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }   
}

- (void)loadObjectsFromDataStore {
	[_items release];
	NSLog(@"Loading data from Store");
	NSFetchRequest* request = [Region fetchRequest];
	NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	
	_items = [[[Region objectsWithFetchRequest:request] mutableCopy] retain];
	//NSLog(@" Items = %@", _items);
	
	
}


- (void)loadData {
	//NSLog(@"Loading data");
	//RKObjectManager* objectManager = [RKObjectManager sharedManager];
	//NSString* path = [NSString stringWithFormat:@"/regions.json"];
	//[[objectManager loadObjectsAtResourcePath:@"/regions.json" objectClass:[Region class] delegate:self] retain];
	
	NSLog(@"Loading data");
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	CitiesViewController* genericViewController = [[CitiesViewController alloc] initWithNibName:nil bundle:nil];
	Region* record = [_items objectAtIndex:indexPath.row];  // [Region objectWithPrimaryKeyValue:[[_items objectAtIndex:indexPath.row] id]];
	genericViewController.parentItem = record;
	genericViewController.parentId = [record id];
	
	genericViewController.navigationController = self.navigationController;
	genericViewController.title = [record name];
	
	[self.navigationController pushViewController:genericViewController animated:YES];
	
	[genericViewController release];
	
	
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger)section {
	return [NSString stringWithFormat:@"Regions"];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
