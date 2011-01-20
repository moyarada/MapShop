//
//  ShopDetailedViewController.m
//  MapShop
//
//  Created by Mike Bevz on 19/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShopDetailedViewController.h"
#import "ShopPointsViewController.h"
#import "ShopCategoriesViewController.h"

@implementation ShopDetailedViewController

@synthesize currentShop, commentField,
			fetchedResultsController=fetchedResultsController_, 
			managedObjectContext=managedObjectContext_,
			tabBar;


#pragma mark -
#pragma mark App life cycle
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		
		
		
		
    }
    return self;
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = [currentShop valueForKey:@"name"];
	
	tabBar.selectedItem = [tabBar.items objectAtIndex:0];
	
	//[self.view addSubview:tabBarController.view];
	
	/*
	 
	tabBarController = [[UITabBarController alloc] init];


	
	NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:2];
	
	ShopPointsViewController *shopPointsViewController = [[ShopPointsViewController alloc] initWithStyle:UITableViewStylePlain];
	shopPointsViewController.currentShop = currentShop;
	shopPointsViewController.managedObjectContext = self.managedObjectContext;
	shopPointsViewController.navigationItemDelegate = self.navigationItem;
	shopPointsViewController.navigationController = self.navigationController;
	shopPointsViewController.tabBarItem.title = @"Points";
	shopPointsViewController.title = @"Points";
	
	[localViewControllersArray addObject:shopPointsViewController];
		
	
	
	
	ShopCategoriesViewController *shopCategoriesViewController = [[ShopCategoriesViewController alloc] initWithStyle:UITableViewStylePlain];
	
	shopCategoriesViewController.currentShop = currentShop;
	shopCategoriesViewController.managedObjectContext = self.managedObjectContext;
	shopCategoriesViewController.tabBarItem.title = @"Categories";
	shopCategoriesViewController.title = @"Categories";
	
	[localViewControllersArray addObject:shopCategoriesViewController];
	[shopCategoriesViewController release];
	
	//tabBarController.viewControllers = localViewControllersArray;
	[tabBarController setViewControllers:localViewControllersArray animated:YES];
	
	tabBarController.view.autoresizingMask==(UIViewAutoresizingFlexibleHeight);
	
	
	

	
	[self.view addSubview:shopPointsViewController.view]; 
	 
	
	
	[shopPointsViewController release];

	*/
	
}


#pragma mark -
#pragma mark Screen orientation
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Tab Bar management

- (void)tabBar:(UITabBar *)tb didSelectItem:(UITabBarItem *)item {
    NSLog(@"item tag: %d", item.tag);
	
    if (item.tag == 1) {
		
		if (shopPointsViewController) {
			[self.view bringSubviewToFront:shopPointsViewController.view];
			[self.view bringSubviewToFront:tabBar];
		} else {
			[self loadShopPointsView];
		}
		
        
    }
    else if (item.tag == 2) {
		if (shopCategoriesViewController) {
			[self.view bringSubviewToFront:shopCategoriesViewController.view];
			[self.view bringSubviewToFront:tabBar];
		} else {
			[self loadShopCategories];
		}
    }
    else {
        if (shopPointsViewController) {
			[self.view bringSubviewToFront:shopPointsViewController.view];
			[self.view bringSubviewToFront:tabBar];
		} else {
			[self loadShopPointsView];
		}
    }
	
}

- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray *)items {
	
	
}

- (void)loadShopPointsView {
	shopPointsViewController = [[ShopPointsViewController alloc] initWithStyle:UITableViewStylePlain];
	shopPointsViewController.currentShop = currentShop;
	shopPointsViewController.managedObjectContext = self.managedObjectContext;
	shopPointsViewController.navigationItemDelegate = self.navigationItem;
	shopPointsViewController.navigationController = self.navigationController;
	shopPointsViewController.tabBarItem.title = @"Points";
	shopPointsViewController.title = @"Points";
	
	[self.view addSubview:shopPointsViewController.view];
	[self.view addSubview:tabBar];
}

- (void)loadShopCategories {
	shopCategoriesViewController = [[ShopCategoriesViewController alloc] initWithStyle:UITableViewStylePlain];
	
	shopCategoriesViewController.currentShop = currentShop;
	shopCategoriesViewController.managedObjectContext = self.managedObjectContext;
	shopCategoriesViewController.tabBarItem.title = @"Categories";
	shopCategoriesViewController.title = @"Categories";
	
	[self.view addSubview:shopCategoriesViewController.view];
	[self.view addSubview:tabBar];
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[commentField release];
	[currentShop release];
	[tabBar release];
    [super dealloc];
}


@end
