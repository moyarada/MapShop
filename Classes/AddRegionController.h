//
//  AddRegionController.h
//  MapShop
//
//  Created by Mike Bevz on 17/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddRegionController : UIViewController {
	UITextField *regionName;
	UIButton *submitBtn;
	NSString *item;
	NSArray *parent;
}

@property (nonatomic, retain) IBOutlet UITextField *regionName;
@property (nonatomic, retain) IBOutlet UIButton *submitBtn;
@property (nonatomic, retain) NSString *item;
@property (nonatomic, retain) NSArray *parent;

-(IBAction)saveData;
@end
