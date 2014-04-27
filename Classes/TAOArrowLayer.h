//  Created by Or Sharir on 11/14/13.
//  Copyright (c) 2013 Three Tall Guys Ltd. All rights reserved.

#import <QuartzCore/QuartzCore.h>
/**
 *  A layer showing a curve that ends with an arrow.
 */
@interface TAOArrowLayer : CALayer
/**
 *  The starting point of the curve.
 */
@property (assign, nonatomic) CGPoint start;
/**
 *  The ending point of the curve where the arrow head is at.
 */
@property (assign, nonatomic) CGPoint end;
/**
 *  The control point of the curve. The curve passes near the point.
 */
@property (assign, nonatomic) CGPoint by;
/**
 *  The width of the line.
 */
@property (assign, nonatomic) CGFloat lineWidth;
/**
 *  The color of the line.
 */
@property (strong, nonatomic) UIColor* strokeColor;
/**
 *  Updates the visible state of the layer.
 */
- (void)updateDisplay;
@end
