//
//  AbtsractModel.h
//  MapShop
//
//  Created by Mike Bevz on 17/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>


@interface AbstractModel : RKManagedObject <RKObjectLoaderDelegate> {
    UIViewController *_delegate;
}

@property (nonatomic, retain) UIViewController *_delegate;

+(NSString *) path;
+(void)update: (id)delegate;

@end
