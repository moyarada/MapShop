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
#import "RegionViewController+Generic.h"
#import "Area.h"
#import "Shop.h"
#import "SPoint.h"


#define CRASH_REPORTER_URL [NSURL URLWithString:@"http://crasher.and-ants.com/crash_v200.php"]

@implementation MapShopAppDelegate

@synthesize window, navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // Crash reporter
    
    

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    _application = application;
        
    //
    
	// Override point for customization after application launch.
	NSLog(@"Loading main view");
	// Initialize RestKit
	RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://shopic.and-ants.com"];
	objectManager.format = RKMappingFormatJSON;
	RKObjectMapper* mapper = objectManager.mapper;
	
	// Initialize object store
	objectManager.objectStore = [[[RKManagedObjectStore alloc] initWithStoreFilename:@"MapShop.sqlite"] autorelease];
	
	// Add our element to object mappings
	[mapper registerClass:[Region class] forElementNamed:@"region"];
	[mapper registerClass:[City class] forElementNamed:@"city"];
	[mapper registerClass:[Area class] forElementNamed:@"area"];
	[mapper registerClass:[Shop class] forElementNamed:@"shop"];
	[mapper registerClass:[SPoint class] forElementNamed:@"point"];
	
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
	
	[router setModelName:@"Shop" forClass:[Shop class]]; 
	[router routeClass:[Shop class] toResourcePath:@"/shops.json" 
			 forMethod:RKRequestMethodPOST]; 
	[router routeClass:[Shop class] toResourcePath:@"/shops/(id).json" 
			 forMethod:RKRequestMethodPUT]; 
	[router routeClass:[Shop class] toResourcePath:@"/shops/(id).json" 
			 forMethod:RKRequestMethodDELETE]; 
	
	[router setModelName:@"SPoint" forClass:[SPoint class]]; 
	[router routeClass:[SPoint class] toResourcePath:@"/points.json" 
			 forMethod:RKRequestMethodPOST]; 
	[router routeClass:[SPoint class] toResourcePath:@"/points/(id).json" 
			 forMethod:RKRequestMethodPUT]; 
	[router routeClass:[SPoint class] toResourcePath:@"/points/(id).json" 
			 forMethod:RKRequestMethodDELETE]; 
	
	
	[RKObjectManager sharedManager].router = router; 

	// Update date format so that we can parse twitter dates properly
	// Wed Sep 29 15:31:08 +0000 2010
	//NSMutableArray* dateFormats = [[[mapper dateFormats] mutableCopy] autorelease];
	//[dateFormats addObject:@"E MMM d HH:mm:ss Z y"];
	//[dateFormats addObject:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	//[mapper setDateFormats:dateFormats];
	
	
	RegionViewController_Generic* genericViewController = [[RegionViewController_Generic alloc] initWithNibName:nil bundle:nil];
	
	genericViewController.title = @"Regions";
	
	UINavigationController *controller = [[[UINavigationController alloc] initWithRootViewController:genericViewController] autorelease];
	[self setNavigationController:controller];
	[self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
	[controller release];
	[genericViewController release];
	
	
	self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	
	[self.window addSubview:[navigationController view]];
    [self.window makeKeyAndVisible];
	
    [[CrashReportSender sharedCrashReportSender] sendCrashReportToURL:CRASH_REPORTER_URL 
                                                             delegate:self 
                                                     activateFeedback:YES];
    
    return YES;
}

#pragma mark CrashReportSenderDelegate

-(void)connectionOpened
{
	_application.networkActivityIndicatorVisible = YES;
}


-(void)connectionClosed
{
	_application.networkActivityIndicatorVisible = NO;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //[[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"FinishedSafely"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)dealloc {
    [navigationController release];
    [window release];
    [super dealloc];
}




@end

