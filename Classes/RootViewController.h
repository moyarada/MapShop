//
//  RootViewController.h
//  MapShop
//
//  Created by Mike Bevz on 17/01/11.
//  Copyright 2011 AndAnts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitiesViewController.h"


@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSMutableArray *regionsArray;
	@private 
	NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	CitiesViewController *cityViewController;
	UINavigationController *navigationController;
	
}

//@property (nonatomic, retain) NSMutableArray *regions;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) IBOutlet CitiesViewController *cityViewController;
@property (nonatomic, retain) UINavigationController *navigationController;



@end
