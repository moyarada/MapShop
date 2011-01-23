//
//  regions.h
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class cities;

@interface regions :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSSet* cities;

@end


@interface regions (CoreDataGeneratedAccessors)
- (void)addCitiesObject:(cities *)value;
- (void)removeCitiesObject:(cities *)value;
- (void)addCities:(NSSet *)value;
- (void)removeCities:(NSSet *)value;

@end

