//
//  platform.h
//  Troll Calendar
//
//  Created by Victor Engel on 1/18/13.
//  Copyright (c) 2013 Victor Engel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlatformView : UIView

@property(nonatomic) NSInteger NumPlatforms;

-(void)addStone: (NSInteger)stoneNumber;
-(void)removeStones;
-(void)addWeekdayMarker;
-(void)removeWeekdayMarker;

@end
