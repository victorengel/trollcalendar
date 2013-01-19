//
//  trollcalendarAppDelegate.m
//  Troll Calendar
//
//  Created by Victor Engel on 1/18/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//

#import "trollcalendarAppDelegate.h"

@implementation trollcalendarAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
   /*Old app delegate code for this method follows:
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    ///My own attempt to add a subview to cView
    ///First set the size of the rectangle the view will use.
    ///Next allocate the view using the rectangle just specified.
    ///Later we need to change UIView to a custom view we make that is a subclass of UIView.
    //displayedDate = [NSDate date]; //Initialize the displayed date.
    
    //1:06:59 Instantiate the TrollCalendar view
    CGRect groundRect = self.window.bounds;
    groundRect.origin.x -= 300;
    groundRect.origin.y -= 300;
    groundRect.size.width += 600;
    groundRect.size.height += 600;
    TrollCalendarView* cView = [[TrollCalendarView alloc] initWithFrame:groundRect];
    // 1:07:00 Make background of TrollCalendar view transparent.
    cView.backgroundColor = [UIColor lightGrayColor];
    // 1:07:50 Add the view to the window
    [self.window addSubview:cView];
    // 1:08:00 Releast the cview (not available with ARC)
    //[cView release];
    ///Add it as a subview of cview.
    ///[platform addSubview:cView];
    //1:06:00 Add our view as a subview of the window.
    cView.NumPlatforms = 7;                                  // Set the number of platforms
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;    */
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
   // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
