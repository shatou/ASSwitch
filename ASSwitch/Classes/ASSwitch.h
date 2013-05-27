//
//  ASSwitch.h
//  ESA_PC_ASSwitch
//
//  Created by عبدالرحمن شاتو on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASSwitch : UIControl 

@property (nonatomic) BOOL onState;

- (void) setOn:(BOOL)on animated:(BOOL)animated;

- (void) setOnLabelText:(NSString *)onText offLabelText:(NSString *)offText;
- (void) setOnLabelTextColor:(UIColor *)onLabelTextColor;
- (void) setOffLabelTextColor:(UIColor *)onLabelTextColor;

- (void) setSwitchFrameImage:(UIImage *)switchFrameImage;
- (void) setSwitchToggleImage:(UIImage *)switchToggleImage;


@end
