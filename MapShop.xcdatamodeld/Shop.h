//
//  Shop.h
//  MapShop
//
//  Created by Mike Bevz on 21/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Area;
@class Category;
@class SPoint;

@interface Shop :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSSet* points;
@property (nonatomic, retain) NSSet* categories;
@property (nonatomic, retain) Area * area;

@end


@interface Shop (CoreDataGeneratedAccessors)
- (void)addPointsObject:(SPoint *)value;
- (void)removePointsObject:(SPoint *)value;
- (void)addPoints:(NSSet *)value;
- (void)removePoints:(NSSet *)value;

- (void)addCategoriesObject:(Category *)value;
- (void)removeCategoriesObject:(Category *)value;
- (void)addCategories:(NSSet *)value;
- (void)removeCategories:(NSSet *)value;

@end

