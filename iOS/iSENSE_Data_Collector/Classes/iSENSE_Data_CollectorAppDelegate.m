//
//  iSENSE_Data_CollectorAppDelegate.m
//  iSENSE_Data_Collector
//
//  Created by Jeremy Poulin on 10/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "iSENSE_Data_CollectorAppDelegate.h"
#import	"iSENSE_Data_CollectorViewController_iPad.h"

@implementation iSENSE_Data_CollectorAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application { 
	// Set Background to Black
	[self.window setBackgroundColor:[UIColor blackColor]];
	
	// Allocate the view controller
	self.viewController = [[iSENSE_Data_CollectorViewController_iPad alloc] initWithNibName:nil bundle:nil];
	
	// Display view controller's view
	[window makeKeyAndVisible];
}
	
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
