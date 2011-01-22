//
//  ShopDetailedViewController.h
//  MapShop
//
//  Created by Mike Bevz on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopPointsViewController.h"
#import "ShopCategoriesViewController.h"

@interface ShopDetailedViewController : UIViewController <UITabBarDelegate> {
	NSManagedObject *currentShop;
	//UIWebView *categories;
	//UIWebView *points;
	//UIButton *addCategoryBtn;
	//UIButton *addPointBtn;
	UITabBar *tabBar;
	
	NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	
	ShopPointsViewController *shopPointsViewController;
	ShopCategoriesViewController *shopCategoriesViewController;
}

@property (nonatomic, retain) NSManagedObject *currentShop;

@property (nonatomic, retain) IBOutlet UITabBar *tabBar;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)loadShopPointsView;
- (void)loadShopCategories;



@end
