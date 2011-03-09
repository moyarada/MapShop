// 
//  Shop.m
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Shop.h"

#import "Area.h"
#import "Category.h"
#import "SPoint.h"

@implementation Shop 

@dynamic id;
@dynamic name;
@dynamic comment;
@dynamic area_id;

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"id",
			@"name", @"name",
			@"comment", @"comment",
			@"area_id",@"area_id",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"id";
}

@end
