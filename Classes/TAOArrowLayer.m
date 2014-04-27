//
//  TAOArrowLayer.m
//  Here a Story
//
//  Created by Or Sharir on 11/28/13.
//  Copyright (c) 2013 TAO Project. All rights reserved.
//

#import "TAOArrowLayer.h"
#import "CGPointExtension.h"
@interface TAOArrowLayer ()
@property (strong, nonatomic) CAShapeLayer* arrowShape;
@end

@implementation TAOArrowLayer
- (id)init
{
    self = [super init];
    if (self) {
        self.arrowShape = [[CAShapeLayer alloc] init];
        self.arrowShape.frame = self.bounds;
        [self addSublayer:self.arrowShape];
        self.start = CGPointMake(0,0);
        self.end = self.start;
        self.strokeColor = [UIColor blackColor];
        self.lineWidth = 1;
    }
    return self;
}
- (void)layoutSublayers {
    [super layoutSublayers];
    self.arrowShape.frame = self.bounds;
}
- (void)updateDisplay {
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:self.start];
    [path addQuadCurveToPoint:self.end controlPoint:self.by];
    CGPoint v = CGPointMult(CGPointNormalize(CGPointSub(self.by, self.end)), 15);
    [path addLineToPoint:CGPointAdd(self.end, CGPointRotateWithAngle(v, 0.5))];
    [path moveToPoint:self.end];
    [path addLineToPoint:CGPointAdd(self.end, CGPointRotateWithAngle(v, -0.5))];
    self.arrowShape.path = [path CGPath];
    self.arrowShape.strokeColor = [self.strokeColor CGColor];
    self.arrowShape.fillColor = [[UIColor clearColor] CGColor];
    self.arrowShape.lineWidth = self.lineWidth;
    self.arrowShape.lineJoin = kCALineJoinRound;
    self.arrowShape.lineCap = kCALineCapRound;
}
//- (void)display {
//    [super display];
//    [self updateDisplay];
//}
@end
