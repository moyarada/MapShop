//
//  regions.h
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
//#import "cities.h"
//@class cities;

@interface Region :  RKManagedObject  
{
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* id;
//@property (nonatomic, retain) NSSet* cities;

@end
