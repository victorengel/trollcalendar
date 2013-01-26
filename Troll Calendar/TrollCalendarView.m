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

-(NSInteger)whichPlatform: (double)serial forStoneNumber: (NSInteger)stoneNumber
{
   // Replace below code with new code.
   // First copy this code from displayTheDate
   long fullCycles = floor(serial/84371.0);
   double serialInFullCycle = serial - fullCycles*84371.0;
   long smallCycles = floor(serialInFullCycle/12053.0);
   double serialInSmallCycle = serialInFullCycle - smallCycles * 12053.0;
   long cyc1534 = floor(serialInSmallCycle/1534.0);
   //double serialInCyc1534 = serialInSmallCycle - cyc1534*1534;
   //long semesters = floor(serialInCyc1534/73.0);
   //long serialInSemester = floor(serialInCyc1534 - semesters*73.0);
   //NSString *cycles = [NSString stringWithFormat:@"%ld.%ld.%ld.%ld.%ld",fullCycles,smallCycles,cyc1534,semesters,serialInSemester];
   long platformOfLeftStone = smallCycles;
   long numberOfStonesOnRightPlatform = cyc1534+1;
   long numberOfStonesOnLeftPlatform = 8 - numberOfStonesOnRightPlatform;
   if (stoneNumber <= numberOfStonesOnLeftPlatform) {
      return platformOfLeftStone;
   } else {
      return (platformOfLeftStone+1)%7;
   }
}

- (void)oneFingerDoubleTapped:(UITapGestureRecognizer*)recognizer{
   self.displayedDate = [NSDate date];
   //Set to epoch instead.
   //
   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   formatter.dateFormat = @"dd MMM yyyy HH:mm ZZZ";
   
   NSDate *epoch = [formatter dateFromString:@"21 Mar 1975 05:57 +0000"];
   self.displayedDate = epoch;
   self.gesturePerformed = [NSDate date];
   [self displayTheDate];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
}

- (void)oneFingerSingleTapped:(UITapGestureRecognizer*)recognizer{
   //Add descriptive text.
   //Check if the text is already displayed. If so, remove it. Otherwise display it.
   BOOL helpTextAlreadyDisplayed = NO;
   UILabel *existingLabel;
   for (UIView *existingDecoration in self.superview.subviews) {
      if (existingDecoration.tag == 3333) {
         for (existingLabel in self.superview.subviews) {
            if (existingLabel.tag == 3333) {
               [existingLabel removeFromSuperview];
               helpTextAlreadyDisplayed = YES;
            }
         }
         [existingDecoration removeFromSuperview];
      }
   }
   if (!helpTextAlreadyDisplayed) {
      NSString* filePath = [[NSBundle mainBundle] pathForResource:@"helpText"
                                                           ofType:@""];
      NSString *helpText = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:nil];
      UILabel * helpTextView = [[UILabel alloc]init];
      helpTextView.numberOfLines = 0;
      helpTextView.text = helpText;
      [helpTextView sizeToFit];
      helpTextView.tag = 3333;
      UIView *textDecoration = [[UIView alloc]init];
      textDecoration.frame =
      CGRectMake(0.0,
                 0.0,
                 helpTextView.frame.size.width*1.2,
                 helpTextView.frame.size.height*1.2);
      textDecoration.backgroundColor = helpTextView.backgroundColor;
      helpTextView.center = textDecoration.center;
      [textDecoration addSubview:helpTextView];
      textDecoration.tag = 3333;
      textDecoration.center = self.superview.center;
      float maxHeight = self.superview.bounds.size.height * 0.75;
      float maxWidth = self.superview.bounds.size.width * 0.75;
      maxHeight = [[UIScreen mainScreen] bounds].size.height * 0.75;
      maxWidth = [[UIScreen mainScreen] bounds].size.width * 0.75;
      float actHeight = textDecoration.frame.size.height;
      float actWidth = textDecoration.frame.size.width;
      float scale = 1.0;
      if (actHeight > maxHeight) {
         scale = maxHeight/actHeight;
      }
      if (scale*actWidth > maxWidth) {
         scale = maxWidth/actWidth;
      }
      textDecoration.transform = CGAffineTransformMakeScale(scale, scale);
      [self.superview addSubview:textDecoration];
      [self.superview bringSubviewToFront:textDecoration];
   }
   self.gesturePerformed = [NSDate date];
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer{
   //Now add code to go to the next date and refresh.
   displayedDate = [displayedDate dateByAddingTimeInterval:-24.0*60.0*60.0];
   [self displayTheDate];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
   self.gesturePerformed = [NSDate date];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer{
   //Now add code to go to the previous date and refresh.
   displayedDate = [displayedDate dateByAddingTimeInterval:24.0*60.0*60.0];
   [self displayTheDate];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
   self.gesturePerformed = [NSDate date];
}

- (void)upSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer{
   //Now add code to jump 73 days.
   displayedDate = [displayedDate dateByAddingTimeInterval:-73.0*24.0*60.0*60.0];
   [self displayTheDate];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
   self.gesturePerformed = [NSDate date];
}

- (void)downSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer{
   //Now add code to jump 73 days.
   displayedDate = [displayedDate dateByAddingTimeInterval:73.0*24.0*60.0*60.0];
   [self displayTheDate];
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
   self.gesturePerformed = [NSDate date];
}
- (void)pinch:(UIPinchGestureRecognizer*)pinch{
   CGAffineTransform pinchStart;
   if (pinch.state == UIGestureRecognizerStateBegan) {
      pinchStart = self.transform;
      self.pinchStart = pinchStart;
   } else {
      pinchStart = self.pinchStart;
   }
   self.transform = CGAffineTransformScale(pinchStart, pinch.scale, pinch.scale);
   self.gesturePerformed = [NSDate date];
}
- (void)pan:(UIPanGestureRecognizer*)pan{
   CGPoint originalPoint;
   if (pan.state == UIGestureRecognizerStateBegan) {
      originalPoint = CGPointMake(self.center.x, self.center.y);
      self.panStartLocation = CGPointMake(originalPoint.x, originalPoint.y);
   } else {
      originalPoint = CGPointMake(self.panStartLocation.x, self.panStartLocation.y);
   }
   CGPoint translation = [pan translationInView:self.superview];
   self.center = CGPointMake(originalPoint.x+translation.x, originalPoint.y+translation.y);
   self.gesturePerformed = [NSDate date];
}
- (void)tomorrowTimerDidFire:(NSTimer *)timer {
   //Skip this method of there was a gesture in the last minute.
   NSDate *lastGesturePerformed = self.gesturePerformed;
   NSDate *rightNow = [NSDate date];
   float timeElapsed = [lastGesturePerformed timeIntervalSinceNow];
   if ((timeElapsed < -60.0)||!lastGesturePerformed) {
      self.displayedDate = rightNow;
      [self displayTheDate];
   }
}
- (void) layoutSubviews
{
}
-(void)setupGestureRecognizers
{
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
                                                                                        action:@selector(downSwipeHandle:)];
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
   
   UIPinchGestureRecognizer *pinch;
   pinch = [[UIPinchGestureRecognizer alloc]
            initWithTarget:self
            action:@selector(pinch:)];
   [self addGestureRecognizer:pinch];
   
   UIPanGestureRecognizer *pan;
   pan = [[UIPanGestureRecognizer alloc]
          initWithTarget:self
          action:@selector(pan:)];
   pan.minimumNumberOfTouches = 2;
   [self addGestureRecognizer:pan];
}
-(void)viewDidLoad
{
   [self displayTheDate];
}
-(void)addPlatforms {
   displayedDate = [NSDate date];
   self.NumPlatforms = 7;
   for (NSInteger index=0;index < self.NumPlatforms;index++){
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
      //The towers have been added. Now add the stones, if any.
      double serial = [Tower getSerialForDate:displayedDate];
      NSInteger platformForStone;
      for (int stoneNumber=1; stoneNumber<=8; stoneNumber++) {
         platformForStone = [self whichPlatform:serial forStoneNumber:stoneNumber];
         if (platformForStone == index) {
            //Add this stone to this platform.
            [pView addStone:stoneNumber];
         }
      }
   }
}
-(void)setupTimer
{
   NSTimer *timer = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:1.0 target:self selector:@selector(tomorrowTimerDidFire:) userInfo:nil repeats:YES];
   [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      // Initialization code
      locationManager=[[CLLocationManager alloc] init];
      locationManager.desiredAccuracy = kCLLocationAccuracyBest;
      locationManager.delegate=self;
      //Start the compass updates.
      [locationManager startUpdatingLocation];
      [locationManager startUpdatingHeading];
      //Set up gesture recognizers
      [self setupGestureRecognizers];
      [self setupTimer];
   }
   return self;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
   float radianheading = (180-newHeading.trueHeading) * M_PI / 180;
   //Now rotate the appropriate view(s).
   CGAffineTransform transformTrollCalendar = CGAffineTransformMakeRotation(radianheading);
   [self setTransform:transformTrollCalendar];
   
}

-(void)displayTheDate
{
   NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
   [dateFormat setDateFormat:@"yyyy-MM-dd"];
   NSString *dateString = [dateFormat stringFromDate:self.displayedDate];
   NSString *previousValue = @"";
   for (UILabel *dateLabel in self.superview.subviews) {
      if (dateLabel.tag == 2143) {
         previousValue = dateLabel.text;
         [dateLabel removeFromSuperview];
      }
   }
   double serial = [Tower getSerialForDate:self.displayedDate];
   long fullCycles = floor(serial/84371.0);
   double serialInFullCycle = serial - fullCycles*84371.0;
   long smallCycles = floor(serialInFullCycle/12053.0);
   double serialInSmallCycle = serialInFullCycle - smallCycles * 12053.0;
   long cyc1534 = floor(serialInSmallCycle/1534.0);
   double serialInCyc1534 = serialInSmallCycle - cyc1534*1534;
   long semesters = floor(serialInCyc1534/73.0);
   long serialInSemester = floor(serialInCyc1534 - semesters*73.0);
   long whichTower = smallCycles;
   if (cyc1534 == 7) {
      whichTower += 1;
   }
   whichTower = whichTower % 7;
   [self orientTheTrollBy:semesters+serialInSemester whichTower:whichTower];
   //1534*7+1315
   NSString *cycles = [NSString stringWithFormat:@"%ld.%ld.%ld.%ld.%ld",fullCycles,smallCycles,cyc1534,semesters,serialInSemester];
   dateString = [dateString stringByAppendingString:@" E:+1 W:-1 N:+73 S:-73 "];
   dateString = [dateString stringByAppendingString:cycles];
   if (dateString != previousValue) {
      // The date has changed. Redisplay the calendar
      [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
      //[self.subviews makeObjectsPerformSelector:@selector(removeStones)];
      for (PlatformView *platform in self.subviews) {
         if (platform.tag >=0 && platform.tag <= 7) {
            [platform removeStones];
         }
      }
      //Now add stones back to appropriate platforms
      double serial = [Tower getSerialForDate:self.displayedDate];
      for (int stoneNumber=1; stoneNumber<=8; stoneNumber++) {
         int whichPlatform = [self whichPlatform:serial forStoneNumber:stoneNumber];
         for (PlatformView *platformView in self.subviews) {
            if (platformView.tag == whichPlatform) {
               [platformView addStone:stoneNumber];
            }
         }
      }
   }
   UILabel *dateLabel = [[UILabel alloc] init];
   dateLabel.text = dateString;
   dateLabel.tag = 2143;
   dateLabel.backgroundColor = [UIColor lightGrayColor];
   [dateLabel sizeToFit];
   dateLabel.frame = CGRectMake(self.superview.bounds.size.width/2.0 - dateLabel.frame.size.width/2.0, 0.0, dateLabel.frame.size.width, dateLabel.frame.size.height);
   [self.superview addSubview:dateLabel];
   [self.superview bringSubviewToFront:dateLabel];
}
-(void)orientTheTrollBy: (NSInteger)trollOrientation whichTower: (NSInteger)towerToFace
{
   //NSLog(@"Orient the troll by %d",trollOrientation);
   float angleToRotate;
   if (trollOrientation == 0) angleToRotate = 0; else angleToRotate = M_PI;
   angleToRotate += towerToFace * M_PI * 2.0 / 7.0;
   for (UIImageView *trollImageView in self.subviews) {
      if (trollImageView.tag == 84371) {
         //CGAffineTransform oldTransform = trollImageView.transform;
         trollImageView.transform = CGAffineTransformMakeRotation(angleToRotate);
         trollImageView.transform = CGAffineTransformScale(trollImageView.transform, 0.5, 0.5);
      }
   }
}
@end

