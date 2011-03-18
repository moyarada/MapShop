// 
//  regions.m
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Region.h"

@implementation Region 

@dynamic id;
@dynamic name;
@dynamic comment;
@dynamic sync, upd, del;
@dynamic cities;

#pragma mark RKObjectMappable methods

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"id",
			@"name", @"name",
			@"comment", @"comment",
            @"del",@"del",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"id";
}

/*
+ (NSDictionary*)elementToRelationshipMappings { 
    return [NSDictionary dictionaryWithKeysAndObjects: 
            @"cities", @"cities", 
            nil]; 
} */


+ (NSString*) path {
    return @"/regions.json";
}




@end
