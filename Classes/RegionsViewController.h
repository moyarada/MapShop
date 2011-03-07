//
//  RegionsViewController.h
//  MapShop
//
//  Created by Mike Bevz on 06/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface RegionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate> {
	UITableView* _tableView;
	NSArray* _statuses;
	NSArray* currentRegion;
}

- (void)loadObjectsFromDataStore;
- (void)loadData;

@end
