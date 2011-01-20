//
//  SPoint.h
//  MapShop
//
//  Created by Mike Bevz on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Shop;

@interface SPoint :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) Shop * shop;

@end


