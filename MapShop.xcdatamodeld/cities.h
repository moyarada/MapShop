//
//  cities.h
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Area;
@class regions;

@interface cities :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) regions * region;
@property (nonatomic, retain) NSSet* areas;

@end


@interface cities (CoreDataGeneratedAccessors)
- (void)addAreasObject:(Area *)value;
- (void)removeAreasObject:(Area *)value;
- (void)addAreas:(NSSet *)value;
- (void)removeAreas:(NSSet *)value;

@end

