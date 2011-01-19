//
//  AreasViewController.h
//  MapShop
//
//  Created by Mike Bevz on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopsViewController.h"

@interface AreasViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	
	NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	NSManagedObject *currentCity;
	ShopsViewController *shopsViewController;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObject *currentCity;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
