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

@synthesize currentShop,
			tabBar, scrollView;


#pragma mark -
#pragma mark App life cycle
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		
		
		
    }
    return self;
}

- (void)savePoint {
	NSLog(@"Saving Point");
	
    
    
    
    
	[self.navigationController popViewControllerAnimated:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = [currentShop name];
	
	
	
	tabBar.selectedItem = [tabBar.items objectAtIndex:0];
	if (!shopDetailsTabViewController) {
		[self loadShopDetailsTabViewController];
	}
	
	
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
	
	if (item.tag == 0) {
		if (shopDetailsTabViewController) {
            UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:shopDetailsTabViewController action:@selector(updateShop)] autorelease];
            self.navigationItem.rightBarButtonItem = saveButton;
			[self.view bringSubviewToFront:scrollView];
			[self.view bringSubviewToFront:tabBar];
		} else {
			[self loadShopDetailsTabViewController];
		}
	} else if (item.tag == 1) {
		
		if (shopPointsViewController) {
            
            UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:shopPointsViewController action:@selector(addNewItem)] autorelease];
            self.navigationItem.rightBarButtonItem = addButton;
            
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
			[self.scrollView bringSubviewToFront:shopPointsViewController.view];
			[self.view bringSubviewToFront:tabBar];
		} else {
			[self loadShopPointsView];
		}
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
	self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
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

- (void)loadShopCategories {
	/*
	shopCategoriesViewController = [[ShopCategoriesViewController alloc] initWithStyle:UITableViewStylePlain];
	
	shopCategoriesViewController.currentShop = currentShop;
	//shopCategoriesViewController.managedObjectContext = self.managedObjectContext;
	shopCategoriesViewController.tabBarItem.title = @"Categories";
	shopCategoriesViewController.title = @"Categories";
	
	[self.view addSubview:shopCategoriesViewController.view];
	[self.view addSubview:tabBar];*/
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
	self.tabBar = nil;
	shopCategoriesViewController = nil;
	shopPointsViewController = nil;
	shopDetailsTabViewController = nil;
}


- (void)dealloc {
	[shopPointsViewController release];
	[shopCategoriesViewController release];
	[shopDetailsTabViewController release];
	[currentShop release];
	[tabBar release];
	[scrollView release];
	[super dealloc];
}


@end
