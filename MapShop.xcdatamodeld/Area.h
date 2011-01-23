//
//  Area.h
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Shop;
@class cities;

@interface Area :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) cities * city;
@property (nonatomic, retain) NSSet* shops;

@end


@interface Area (CoreDataGeneratedAccessors)
- (void)addShopsObject:(Shop *)value;
- (void)removeShopsObject:(Shop *)value;
- (void)addShops:(NSSet *)value;
- (void)removeShops:(NSSet *)value;

@end

