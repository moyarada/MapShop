// 
//  cities.m
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "City.h"

//#import "Area.h"
#import "Region.h"

@implementation City 

@dynamic id;
@dynamic name;
@dynamic region_id;
@dynamic comment;
@dynamic sync, upd, del;
@dynamic region;

#pragma mark RKObjectMappable methods

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"id",
			@"name", @"name",
			@"comment", @"comment",
			@"region_id",@"region_id",
            @"del", @"del",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"id";
}

+ (NSDictionary*)elementToRelationshipMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"region", @"region",
			nil];
}

+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings { 
    return [NSDictionary dictionaryWithObject:@"region_id" forKey:@"region"]; 
} 

+ (NSString*) path {
    return @"/cities.json";
}

@end
