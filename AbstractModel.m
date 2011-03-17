//
//  AbtsractModel.m
//  MapShop
//
//  Created by Mike Bevz on 17/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AbstractModel.h"


@implementation AbstractModel

#pragma mark -
#pragma mark Abstract Models Methods

- (void) update: (UIViewController*)delegate {
    if ([self path] != @"Not Implemented") {
        _delegate = delegate;
        RKObjectManager* objectManager = [RKObjectManager sharedManager];
        [objectManager loadObjectsAtResourcePath:[self path] objectClass:[self class] delegate:self];
    }
}

// This method must be overriden
- (NSString*) path {
    return @"Not Implemented";
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    _delegate._reloading = NO;
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	
}


@end
