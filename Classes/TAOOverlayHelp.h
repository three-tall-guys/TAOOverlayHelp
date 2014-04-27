//
//  TAOOverlayHUD.h
//  Here a Story
//
//  Created by Or Sharir on 11/14/13.
//  Copyright (c) 2013 TAO Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAOOverlayHelp : UIView
+ (NSString*)showWithHelpTip:(NSString*)status pointAt:(CGPoint)point didDismiss:(TAOCompletionBlock)didDismissBlock;
+ (void)dismiss;
+ (void)dismiss:(NSString*)key;
+ (BOOL)isVisible;
@end
