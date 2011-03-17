//
//  ShopDetailedViewController.h
//  MapShop
//
//  Created by Mike Bevz on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/CoreData/CoreData.h>
//#import "ShopPointsViewController.h"
//#import "ShopCategoriesViewController.h"
#import "ShopDetailsTabViewController.h"
#import "Shop.h"
#import "AddPointViewController.h"

@interface ShopDetailedViewController : UIViewController <UITabBarControllerDelegate> {
	Shop *currentShop;

    UITabBarController *tabBarController;

	//ShopDetailsTabViewController *shopDetailsTabViewController;
    //AddPointViewController *addPointViewController;    
}

@property (nonatomic, retain) Shop *currentShop;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;


@end
