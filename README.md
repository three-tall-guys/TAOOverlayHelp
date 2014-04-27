# TAOOverlayHelp

[![Version](http://cocoapod-badges.herokuapp.com/v/TAOOverlayHelp/badge.png)](http://cocoadocs.org/docsets/TAOOverlayHelp)
[![Platform](http://cocoapod-badges.herokuapp.com/p/TAOOverlayHelp/badge.png)](http://cocoadocs.org/docsets/TAOOverlayHelp)

 Overlay HUD for showing help tips to controls on screen.
 
 The control shows a semi-transparent overlay with a message and an arrow going from the message to a point on screen. The control can be dismissed by code, or by the user tapping the overlay.
 
 ![Screenshot](https://cloud.githubusercontent.com/assets/99543/2811211/dcff19de-ce0e-11e3-8647-5405014bb594.png)

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first. Than open the workspace of the project to run the example.

To use in your projects, simply import "TAOverlayHelp.h", and call showWithHelpTip:pointAt:didDismiss: method of TAOOverlayHelp class like so:

    [TAOOverlayHelp showWithHelpTip:@"Press here to add comments to this picture"
                            pointAt:self.someButton.center
                         didDismiss:^{
        // Do something after user dismisses the help tip.
    }];

## Requirements

* Requires ARC to compile.
* Requires QuartzCore framework.

## Installation

TAOOverlayHelp is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "TAOOverlayHelp"

## Author

Three Tall Guys Ltd, hi@threetallguys.com
Or Sharir, or@threetallguys.com

## License

TAOOverlayHelp is available under the MIT license. See the LICENSE file for more info.
TAOOverlayHelp uses CGPointExtensions by cocos2d which is also available under the MIT License.

