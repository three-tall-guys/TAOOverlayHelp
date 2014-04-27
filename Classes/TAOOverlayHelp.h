//  Created by Or Sharir on 11/14/13.
//  Copyright (c) 2013 Three Tall Guys Ltd. All rights reserved.

#import <UIKit/UIKit.h>
/**
 *  Simple block callback.
 */
typedef void (^TAOOverlayHelpCompletionBlock)(void);
/**
 *  Overlay HUD for showing help tips to controls on screen.
 *
 *  The control shows a semi-transparent overlay with a message and an arrow going from the message to a point on screen.
 *  The control can be dismissed by code, or by the user tapping the overlay.
 */
@interface TAOOverlayHelp : UIView
/**
 *  Shows the hud with the given status message and pointing to the given point.
 *
 *  It's possible to call this method multiple times before the user dismisses the overlay, forming a stack of messages,
 *  showing the next message after dismissing the last one.
 *
 *  @param status          The message to show to the user.
 *  @param point           The point on screen to which point the arrow.
 *  @param didDismissBlock A call back after the user (or by code) dismisses the overlay.
 *
 *  @return  A key identifying the message. Can be used to dismiss a specific message from the stack.
 */
+ (NSString*)showWithHelpTip:(NSString*)status pointAt:(CGPoint)point didDismiss:(TAOOverlayHelpCompletionBlock)didDismissBlock;
/**
 *  Dismiss all visible messages.
 */
+ (void)dismiss;
/**
 *  Dismiss a specific message using its key returned when creating the message.
 *
 *  @param key The key of the message.
 */
+ (void)dismiss:(NSString*)key;
/**
 *  Returns if the overlay view is currently visible.
 *
 *  @return YES if the overlay view is visible. NO overwise.
 */
+ (BOOL)isVisible;
@end
