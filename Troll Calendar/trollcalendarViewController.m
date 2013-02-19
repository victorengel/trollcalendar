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
   [self addHeptagonToView:cView];
   [self addTrollToView:cView];
   [cView addPlatforms];
   cView.center = self.view.center;
   [self.view addSubview:cView];
   [cView displayTheDate];
}
-(void)addCircleto:(UIImageView *)heptagon atPoint:(CGPoint)p color:(NSString *)color tag:(NSUInteger)tag
{
   //NSLog(@"addCircleto:heptagon atPoint %f,%f",p.x,p.y);
   //NSString* filePath = [[NSBundle mainBundle] pathForResource:@"circle"
   //                                                     ofType:@"png"];
   //UIImage *circleImage = [[UIImage alloc] initWithContentsOfFile:filePath];
   UIImage *circleImage = [UIImage imageNamed:[NSString stringWithFormat:@"circle%@.png",color]];
   UIImageView *circleImageView = [[UIImageView alloc] initWithImage:circleImage];
   circleImageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
   circleImageView.center = p;
   circleImageView.tag = tag;
   [heptagon addSubview:circleImageView];
}
-(void)addLunarRingsToHeptagon:(UIImageView *)heptagon atCenter:(CGPoint)center
{
   /*
    There are two rings of circles just inside the perimeter of the heptagon. The outer ring
    has 30 circles. The inner ring has 29 circles. Due north the circles of each are offset
    slightly so that they are in the same spot. In this way, a marker can be moved from spot
    to spot, alternating from the 30 position ring to the 29 position ring.
    
    To make the troll calendar lunisolar, a troll Metonic cycle equating 19 seasons (of 73 moves)
    is equated to 47 lunations. Both these cycles have exactly 1387 moves. 
    
    1387 = 19 * 73 = 24 * 30 + 23 * 29
    ____   _______   _________________
    moves   solar    lunar (24 long, 23 short)
    */
   // First let's do the 30-position ring
   //NSLog(@"addLunarRingsToHeptagon");
   float radius = 197.0;
   CGFloat x,y;
   NSString *color;
   for (int i=1; i<30; i++) {
      CGFloat angle = 2.0 * M_PI * i / 30.0;
      x = sinf(angle) * radius;
      y = cosf(angle) * radius;
      color = @"";
      [self addCircleto:heptagon atPoint:CGPointMake(231.0+x, 238.0+y) color:color tag:30-i];
   }
   radius = 162.0;
   // Next let's do the 29-position ring
   for (int i=1; i<29; i++) {
      CGFloat angle = 2.0 * M_PI * i / 29.0;
      x = sinf(angle) * radius;
      y = cosf(angle) * radius;
      [self addCircleto:heptagon atPoint:CGPointMake(231.0+x, 238.0+y) color:color tag:59-i];
   }
   radius = 365.0/2.0;
   x = 0.0;
   y = radius;
   [self addCircleto:heptagon atPoint:CGPointMake(231.0+x, 238.0+y) color:color tag:30];
}
-(void)addHeptagonToView:(TrollCalendarView *)trollView
{
   //iPad:       (0,0),(1368,1624) center: (684, 812)
   //iPhone Sim: (0,0),( 920,1080) center: (460, 540)
   //iPhone 4":  (0,0),( 920,1168) center: (460, 584)
   float centerX = trollView.bounds.size.width/2.0;
   float centerY = trollView.bounds.size.height/2.0;
   NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Heptagon"
                                                        ofType:@"png"];
   UIImage *heptagonImage = [[UIImage alloc] initWithContentsOfFile:filePath];
   UIImageView *heptagonImageView = [[UIImageView alloc] initWithImage:heptagonImage];
   //heptagonImageView.center = CGPointMake(684.0, 809.5);//+ = north, west
   heptagonImageView.center = CGPointMake(centerX, centerY-2.5);
   [self addLunarRingsToHeptagon:heptagonImageView atCenter:heptagonImageView.center];
   heptagonImageView.tag = 84372;
   heptagonImageView.transform = CGAffineTransformMakeScale(0.21, 0.21);
   //heptagonImageView.transform = CGAffineTransformRotate(heptagonImageView.transform, M_PI);
   [trollView addSubview:heptagonImageView];
}
- (void)addTrollToView:(TrollCalendarView *)trollView
{
   float centerX = trollView.bounds.size.width/2.0;
   float centerY = trollView.bounds.size.height/2.0;
/*   NSString* filePath = [[NSBundle mainBundle] pathForResource:@"thetroll"
                                                        ofType:@"png"];
   UIImage *trollImage = [[UIImage alloc] initWithContentsOfFile:filePath];*/
   UIImage *trollImage = [UIImage imageNamed:@"thetroll.png"];
   UIImageView *trollImageView = [[UIImageView alloc] initWithImage:trollImage];
   //   trollImageView.center = CGPointMake(685.0, 810.0);
   trollImageView.center = CGPointMake(centerX, centerY);
   trollImageView.tag = 84371;
   //trollImageView.transform = CGAffineTransformMakeScale(0.04, 0.04);
   //trollImageView.transform = CGAffineTransformRotate(trollImageView.transform, M_PI);
   //   trollImageView.transform = CGAffineTransformRotate(trollImageView.transform, M_PI);
   [trollView addSubview:trollImageView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
