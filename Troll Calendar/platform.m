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
      //NSLog(@"Platform initWithFrame");
   }
   return self;
}

- (void) layoutSubviews
{
   if (self.NumPlatforms == 0) {
      //NSLog(@"Zero platforms");
   } else {
      //NSLog(@"Platform %d has %d",self.tag,self.NumPlatforms);
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
      //self.TowerX = (outPosxL + outPosxR)/2;
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
   //CGContextClosePath(contextPlatformView);
   CGContextBeginPath(contextPlatformView);
   CGContextMoveToPoint(contextPlatformView, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
   CGContextSetRGBStrokeColor(contextPlatformView, 0.5, 0.6, 0.7, 1.0);
}


@end

/*default code
 #import "platform.h"

@implementation PlatformView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//@end

