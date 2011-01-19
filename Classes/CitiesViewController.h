//
//  CitiesViewController.h
//  MapShop
//
//  Created by Mike Bevz on 18/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreasViewController.h"


@interface CitiesViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

@private 
	NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	NSManagedObject *currentRegion;
	AreasViewController *areasViewController;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObject *currentRegion;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
