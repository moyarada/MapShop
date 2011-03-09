//
//  AddRegionController.h
//  MapShop
//
//  Created by Mike Bevz on 17/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "GenericTableViewController.h"


@interface AddRegionController : UIViewController <RKObjectLoaderDelegate>  {
	UITextField *regionName;
	NSString *item;
	RKManagedObject *parent;
	UINavigationController *navigationController;
	NSNumber *parentId;
	GenericTableViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UITextField *regionName;
@property (nonatomic, retain) NSString *item;
@property (nonatomic, retain) RKManagedObject *parent;
@property (nonatomic, retain) NSNumber *parentId;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) GenericTableViewController *viewController;



-(IBAction)saveData;
@end
