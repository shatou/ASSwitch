# ASSwitch

## Overview

**AASwitch** is UIControl element that provides the basic functionality of UISwitch + full customization of the switch appearence including on/off image and on/off labels.

## How to Use

####- Initialization
You simply create the switch as following:

  ASSwitch *aSwitch = [[ASSwitch alloc] initWithFrame:CGRectMake(115, 140, 0, 0)];

You don't need to specify a width or height for the switch, it will adopt itself to the switch frame image

#### - Switch Images
Two images shall be supplied for each switch. The switch frame image (the one with dark gray stroke in the example project). And the switch toggle image (the one with on-off image combined in one image). You must divide the latter into three equal sections - one for on image, one for the toggle head and one for off image. If you didn't provide any images, the default ones will be used (And I believe they look good too :).

You can set the images of the switch at runtime using:

	- (void) setSwitchFrameImage:(UIImage *)switchFrameImage;
	- (void) setSwitchToggleImage:(UIImage *)switchToggleImage;
	
Please, keep in mind there is neither "on-image" nor "off-image" as in UISwitch. It's only one image containing both states. This saves time and resources. The toggle image includes both states.	

####- Switch On/Off Labels
You can set the off and on labels of the switch using:

	[aSwitch setOnLabelText:@":-)" offLabelText:@":-("];
	
"On" and "Off" are used as default labels for the switch on and off states, respectively. 

You can also change the colors of the labels if you want to provide a better color contrast with toggle image using:

	- (void) setOnLabelTextColor:(UIColor *)onLabelTextColor;
	- (void) setOffLabelTextColor:(UIColor *)onLabelTextColor;

You cannot, however, change the other label attributes directly from code. This is to ensure that the labels frames, font, font size…etc will work as expected. However, you can tweak some of them using the file ASSwitchDefinitions.h. In this file you will find default settings for:

	#define C_SHADOW_X 0.0
	#define C_SHADOW_Y 1.0

	#define C_LABEL_FONT_MINIMUM_SIZE 11
	#define C_LABEL_FONT_SIZE 14

####- Switch Action
Since ASSwitch is a subclass of UISwitch, you simply add a target for it in the same way you deal with any UIControl:

	[aSwitch addTarget:self
                action:@selector(switchChangedValue:)
      forControlEvents:UIControlEventValueChanged];
      
####- Adding Switch to View      
Finally, add the switch to the whatever view using:

	[self.view addSubview:aSwitch];
	
ASSwitch supports ARC. **Do not release the switch after creating adding it to a parent view.**
