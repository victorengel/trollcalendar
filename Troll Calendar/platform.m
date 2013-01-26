//
//  platform.m
//  Troll Calendar
//
//  Created by Victor Engel on 1/18/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//
//from here until "default code" is copied from previous project.
//
//  platform.m
//  TrollCalendar
//
//  Created by Victor Engel on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "platform.h"
#import <QuartzCore/QuartzCore.h>
#import "TrollCalendarView.h"
#import "Tower.h"

@implementation PlatformView

@synthesize NumPlatforms;
static CGFloat radiansForDegrees(CGFloat degrees) {
   return degrees * M_PI / 180;
}

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      // Initialization code
      // Now make three towers for this platform. Thes will be subviews of the window rather than subviews of the platform because
      // they need to be orthogonal to true north rather than to the platform.
   }
   return self;
}

- (void) layoutSubviews
{
   if (self.NumPlatforms == 0) {
      //NSLog(@"Zero platforms");
   } else {
      float angle = 2 * M_PI * self.tag / self.NumPlatforms;
      CGAffineTransform transformPlatform = CGAffineTransformMakeRotation(angle);
      [self setTransform:transformPlatform];
      // Now transform the associated towers, too.
      //copy from above -- probably can optimize code better
      // Inner tower
      NSInteger whichTower = self.tag * 3 + 100;
      Tower *getTowerViewInner = (Tower*)[self viewWithTag:whichTower];
      CGAffineTransform inversetransformPlatform;
      inversetransformPlatform = CGAffineTransformInvert(transformPlatform);
      [getTowerViewInner setTransform:inversetransformPlatform];
      whichTower = self.tag * 3 + 101;
      Tower *getTowerViewMiddle = (Tower*)[self.window viewWithTag:whichTower];
      [getTowerViewMiddle setTransform:inversetransformPlatform];
      whichTower = self.tag * 3 + 102;
      Tower *getTowerViewOuter = (Tower*)[self.window viewWithTag:whichTower];
      [getTowerViewOuter setTransform:inversetransformPlatform];
   }
   
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
   // Drawing code
   // Try moving entire code from drawrect to here:
   //   float maxRadius = hypot(self.bounds.size.width, self.bounds.size.height)/8;
   //NSLog(@"drawRect from platform");
   [self.subviews makeObjectsPerformSelector:@selector(setNeedsDisplay)];
   
   CGContextRef contextPlatformView = UIGraphicsGetCurrentContext();
   CGContextSetLineWidth(contextPlatformView, 0.5);
   [[UIColor darkGrayColor] setStroke];
   if (self.tag < 7) {
      CGContextMoveToPoint(contextPlatformView, 0, 0);
      // Draw the platform. Handy function: radiansForDegrees
      float xAdj = self.bounds.size.width/2; float yAdj = self.bounds.size.height/2;
      // one short leg
      float smallAngle = radiansForDegrees(360./14.);
      //      NSLog(@"smallAngle = %f",360./14.);
      float pitLength = 50.0;
      float legLength = 60.0;
      float platformLength = 260.0;
      float inPosxL = xAdj + pitLength*sinf(smallAngle);
      float inPosyL = yAdj + pitLength*cosf(smallAngle);
      CGContextMoveToPoint(contextPlatformView, inPosxL, inPosyL);
      float outPosxL = xAdj + (pitLength+legLength)*sinf(smallAngle);
      float outPosyL = yAdj + (pitLength+legLength)*cosf(smallAngle);
      CGContextAddLineToPoint(contextPlatformView, outPosxL, outPosyL);
      CGContextStrokePath(contextPlatformView);
      // other short leg
      float inPosxR = xAdj - pitLength*sinf(smallAngle);
      float inPosyR = yAdj + pitLength*cosf(smallAngle);
      float outPosxR = xAdj - (pitLength+legLength)*sinf(smallAngle);
      float outPosyR = yAdj + (pitLength+legLength)*cosf(smallAngle);
      CGContextMoveToPoint(contextPlatformView, inPosxR, inPosyR);
      CGContextAddLineToPoint(contextPlatformView, outPosxR, outPosyR);
      CGContextStrokePath(contextPlatformView);
      // connect the legs
      CGContextMoveToPoint(contextPlatformView, inPosxL, inPosyL);
      CGContextAddLineToPoint(contextPlatformView, inPosxR, inPosyR);
      CGContextStrokePath(contextPlatformView);
      // sides
      CGContextMoveToPoint(contextPlatformView, outPosxL, outPosyL);
      CGContextAddLineToPoint(contextPlatformView, outPosxL, outPosyL+platformLength);
      
      CGContextMoveToPoint(contextPlatformView, outPosxR, outPosyR);
      CGContextAddLineToPoint(contextPlatformView, outPosxR, outPosyR+platformLength);
      CGContextStrokePath(contextPlatformView);
      // connect the ends
      CGContextMoveToPoint(contextPlatformView, outPosxL, outPosyL+platformLength);
      CGContextAddLineToPoint(contextPlatformView, outPosxR, outPosyR+platformLength);
      CGContextStrokePath(contextPlatformView);
      // Move the appropriate towers to their correct positions. NOT -- rotate them instead. See below.
      // The relevant towers are the ones with tower.tag = self.tag*3+100 , self.tag*3+101, and self.tag*3+102
      // Inner tower
      NSInteger whichTower = self.tag * 3 + 100;
      //      float towerX = (outPosxL + outPosxR)/2;
      float towerY = outPosyL;
      //Tower *getTowerViewInner = (Tower*)[self viewWithTag:whichTower];
      //NSLog(@"Tag for this tower is %d -- should be %d",getTowerViewInner.tag, whichTower);
      // Middle tower
      whichTower = self.tag * 3 + 101;
      towerY += 110.0;
      //      Tower *getTowerViewMiddle = (Tower*)[self.window viewWithTag:whichTower];
      // Outer tower
      towerY += 110.0;
      whichTower = self.tag * 3 + 102;
      //     Tower *getTowerViewOuter = (Tower*)[self.window viewWithTag:whichTower];
   }
   CGContextStrokePath(contextPlatformView);
   CGContextBeginPath(contextPlatformView);
   CGContextMoveToPoint(contextPlatformView, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
   CGContextSetRGBStrokeColor(contextPlatformView, 0.5, 0.6, 0.7, 1.0);
}
-(void)removeStones
{
   for (UIImageView *stoneImageView in self.subviews) {
      if (stoneImageView.tag >= 10000 && stoneImageView.tag <= 10008) {
         [stoneImageView removeFromSuperview];
      }
   }
}
-(void)addStone: (NSInteger)stoneNumber
{
   // Add stone number stoneNumber to the current platform.
   int imageTag = 10000+stoneNumber;
   //Check if image is already on platform, else add it.
   BOOL imageAlreadyOnPlatform = NO;
   for (UIImageView *stoneImageView in self.subviews) {
      if (stoneImageView.tag == imageTag) imageAlreadyOnPlatform = YES;
   }
   if (!imageAlreadyOnPlatform) {
      NSString* filePath = [[NSBundle mainBundle] pathForResource:@"stone"
                                                           ofType:@"gif"];
      UIImage *stoneImage = [[UIImage alloc]initWithContentsOfFile:filePath];
      UIImageView *stoneImageView = [[UIImageView alloc]initWithImage:stoneImage];
      stoneImageView.tag = imageTag;
      [stoneImageView sizeToFit];
      if (stoneNumber == 8) {
         stoneImageView.transform = CGAffineTransformMakeScale(0.03, 0.02);
      } else {
         stoneImageView.transform = CGAffineTransformMakeScale(0.03, 0.03);
      }
      stoneImageView.transform = CGAffineTransformRotate(stoneImageView.transform, M_PI/2.0);
/*Actual coordinates of angled lines at inside of each platform.
 (396.694183,420.048431) to (422.727203,474.106567)
 (353.305817,420.048431) to (327.272797,474.106567)
 So x ranges from 327 to 423
    y ranges from 420 to 474
 
 Use x from 354 to 396 (dif: 42)
 Use y from 420 to 474 (dif: 54)
 */
      //Stones numbered 1..4 have y position of 420
      //Stones numbered 5..8 have y position of 474
      //Stones x position is 354 + (stoneNumber mod 4) * 10
      int xIndex = stoneNumber;
      float yPos = 425.0;
      if (stoneNumber>4) {
         xIndex = stoneNumber - 4;
         yPos = 439.0;
      }
      float xPos = 350.0 + xIndex*10.0;
      stoneImageView.center = CGPointMake(xPos, yPos);
      [self addSubview:stoneImageView];
   }
}

@end

