    //
//  AreasViewController.m
//  MapShop
//
//  Created by Mike Bevz on 08/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AreasViewController.h"
#import "Area.h"
#import "AddRegionController.h"
#import "ShopsViewController.h"

@implementation AreasViewController

- (void) setOptions {
	self.currentItem = [Area object];
	self.entityName = @"Area";
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        NSArray* record = [_items objectAtIndex:indexPath.row];
		Area* region = [Area objectWithPrimaryKeyValue:[record id]];
		
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
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(city=%@) AND (del == false)", parentItem];
	[request setPredicate:predicate];
    
	
	_items = [[[currentItem class] objectsWithFetchRequest:request] mutableCopy];
	NSLog(@" Items = %@", _items);
	
	
}

- (void)loadData {
	//NSLog(@"Loading data");
	RKObjectManager* objectManager = [RKObjectManager sharedManager];
	NSString* path = [NSString stringWithFormat:@"/cities/%@/areas.json", parentId];
	[objectManager loadObjectsAtResourcePath:path objectClass:[currentItem class] delegate:self];
	
	NSLog(@"Loading data");
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger)section {
	return [NSString stringWithFormat:@"Areas"];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	ShopsViewController* genericViewController = [[ShopsViewController alloc] initWithNibName:nil bundle:nil];
	Area* record = [_items objectAtIndex:indexPath.row];//[Area objectWithPrimaryKeyValue:[[_items objectAtIndex:indexPath.row] id]];
	genericViewController.parentItem = record;
	genericViewController.parentId = [record id];
	
	//genericViewController.navigationController = self.navigationController;
	genericViewController.title = [record name];
	
	[self.navigationController pushViewController:genericViewController animated:YES];
	
	[genericViewController release];
	
	
}

@end
