//
//  AbtsractModel.h
//  MapShop
//
//  Created by Mike Bevz on 17/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "GenericTableViewController.h"

@interface AbstractModel : RKManagedObject <RKObjectLoaderDelegate> {
    UIViewController *_delegate;
}

-(NSString *) path;
-(void)update: (UIViewController*)delegate;

@end
