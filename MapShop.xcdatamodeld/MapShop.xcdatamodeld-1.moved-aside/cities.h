//
//  cities.h
//  MapShop
//
//  Created by Mike Bevz on 18/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class regions;

@interface cities :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) regions * regions;

@end



