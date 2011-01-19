//
//  ShopsViewController.h
//  MapShop
//
//  Created by Mike Bevz on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShopsViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	NSManagedObject *currentArea;
	//ShopsViewController *shopsViewController;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObject *currentArea;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
