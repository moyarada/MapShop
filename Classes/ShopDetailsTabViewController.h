//
//  ShopDetailsTabViewController.h
//  MapShop
//
//  Created by Mike Bevz on 08/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"


@interface ShopDetailsTabViewController : UIViewController <RKObjectLoaderDelegate> {
	
	Shop *currentShop;
    UINavigationItem *navigationItem;
}

@property (nonatomic, retain) IBOutlet UIImageView *thumb;
@property (nonatomic, retain) IBOutlet UITextView *address;
@property (nonatomic, retain) IBOutlet UITextField *shopName;
@property (nonatomic, retain) IBOutlet UITextField *website;
@property (nonatomic, retain) IBOutlet UITextField *phone;
@property (nonatomic, retain) IBOutlet UIButton *addPhotoBtn;
@property (nonatomic, retain) Shop *currentShop;
@property (nonatomic, retain) UINavigationItem *navigationItem;
@property (nonatomic, retain) UINavigationController *navigationController;

- (void) updateShop;
- (void) resignFirstResponders;
@end
