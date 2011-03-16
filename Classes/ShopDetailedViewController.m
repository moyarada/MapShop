//
//  ShopDetailedViewController.m
//  MapShop
//
//  Created by Mike Bevz on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShopDetailedViewController.h"


@implementation ShopDetailedViewController

@synthesize currentShop,
            tabBarController;


#pragma mark -
#pragma mark App life cycle
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [currentShop name];
    
    shopDetailsTabViewController = [[ShopDetailsTabViewController alloc] initWithNibName:@"ShopDetailsTabViewController" bundle:[NSBundle mainBundle]];
	shopDetailsTabViewController.currentShop = currentShop;
    shopDetailsTabViewController.title = @"Details";
    shopDetailsTabViewController.tabBarItem.image = [UIImage imageNamed:@"172-pricetag"];
    
    addPointViewController = [[AddPointViewController alloc] initWithNibName:@"AddPointViewController" bundle:[NSBundle mainBundle]];
    addPointViewController.parent = currentShop;
    addPointViewController.title = @"Location";
    addPointViewController.tabBarItem.image = [UIImage imageNamed:@"193-location-arrow"];
    
    NSMutableArray *viewControllers = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
    
    [viewControllers addObject:shopDetailsTabViewController];
    [viewControllers addObject:addPointViewController];
    
    [tabBarController setViewControllers:viewControllers animated:YES];
	tabBarController.delegate = self;
    
    //[viewControllers release];
    [shopDetailsTabViewController release];
    [addPointViewController release];
    
    [self.view addSubview:tabBarController.view];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    

}

- (BOOL)tabBarController:(UITabBarController *)tbController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[AddPointViewController class]]) {
        UIBarButtonItem *editButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:viewController action:@selector(savePoints)] autorelease];
        self.navigationItem.rightBarButtonItem = editButton;
        
    } else if ([viewController isKindOfClass:[ShopDetailsTabViewController class]]) {
        UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:viewController action:@selector(updateShop)] autorelease];
        self.navigationItem.rightBarButtonItem = saveButton;
    }
    
    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.tabBarController = nil;
    self.currentShop = nil;
}

- (void)dealloc {
	[currentShop release];
	[super dealloc];
}

#pragma mark -
#pragma mark Actions 

- (void)savePoint {
	NSLog(@"Saving Point");
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Screen orientation
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientatio {
    return YES;
}

#pragma mark -
#pragma mark Tab Bar management
/*
- (void)tabBar:(UITabBar *)tb didSelectItem:(UITabBarItem *)item {
    NSLog(@"item tag: %d", item.tag);
	
	if (item.tag == 0) {
		//if (shopDetailsTabViewController) {
            UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:shopDetailsTabViewController action:@selector(updateShop)] autorelease];
            self.navigationItem.rightBarButtonItem = saveButton;
            
			//[self.view bringSubviewToFront:scrollView];
			//[self.view bringSubviewToFront:tabBar];
		//} else {
			//[self loadShopDetailsTabViewController];
		//}
	} else if (item.tag == 1) {

        //if (addPointViewController) {
            
            UIBarButtonItem *editButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:addPointViewController action:@selector(savePoints)] autorelease];
            self.navigationItem.rightBarButtonItem = editButton;
            
            //[self.view bringSubviewToFront:addPointViewController.view];
            //[self.view bringSubviewToFront:tabBar];
       // } else {
            //[self loadAddPointView];
        //}
		
        
    }
    else if (item.tag == 2) {
		if (shopCategoriesViewController) {
			//[self.view bringSubviewToFront:shopCategoriesViewController.view];
			//[self.view bringSubviewToFront:tabBar];
		} else {
			//[self loadShopCategories];
		}
        
    }
    else {
        //if (shopDetailsTabViewController) {
            UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:shopDetailsTabViewController action:@selector(updateShop)] autorelease];
            self.navigationItem.rightBarButtonItem = saveButton;
			//[self.view bringSubviewToFront:scrollView];
			//[self.view bringSubviewToFront:tabBar];
		//} else {
			//[self loadShopDetailsTabViewController];
		//}
    }
	
}

// Sent to the delegate after the customizing modal view is displayed.
- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray *)items {
	NSLog(@"Did begin");
	
}

// Sent to the delegate after the customizing modal view is dismissed.
- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray *)items changed:(BOOL)changed {
	NSLog(@"Did end");
}

// Sent to the delegate before the customizing modal view is displayed.
- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray *)items {
	NSLog(@"Will begin");
}

// Sent to the delegate before the customizing modal view is dismissed.
- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray *)items changed:(BOOL)changed {
	NSLog(@"Will End");
}

- (void)loadShopDetailsTabViewController {
	
	shopDetailsTabViewController = [[ShopDetailsTabViewController alloc] initWithNibName:@"ShopDetailsTabViewController" bundle:[NSBundle mainBundle]];
	shopDetailsTabViewController.currentShop = currentShop;
	shopDetailsTabViewController.navigationItem = self.navigationItem;
    //shopDetailsTabViewController.navigationController = self.navigationController;

	CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	self.scrollView = [[[UIScrollView alloc] initWithFrame:frame] autorelease];
	//scroll.contentInset=UIEdgeInsetsMake(64.0,0.0,44.0,0.0);
	//scrollView.scrollIndicatorInsets=UIEdgeInsetsMake(64.0,0.0,44.0,0.0);
	self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, shopDetailsTabViewController.view.frame.size.height);
	self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

	[self.scrollView addSubview:shopDetailsTabViewController.view];
	[self.view addSubview:self.scrollView];
	[self.view addSubview:tabBar];
}


- (void)loadShopPointsView {
	
	
	shopPointsViewController = [[ShopPointsViewController alloc] initWithNibName:nil bundle:nil];
	shopPointsViewController.parentItem = currentShop;
	shopPointsViewController.parentId = [currentShop id];
	shopPointsViewController.navigationItem = self.navigationItem;
	shopPointsViewController.title = [currentShop name];
	shopPointsViewController.navigationController = self.navigationController;
	
	[self.view addSubview:shopPointsViewController.view];
	[self.view addSubview:tabBar];
	 
}

- (void)loadAddPointView {
    addPointViewController = [[AddPointViewController alloc] initWithNibName:@"AddPointViewController" bundle:[NSBundle mainBundle]];
    addPointViewController.parent = currentShop;
    //addPointViewController.parentId = [currentShop id];
    //addPointViewController.navigationController = self.navigationController;
    //addPointViewController.navItem = self.navigationItem;
    addPointViewController.title = [currentShop name];
    addPointViewController.viewController = self;
    
    UIBarButtonItem *editButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:addPointViewController action:@selector(savePoints)] autorelease];
    self.navigationItem.rightBarButtonItem = editButton;
    
    [self.view addSubview:addPointViewController.view];
    [self.view addSubview:tabBar];
    
}

- (void)loadShopCategories {
	
	shopCategoriesViewController = [[ShopCategoriesViewController alloc] initWithStyle:UITableViewStylePlain];
	
	shopCategoriesViewController.currentShop = currentShop;
	//shopCategoriesViewController.managedObjectContext = self.managedObjectContext;
	shopCategoriesViewController.tabBarItem.title = @"Categories";
	shopCategoriesViewController.title = @"Categories";
	
	[self.view addSubview:shopCategoriesViewController.view];
	[self.view addSubview:tabBar];
}
 */


@end