//
//  TAOViewController.m
//  TAOOverlayHelpExample
//
//  Created by Or Sharir on 4/27/14.
//  Copyright (c) 2014 Three Tall Guys. All rights reserved.
//

#import "TAOViewController.h"
#import <TAOOverlayHelp/TAOOverlayHelp.h>
@interface TAOViewController ()
-(IBAction)showHelp:(id)sender;
@end

@implementation TAOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)showHelp:(id)sender {
    UIButton* button = sender;
    [TAOOverlayHelp showWithHelpTip:@"Press this button to show a help tip for the user."
                            pointAt:button.center didDismiss:NULL];
}
@end
