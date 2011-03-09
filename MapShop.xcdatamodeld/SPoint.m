// 
//  SPoint.m
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SPoint.h"


@implementation SPoint 

@dynamic longitude;
@dynamic id;
@dynamic latitude;
@dynamic comment;
@dynamic name;
@dynamic altitude;
@dynamic shop_id;


#pragma mark RKObjectMappable methods

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"id",
			@"name", @"name",
			@"comment", @"comment",
			@"shop_id",@"shop_id",
			@"altitude",@"altitude",
			@"longitude",@"longitude",
			@"latitude",@"latitude",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"id";
}


@end
