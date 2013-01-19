//
//  TrollCalendarView.m
//  Troll Calendar
//
//  Created by Victor Engel on 1/18/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//
//from previous project until "default code"
//
//  TrollCalendarView.m
//  TrollCalendar
//
//  Created by Victor Engel on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TrollCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "platform.h"
#import "Tower.h"
#import <CoreLocation/CoreLocation.h>

@implementation TrollCalendarView

@synthesize NumPlatforms;

@synthesize locationManager;

@synthesize displayedDate;

- (void)oneFingerDoubleTapped:(UITapGestureRecognizer*)recognizer{
   NSLog(@"### TrollCalendarView oneFingerDoubleTapped");
   //NSLog(@"DoubleTapped");
   displayedDate = [NSDate date];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
}

- (void)oneFingerSingleTapped:(UITapGestureRecognizer*)recognizer{
   //Add descriptive text.
   NSLog(@"### TrollCalendarView oneFingerSingleTapped");

}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer{
   NSLog(@"### TrollCalendarView rightSwipeHandle");
   //Now add code to go to the next date and refresh.
   displayedDate = [displayedDate dateByAddingTimeInterval:-24*60*60];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer{
   NSLog(@"### TrollCalendarView leftSwipeHandle");
   //Now add code to go to the previous date and refresh.
   displayedDate = [displayedDate dateByAddingTimeInterval:24*60*60];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
}

- (void)upSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer{
   NSLog(@"### TrollCalendarView upSwipeHandle");
   //Now add code to jump 73 days.
   displayedDate = [displayedDate dateByAddingTimeInterval:73*24*60*60];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
}

- (void)downSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer{
   NSLog(@"### TrollCalendarView downSwipeHandle");
   //Now add code to jump 73 days.
   displayedDate = [displayedDate dateByAddingTimeInterval:-73*24*60*60];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
}
- (void)tomorrowTimerDidFire:(NSTimer *)timer {
   NSLog(@"### TrollCalendarView tomorrowTimerDidFire");
   [self.subviews  makeObjectsPerformSelector:@selector(setNeedsDisplay)];
}
- (void) layoutSubviews
{
}
-(void)setupGestureRecognizers
{
   NSLog(@"Add gesture recognizers");
   // Try adding touch recognizer here.
   //UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]
   //                                   initWithTarget:self action:@selector()];
   UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
   [recognizerRight setNumberOfTouchesRequired:1];
   [self addGestureRecognizer:recognizerRight];
   
   UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
   [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
   [recognizerLeft setNumberOfTouchesRequired:1];
   [self addGestureRecognizer:recognizerLeft];
   
   UISwipeGestureRecognizer *recognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(upSwipeHandle:)];
   [recognizerUp setDirection:(UISwipeGestureRecognizerDirectionUp)];
   [recognizerUp setNumberOfTouchesRequired:1];
   [self addGestureRecognizer:recognizerUp];
   
   UISwipeGestureRecognizer *recognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(upSwipeHandle:)];
   [recognizerDown setDirection:(UISwipeGestureRecognizerDirectionDown)];
   [recognizerDown setNumberOfTouchesRequired:1];
   [self addGestureRecognizer:recognizerDown];
   
   UITapGestureRecognizer *oneFingerDoubleTap;
   oneFingerDoubleTap = [[UITapGestureRecognizer alloc]
                         initWithTarget:self
                         action:@selector(oneFingerDoubleTapped:)];
   [oneFingerDoubleTap setNumberOfTapsRequired:2];
   [oneFingerDoubleTap setNumberOfTouchesRequired:1];
   [self addGestureRecognizer:oneFingerDoubleTap];
   
   UITapGestureRecognizer *oneFingerSingleTap;
   oneFingerSingleTap = [[UITapGestureRecognizer alloc]
                         initWithTarget:self
                         action:@selector(oneFingerSingleTapped:)];
   [oneFingerSingleTap setNumberOfTapsRequired:1];
   [oneFingerSingleTap setNumberOfTouchesRequired:1];
   [oneFingerSingleTap requireGestureRecognizerToFail:oneFingerDoubleTap];
   [self addGestureRecognizer:oneFingerSingleTap];
   NSLog(@"Finished setting up gesture recognizers");
}
-(void)viewDidLoad
{
   NSLog(@"### TrollCalendarView - viewDidLoad");
}
-(void)addPlatforms {
   NSLog(@"### TrollCalendarView - addPlatforms");
   displayedDate = [NSDate date];
   self.NumPlatforms = 7;
   NSLog(@"Set up the platforms. Number of platforms: %d",self.NumPlatforms);
   for (NSInteger index=0;index < self.NumPlatforms;index++){
      NSLog(@"Working on platform %d of %d",index,self.NumPlatforms);
      PlatformView* pView = [[PlatformView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)-750./2, CGRectGetMidY(self.bounds)-750./2, 750., 750.)];
      pView.backgroundColor = [UIColor clearColor];
      [self addSubview:pView];
      pView.tag = index;
      pView.NumPlatforms = self.NumPlatforms;
      // Now make three towers for this platform. These will be subviews of the window rather than subviews of the platform because
      // they need to be orthogonal to true north rather than to the platform.
      float towerWidth = 68.0;
      float towerHeight = 68.0;
      float centerX, centerY;
      float towerSpacing = 27.0;
      for (NSInteger index2=0;index2<3;index2++){
         NSInteger towerTag = index*3+index2+100;
         Tower *checkForTower = (Tower*)[self viewWithTag:towerTag];
         if (checkForTower == nil) {
            centerX = CGRectGetMidX(pView.bounds);
            centerY = CGRectGetMidY(pView.bounds) + index2 * (towerHeight + towerSpacing);
            float topleftX = centerX - towerWidth/2;
            float topleftY = centerY - towerWidth/2 +115.;
            Tower* tower = [[Tower alloc] initWithFrame:CGRectMake(topleftX, topleftY, towerWidth, towerHeight)];
            tower.backgroundColor = [UIColor lightGrayColor];
            if (index<7) {
               [pView addSubview:tower]; //Move it to proper location in platform.m
               tower.parentView = self;
               tower.tag = index*3+index2+100;
            }
         }
      }
   }
}

-(void)wasInLayoutSubviews
{
   NSLog(@"### TrollCalendarView layoutSubviews");
   //Initialize displayedDate.
   //Set up timer to refresh upon date change.
   NSCalendar *calendar = [NSCalendar currentCalendar];
   NSDateComponents *todayComponents = [calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
   NSDate *today = [calendar dateFromComponents:todayComponents];
   // today is the start of today in the local time zone.  Note that `NSLog`
   // will print it in UTC, so it will only print as midnight if your local
   // time zone is UTC.
   
   NSDateComponents *oneDay = [[NSDateComponents alloc] init];
   oneDay.day = 1;
   NSDate *tomorrow = [calendar dateByAddingComponents:oneDay toDate:today options:0];
   NSTimer *timer = [[NSTimer alloc] initWithFireDate:tomorrow interval:0 target:self selector:@selector(tomorrowTimerDidFire:) userInfo:nil repeats:NO];
   [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
   
}

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      // Initialization code
      NSLog(@"### TrollCalendarView initWithFrame -- set up location manager");
      locationManager=[[CLLocationManager alloc] init];
      locationManager.desiredAccuracy = kCLLocationAccuracyBest;
      locationManager.delegate=self;
      NSLog(@"Location manager delegate set to TrollCalendarView");
      //Start the compass updates.
      [locationManager startUpdatingLocation];
      [locationManager startUpdatingHeading];
      //NSLog(@"TrollCalendarView initWithFrame");
   }
   return self;
}

//1:00:00 Uncomment out this section to add code to the drawRect method.
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*Remove this code when views work. Enable it to see the extent of the view.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 NSLog(@"drawRect from TrollCalendarView");
 }*/


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
   //NSLog(@"### TrollCalendarView - locationManager:didUpdateHeading: %@",newHeading);
   float radianheading = (180-newHeading.trueHeading) * M_PI / 180;
   //Now rotate the appropriate view(s).
   CGAffineTransform transformTrollCalendar = CGAffineTransformMakeRotation(radianheading);
   [self setTransform:transformTrollCalendar];
   
}


@end

/*default code
#import "TrollCalendarView.h"

@implementation TrollCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//@end
