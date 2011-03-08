//
//  CitiesViewController.h
//  MapShop
//
//  Created by Mike Bevz on 18/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "AreasViewController.h"

@interface CitiesViewController : UITableViewController <RKObjectLoaderDelegate> {

@private 
	NSArray *currentRegion;
	AreasViewController *areasViewController;
	UINavigationController *navigationController;
	NSArray* cities;
}

@property (nonatomic, retain) NSArray *currentRegion;
@property (nonatomic, retain) UINavigationController *navigationController;

- (void)loadObjectsFromDataStore;

@end
