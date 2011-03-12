//
//  Category.h
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Shop;

@interface Category :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSSet* shops;
@property (nonatomic, retain) NSNumber * sync;
@property (nonatomic, retain) NSNumber * upd;
@property (nonatomic, retain) NSNumber * del;

@end

