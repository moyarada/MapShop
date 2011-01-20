//
//  ShopCategoriesViewController.h
//  MapShop
//
//  Created by Mike Bevz on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShopCategoriesViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSManagedObject *currentShop;
	NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObject *currentShop;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
