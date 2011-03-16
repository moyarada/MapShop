//
//  ShopCategoriesViewController.h
//  MapShop
//
//  Created by Mike Bevz on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestKit/RestKit.h"
#import "RestKit/CoreData/CoreData.h"

@interface ShopCategoriesViewController : UITableViewController  {
	RKManagedObject *currentShop;
	//NSFetchedResultsController *fetchedResultsController_;
    //NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) RKManagedObject *currentShop;
//@property (nonatomic, retain) RKManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
