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

#pragma mark RKObjectMappable methods

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"id",
			@"name", @"name",
			@"comment", @"comment",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"id";
}

@end
