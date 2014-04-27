//
//  TAOArrowLayer.h
//  Here a Story
//
//  Created by Or Sharir on 11/28/13.
//  Copyright (c) 2013 TAO Project. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface TAOArrowLayer : CALayer
@property (assign, nonatomic) CGPoint start;
@property (assign, nonatomic) CGPoint end;
@property (assign, nonatomic) CGPoint by;
@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) UIColor* strokeColor;
- (void)updateDisplay;
@end
