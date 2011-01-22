//
//  AddPointViewController.h
//  MapShop
//
//  Created by Mike Bevz on 21/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AddPointViewController : UIViewController <CLLocationManagerDelegate> {
	UITextField *commentFld;
	UITextField *latFld;
	UITextField  *longFld;
	UITextField  *altFld;
	NSString *item;
	NSManagedObject *parent;
	CLLocationManager *locationManager;
	NSNumber *curLat;
	NSNumber *curLong;
	NSNumber *curAlt;
}

@property (nonatomic, retain) IBOutlet UITextField *commentFld;
@property (nonatomic, retain) IBOutlet UITextField *latFld;
@property (nonatomic, retain) IBOutlet UITextField  *longFld;
@property (nonatomic, retain) IBOutlet UITextField  *altFld;
@property (nonatomic, retain) NSString *item;
@property (nonatomic, retain) NSManagedObject *parent;

@end
