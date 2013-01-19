//
//  TrollCalendarView.h
//  Troll Calendar
//
//  Created by Victor Engel on 1/18/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//
//from previous project until "default code"
//
//  TrollCalendarView.h
//  TrollCalendar
//
//  Created by Victor Engel on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "platform.h"
#import <CoreLocation/CoreLocation.h>

@interface TrollCalendarView : UIView<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager		*locationManager;

@property NSInteger NumPlatforms;

@property (strong, nonatomic) NSDate *displayedDate; // This is the date currently being displayed. When the current
                                                     // date doesn't match this date, a refresh is done and this property
                                                     // is set to the new date.
@property (nonatomic) CGPoint panStartLocation;
@property (strong, nonatomic) NSDate *gesturePerformed; //Date/time a gesture was performed. Timer will not effect any changes if there has been a gesture within the last minute.

//@property (strong, nonatomic) UIPanGestureRecognizer *panObject;

-(void)addPlatforms;
-(void)displayTheDate;

@end
CLLocationManager *locationManager;



/*default code
#import <UIKit/UIKit.h>

@interface TrollCalendarView : UIView

@end*/
