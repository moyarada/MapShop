//
//  MapShopAppDelegate.m
//  MapShop
//
//  Created by Mike Bevz on 17/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapShopAppDelegate.h"
#import "Region.h"
#import "City.h"
#import "RegionsViewController.h"
#import "Area.h"


@implementation MapShopAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	// Override point for customization after application launch.
	NSLog(@"Loading main view");
	// Initialize RestKit
	RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://10.0.0.3:3000"];
	objectManager.format = RKMappingFormatJSON;
	RKObjectMapper* mapper = objectManager.mapper;
	
	// Initialize object store
	objectManager.objectStore = [[[RKManagedObjectStore alloc] initWithStoreFilename:@"MapShop.sqlite"] autorelease];
	
	// Add our element to object mappings
	[mapper registerClass:[Region class] forElementNamed:@"region"];
	[mapper registerClass:[City class] forElementNamed:@"city"];
	[mapper registerClass:[Area class] forElementNamed:@"area"];
	
	RKRailsRouter* router = [[[RKRailsRouter alloc] init] autorelease];
	
	[router setModelName:@"Region" forClass:[Region class]]; 
	//[router routeClass:[Region class] toResourcePath:@"/regions.json" 
	//		 forMethod:RKRequestMethodGET]; 
	[router routeClass:[Region class] toResourcePath:@"/regions.json" 
			 forMethod:RKRequestMethodPOST]; 
	[router routeClass:[Region class] toResourcePath:@"/regions/(id).json" 
			 forMethod:RKRequestMethodPUT]; 
	[router routeClass:[Region class] toResourcePath:@"/regions/(id).json" 
			 forMethod:RKRequestMethodDELETE]; 
	
	
	[router setModelName:@"City" forClass:[City class]]; 
	//[router routeClass:[City class] toResourcePath:@"/regions/(region_id)/cities.json"  forMethod:RKRequestMethodGET];
	[router routeClass:[City class] toResourcePath:@"/cities.json" 
			 forMethod:RKRequestMethodPOST]; 
	[router routeClass:[City class] toResourcePath:@"/cities/(id).json" 
			 forMethod:RKRequestMethodPUT]; 
	[router routeClass:[City class] toResourcePath:@"/cities/(id).json" 
			 forMethod:RKRequestMethodDELETE]; 
	
	[router setModelName:@"Area" forClass:[Area class]]; 
	//[router routeClass:[City class] toResourcePath:@"/regions/(region_id)/cities.json"  forMethod:RKRequestMethodGET];
	[router routeClass:[Area class] toResourcePath:@"/areas.json" 
			 forMethod:RKRequestMethodPOST]; 
	[router routeClass:[Area class] toResourcePath:@"/areas/(id).json" 
			 forMethod:RKRequestMethodPUT]; 
	[router routeClass:[Area class] toResourcePath:@"/areas/(id).json" 
			 forMethod:RKRequestMethodDELETE]; 
	
	
	
	[RKObjectManager sharedManager].router = router; 

	// Update date format so that we can parse twitter dates properly
	// Wed Sep 29 15:31:08 +0000 2010
	//NSMutableArray* dateFormats = [[[mapper dateFormats] mutableCopy] autorelease];
	//[dateFormats addObject:@"E MMM d HH:mm:ss Z y"];
	//[dateFormats addObject:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	//[mapper setDateFormats:dateFormats];
	
	RegionsViewController* viewController = [[[RegionsViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:viewController];
	UIWindow* window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	
	[window addSubview:controller.view];
    [window makeKeyAndVisible];
	
    
    return YES;
}


- (void)dealloc {
    
    [super dealloc];
}


@end

