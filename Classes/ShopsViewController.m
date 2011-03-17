    //
//  ShopsViewController.m
//  MapShop
//
//  Created by Mike Bevz on 08/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShopsViewController.h"
#import "Shop.h"
#import "ShopDetailedViewController.h"

@implementation ShopsViewController

- (void) setOptions {
	self.currentItem = [Shop object];
	self.entityName = @"Shop";
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        NSArray* record = [_items objectAtIndex:indexPath.row];
		Shop* region = [Shop objectWithPrimaryKeyValue:[record id]];
		
		[_items removeObjectAtIndex:indexPath.row];
		[_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		NSLog(@"Delete %@", region.name);
		[[RKObjectManager sharedManager] deleteObject:region delegate:self];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}

- (void)loadObjectsFromDataStore {
	[_items release];
	NSLog(@"Loading data from Store");
	NSFetchRequest* request = [[currentItem class] fetchRequest];
	NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(area=%@) AND (del == false)", parentItem];
	[request setPredicate:predicate];
   
	
	_items = [[[currentItem class] objectsWithFetchRequest:request] mutableCopy];
	NSLog(@" Items = %@", _items);
	
	
}

- (void)loadData {
	//NSLog(@"Loading data");
	RKObjectManager* objectManager = [RKObjectManager sharedManager];
	NSString* path = [NSString stringWithFormat:@"/areas/%@/shops.json", parentId];
	[objectManager loadObjectsAtResourcePath:path objectClass:[currentItem class] delegate:self];
	
	NSLog(@"Loading data");
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger)section {
	return [NSString stringWithFormat:@"Shops"];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	
	ShopDetailedViewController* detailedViewController = [[ShopDetailedViewController alloc] initWithNibName:@"ShopDetailedViewController" bundle:[NSBundle mainBundle]];
    Shop * record = [_items objectAtIndex:indexPath.row];
    NSLog(@" %@", [_items objectAtIndex:indexPath.row]);
	
	detailedViewController.currentShop = record;
	
	[self.navigationController pushViewController:detailedViewController animated:YES];
	
	[detailedViewController release];
	
}



@end
