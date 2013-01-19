//
//  trollcalendarViewController.m
//  Troll Calendar
//
//  Created by Victor Engel on 1/18/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//

#import "trollcalendarViewController.h"
#import "TrollCalendarView.h"

@interface trollcalendarViewController ()

@end

@implementation trollcalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   //Add a TrollCalendarView using a frame matching the current view.
   CGRect groundRect = self.view.bounds;
   groundRect.origin.x -= 300;
   groundRect.origin.y -= 300;
   groundRect.size.width += 600;
   groundRect.size.height += 600;
   NSLog(@"Initializing TrollCalendarView");
   TrollCalendarView* cView = [[TrollCalendarView alloc] initWithFrame:groundRect];
   self.view.backgroundColor = [UIColor lightGrayColor];
   cView.backgroundColor = [UIColor lightGrayColor];
   [cView addPlatforms];
   NSLog(@"Adding a TrollCalendarView");
   NSLog(@"TrollCalendarView frame is: %@",NSStringFromCGRect(cView.frame));
   NSLog(@"Center of TrollCalendarView is: %@",NSStringFromCGPoint(cView.center));
   cView.center = self.view.center;
   [self.view addSubview:cView];
   [cView displayTheDate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
