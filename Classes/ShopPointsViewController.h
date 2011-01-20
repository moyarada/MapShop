//
//  ShopPointsViewController.h
//  MapShop
//
//  Created by Mike Bevz on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShopPointsViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSManagedObject *currentShop;
	NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	UINavigationItem *navigationItemDelegate;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) NSManagedObject *currentShop;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) UINavigationItem *navigationItemDelegate;
@property (nonatomic, retain) UINavigationController *navigationController;

- (void)addNewItem;

@end
