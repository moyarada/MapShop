//
//  Area.h
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "City.h"

@interface Area :  RKManagedObject  
{
}

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * city_id;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * sync;
@property (nonatomic, retain) NSNumber * upd;
@property (nonatomic, retain) NSNumber * del;
@property (nonatomic, retain) City * city;


@end

