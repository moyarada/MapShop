//
//  ShopDetailedViewController.h
//  MapShop
//
//  Created by Mike Bevz on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "ShopPointsViewController.h"
#import "ShopCategoriesViewController.h"
#import "ShopDetailsTabViewController.h"
#import "Shop.h"


@interface ShopDetailedViewController : UIViewController <UITabBarDelegate> {
	Shop *currentShop;
	//UIWebView *categories;
	//UIWebView *points;
	//UIButton *addCategoryBtn;
	//UIButton *addPointBtn;
	UITabBar *tabBar;
	UIScrollView *scrollView;
	ShopPointsViewController *shopPointsViewController;
	ShopCategoriesViewController *shopCategoriesViewController;
	ShopDetailsTabViewController *shopDetailsTabViewController;
    UITextField *shopNameFld;
    
}

@property (nonatomic, retain) Shop *currentShop;
@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITabBar *tabBar;

- (void) loadShopPointsView;
- (void) loadShopCategories;
- (void) loadShopDetailsTabViewController;



@end
