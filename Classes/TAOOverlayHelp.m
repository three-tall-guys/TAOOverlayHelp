//
//  TAOOverlayHUD.m
//  Here a Story
//
//  Created by Or Sharir on 11/14/13.
//  Copyright (c) 2013 TAO Project. All rights reserved.
//

#import "TAOOverlayHelp.h"
#import "TAOArrowLayer.h"
#import "CGPointExtension.h"
@interface TAOOverlayHelp ()
@property (strong, nonatomic) TAOArrowLayer* arrowLayer;
@property (strong, nonatomic) UILabel * textLabel;
@property (strong, nonatomic) TAOOverlayHelpCompletionBlock didDismissBlock;
@property (strong, nonatomic) NSMutableArray* statusMessages;
@property (strong, nonatomic) NSMutableArray* pointAtArray;
@property (strong, nonatomic) NSMutableArray* didDismissBlockArray;
@end

@implementation TAOOverlayHelp

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.alpha = 0;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont systemFontOfSize:24];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.numberOfLines = 0;
        [self.textLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.textLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self addSubview:self.textLabel];
        
        
        self.arrowLayer = [[TAOArrowLayer alloc] init];
        self.arrowLayer.frame = self.layer.bounds;
        self.arrowLayer.strokeColor = [UIColor whiteColor];
        self.arrowLayer.lineWidth = 3;
        [self.layer addSublayer:self.arrowLayer];
        
        self.statusMessages = [NSMutableArray array];
        self.pointAtArray = [NSMutableArray array];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        [self setNeedsLayout];
    }
    return self;
}
- (void)updateConstraints {
    NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint* centerX = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint* marginLeft = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
    NSLayoutConstraint* marginRight = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30];
    [self addConstraints:@[centerX, centerY, marginLeft, marginRight]];
    
    [super updateConstraints];
}
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
- (CGSize)intrinsicContentSize {
    return [UIScreen mainScreen].bounds.size;
}
+ (TAOOverlayHelp*)sharedView {
    static dispatch_once_t once;
    static TAOOverlayHelp *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedView;
}
+ (NSArray*)fillSuperviewConstraintsForView:(UIView*)view {
    if (!view.superview) {
        return @[];
    }
    NSArray* attributes = @[@(NSLayoutAttributeLeft), @(NSLayoutAttributeRight), @(NSLayoutAttributeTop), @(NSLayoutAttributeBottom)];
    NSMutableArray* constraints = [NSMutableArray arrayWithCapacity:attributes.count];
    for (NSNumber* attribute in attributes) {
        NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:view attribute:[attribute integerValue] relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:view.superview attribute:[attribute integerValue] multiplier:1 constant:0];
        [constraints addObject:constraint];
    }
    return [constraints copy];
}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview) {
        [self.superview addConstraints:[TAOOverlayHelp fillSuperviewConstraintsForView:self]];
    }
}
+ (NSString*)showWithHelpTip:(NSString*)status pointAt:(CGPoint)point didDismiss:(TAOOverlayHelpCompletionBlock)didDismissBlock{
    if (!status || status.length == 0) return nil;
    
    NSUInteger index = NSNotFound;
    if ([status isEqualToString:[[self sharedView].statusMessages lastObject]]) {
        return status;
    } else if ((index = [[self sharedView].statusMessages indexOfObject:status]) != NSNotFound) {
        [[self sharedView].statusMessages removeObjectAtIndex:index];
        [[self sharedView].pointAtArray removeObjectAtIndex:index];
        [[self sharedView].didDismissBlockArray removeObjectAtIndex:index];
    }
    
    [[self sharedView].statusMessages addObject:status];
    [[self sharedView].pointAtArray addObject:[NSValue valueWithCGPoint:point]];
    if (!didDismissBlock) {
        didDismissBlock = ^{};
    }
    [[self sharedView].didDismissBlockArray addObject:didDismissBlock];
    
    [[self sharedView] showWithHelpTip:status pointAt:point didDismiss:didDismissBlock];
    return status;
}
- (void)showWithHelpTip:(NSString*)status pointAt:(CGPoint)point didDismiss:(TAOOverlayHelpCompletionBlock)didDismissBlock {
    if(!self.superview){
        NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
        
        for (UIWindow *window in frontToBackWindows)
            if (window.windowLevel == UIWindowLevelNormal) {
                [window addSubview:self];
                break;
            }
    }
    
    self.textLabel.text = status;
    self.didDismissBlock = didDismissBlock;
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
    
    self.arrowLayer.end = point;
    
    CGPoint directionFromCenter = CGPointSub(point, CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)));
    double angle = CGPointToAngle(directionFromCenter);
    double byPointSign = 0;
    if (angle >= 0 && angle < M_PI_2) {
        self.arrowLayer.start = CGPointMake(CGRectGetMaxX(self.textLabel.frame), CGRectGetMaxY(self.textLabel.frame));
        byPointSign = -1;
    } else if (angle >= M_PI_2 && angle < M_PI) {
        self.arrowLayer.start = CGPointMake(CGRectGetMinX(self.textLabel.frame), CGRectGetMaxY(self.textLabel.frame));
        byPointSign = 1;
    } else if (angle < 0 && angle > -M_PI_2) {
        self.arrowLayer.start = CGPointMake(CGRectGetMaxX(self.textLabel.frame), CGRectGetMinY(self.textLabel.frame));
        byPointSign = 1;
    } else {
        self.arrowLayer.start = CGPointMake(CGRectGetMinX(self.textLabel.frame), CGRectGetMinY(self.textLabel.frame));
        byPointSign = -1;
    }
    
    CGPoint v = CGPointNormalize(CGPointRotateWithAngle(CGPointSub(self.arrowLayer.end, self.arrowLayer.start), M_PI_2));
    self.arrowLayer.by = CGPointAdd(CGPointMidpoint(self.arrowLayer.start, self.arrowLayer.end), CGPointMult(v, byPointSign*60));
    [self.arrowLayer updateDisplay];
    [self setNeedsDisplay];
    if(self.alpha != 1) {
        [UIView animateWithDuration:0.3
                              delay:0.1
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             self.alpha = 1;
                         }
                         completion:^(BOOL finished){
                             UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, nil);
                             UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, status);
                         }];
        
        [self setNeedsDisplay];
    }

}
- (void)dismiss {
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         if(self.alpha == 0) {
                             self.alpha = 0;
                             
                             [self removeFromSuperview];
                             
                             UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, nil);
                             
                            // Tell the rootViewController to update the StatusBar appearance
                             UIViewController *rootController = [[UIApplication sharedApplication] keyWindow].rootViewController;
                             if ([rootController respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
                                 [rootController setNeedsStatusBarAppearanceUpdate];
                             }
                         }
                     }];
}
- (void)tapView:(UITapGestureRecognizer*)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [TAOOverlayHelp dismiss];
    }
}
+ (void)dismiss {
    [[self sharedView].statusMessages removeLastObject];
    [[self sharedView].pointAtArray removeLastObject];
    [[self sharedView].didDismissBlockArray removeLastObject];
    TAOOverlayHelpCompletionBlock block = [self sharedView].didDismissBlock;
    if (block) {
        [self sharedView].didDismissBlock = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
    if ([self sharedView].statusMessages.count == 0 && [self isVisible]) {
        [[self sharedView] dismiss];
    }
    if ([self sharedView].statusMessages.count > 0) {
        [[self sharedView] showWithHelpTip:[[self sharedView].statusMessages lastObject] pointAt:[[[self sharedView].pointAtArray lastObject] CGPointValue] didDismiss:[[self sharedView].didDismissBlockArray lastObject]];
    }
}
+ (void)dismiss:(NSString*)key {
    if (!key) return;
    NSUInteger index = [[self sharedView].statusMessages indexOfObject:key];
    if (index == NSNotFound) return;
    [[self sharedView].statusMessages removeObjectAtIndex:index];
    [[self sharedView].pointAtArray removeObjectAtIndex:index];
    [[self sharedView].didDismissBlockArray removeObjectAtIndex:index];
    TAOOverlayHelpCompletionBlock block = [self sharedView].didDismissBlock;
    if (block) {
        [self sharedView].didDismissBlock = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
    if ([self sharedView].statusMessages.count == 0 && [self isVisible]) {
        [[self sharedView] dismiss];
    }
    if ([self sharedView].statusMessages.count > 0) {
        [[self sharedView] showWithHelpTip:[[self sharedView].statusMessages lastObject] pointAt:[[[self sharedView].pointAtArray lastObject] CGPointValue] didDismiss:[[self sharedView].didDismissBlockArray lastObject]];
    }
}
+ (BOOL)isVisible {
    return ([self sharedView].alpha == 1);
}

@end
