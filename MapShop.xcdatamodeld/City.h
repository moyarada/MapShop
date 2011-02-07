//
//  cities.h
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "Region.h"
//@class Area;
//@class regions;

@interface City :  RKManagedObject   
{

}

@property (nonatomic, retain) NSNumber* id;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) Region* region;
//@property (nonatomic, retain) NSSet* areas;

@end



