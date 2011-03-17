// 
//  SPoint.m
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SPoint.h"


@implementation SPoint 


@dynamic id;
@dynamic name;
@dynamic comment;
@dynamic altitude;
@dynamic longitude;
@dynamic latitude;
@dynamic shop_id;
@dynamic sync, upd, del;
@dynamic shop;

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
            @"del",@"del",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"id";
}

+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings { 
    return [NSDictionary dictionaryWithObject:@"shop_id" forKey:@"shop"]; 
} 

+ (NSString*) path {
    return @"/points.json";
}


@end
