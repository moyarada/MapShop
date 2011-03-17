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
@dynamic website;
@dynamic phone;
@dynamic address;
@dynamic sync, upd, del;
@dynamic area;

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"id",
			@"name", @"name",
			@"comment", @"comment",
			@"area_id",@"area_id",
            @"website",@"website",
            @"phone",@"phone",
            @"address",@"address",
            @"del",@"del",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"id";
}

+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings { 
   return [NSDictionary dictionaryWithObject:@"area_id" forKey:@"area"]; 
} 

+ (NSString*) path {
    return @"/shops.json";
}

@end
