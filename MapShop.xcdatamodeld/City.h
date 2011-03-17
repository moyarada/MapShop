//
//  cities.h
//  MapShop
//
//  Created by Mike Bevz on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Region.h"
#import "AbstractModel.h"

@interface City :  AbstractModel   
{

}

@property (nonatomic, retain) NSNumber* id;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* comment;
@property (nonatomic, retain) NSNumber* region_id;
@property (nonatomic, retain) NSNumber * sync;
@property (nonatomic, retain) NSNumber * upd;
@property (nonatomic, retain) NSNumber * del;
@property (nonatomic, retain) Region * region;

@end



