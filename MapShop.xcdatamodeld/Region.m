// 
//  regions.m
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Region.h"

@implementation Region 

@dynamic name;
@dynamic id;
//@dynamic cities;

#pragma mark RKObjectMappable methods

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"id",
			@"name", @"name",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"id";
}


@end
