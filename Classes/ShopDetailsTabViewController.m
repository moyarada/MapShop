//
//  ShopDetailsTabViewController.m
//  MapShop
//
//  Created by Mike Bevz on 08/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShopDetailsTabViewController.h"


@implementation ShopDetailsTabViewController

@synthesize currentShop, shopName, thumb, address, 
			website, phone, addPhotoBtn, navigationItem, navigationController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		
    }
    return self;
}

- (void) updateShop {
    
    NSLog(@"Updating shop");
    
    currentShop.name = shopName.text;
    currentShop.address = address.text;
    currentShop.website = website.text;
    currentShop.phone = phone.text;
    
    self.navigationItem.title = shopName.text;
    
    [[RKObjectManager sharedManager] putObject:currentShop delegate:self]; 
}

#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	//NSLog(@"Objects loaded");
	//[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
	//[[NSUserDefaults standardUserDefaults] synchronize];
	NSLog(@"Loaded items in Update Shop: %@", objects);
	
    [self resignFirstResponders];
    
        
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Shop info updated!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
    
	
}



- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	
    [self resignFirstResponders];
    
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
	
    
	//[self loadObjectsFromDataStore];
	//[_tableView reloadData];
	
}

- (void) resignFirstResponders {
    if ([website isFirstResponder]) {
        [website resignFirstResponder];
    }
    
    if ([address isFirstResponder]) {
        [address resignFirstResponder];
    }
    
    if ([phone isFirstResponder]) {
        [phone resignFirstResponder];
    }
    
    if ([shopName isFirstResponder]) {
        [shopName resignFirstResponder];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	shopName.text = [currentShop name];
	address.text = [currentShop address];
    website.text = [currentShop website];
    phone.text = [currentShop phone];
    
    //UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(updateShop)];
	//self.navigationItem.rightBarButtonItem = saveButton;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    thumb = nil;
    address = nil;
    shopName = nil;
    website = nil;
    phone = nil;
    addPhotoBtn = nil;
}


- (void)dealloc {
    [thumb release];
    [address release];
    [shopName release];
    [website release];
    [phone release];
    [addPhotoBtn release];
    [currentShop release];
    [navigationItem release];
    [super dealloc];
}


@end
