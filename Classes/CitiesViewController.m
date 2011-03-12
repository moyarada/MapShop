    //
//  CitiesViewController.m
//  MapShop
//
//  Created by Mike Bevz on 08/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CitiesViewController.h"
#import "AreasViewController.h"

@implementation CitiesViewController

- (void) setOptions {
	self.currentItem = [City object];
	self.entityName = @"City";
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        NSArray* record = [_items objectAtIndex:indexPath.row];
		City* region = [City objectWithPrimaryKeyValue:[record id]];
		
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
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"region=%@", parentItem];
	[request setPredicate:predicate];
	
	_items = [[[[currentItem class] objectsWithFetchRequest:request] mutableCopy] retain];
	NSLog(@" Items = %@", _items);
	
	
}

- (void)loadData {
	//NSLog(@"Loading data");
	RKObjectManager* objectManager = [RKObjectManager sharedManager];
	NSString* path = [NSString stringWithFormat:@"/regions/%@/cities.json", parentId];
	[[objectManager loadObjectsAtResourcePath:path objectClass:[currentItem class] delegate:self] retain];
	
	NSLog(@"Loading data");
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger)section {
	return [NSString stringWithFormat:@"Cities"];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	AreasViewController* genericViewController = [[AreasViewController alloc] initWithNibName:nil bundle:nil];
	City* record = [_items objectAtIndex:indexPath.row];//[City objectWithPrimaryKeyValue:[[_items objectAtIndex:indexPath.row] id]];
	genericViewController.parentItem = record;
	genericViewController.parentId = [record id];
	
	genericViewController.navigationController = self.navigationController;
	genericViewController.title = [record name];
	
	[self.navigationController pushViewController:genericViewController animated:YES];
	
	[genericViewController release];
	
	
}

@end
