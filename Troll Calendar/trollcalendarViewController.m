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
   TrollCalendarView* cView = [[TrollCalendarView alloc] initWithFrame:groundRect];
   self.view.backgroundColor = [UIColor lightGrayColor];
   cView.backgroundColor = [UIColor lightGrayColor];
   //Add the troll
   [self addTrollToView:cView];
   [cView addPlatforms];
   cView.center = self.view.center;
   [self.view addSubview:cView];
   [cView displayTheDate];
}

- (void)addTrollToView:(TrollCalendarView *)trollView
{
   NSString* filePath = [[NSBundle mainBundle] pathForResource:@"thetroll"
                                                        ofType:@"jpg"];
   UIImage *trollImage = [[UIImage alloc] initWithContentsOfFile:filePath];
   UIImageView *trollImageView = [[UIImageView alloc] initWithImage:trollImage];
   trollImageView.center = CGPointMake(685.0, 810.0);
   trollImageView.tag = 84371;
   trollImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
   trollImageView.transform = CGAffineTransformRotate(trollImageView.transform, M_PI);
   [trollView addSubview:trollImageView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
