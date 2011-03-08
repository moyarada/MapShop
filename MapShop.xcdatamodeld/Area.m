// 
//  Area.m
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Area.h"

#import "Shop.h"
#import "City.h"

@implementation Area 

@dynamic id;
@dynamic name;
@dynamic city_id;
@dynamic comment;

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"id",
			@"name", @"name",
			@"comment", @"comment",
			@"city_id",@"city_id",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"id";
}

@end
