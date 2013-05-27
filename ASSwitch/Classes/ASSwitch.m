//
//  ASSwitch.m
//  ESA_PC_ASSwitch
//
//  Created by عبدالرحمن شاتو on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ASSwitch.h"
#import "ASSwitchDefinitions.h"

@interface ASSwitch ()

@property (nonatomic, retain) UILabel *onTextLabel;
@property (nonatomic, retain) UILabel *offTextLabel;
@property (nonatomic, retain) UIImageView *toggleImageView;
@property (nonatomic, retain) UIImageView *frameImageView;
@property (nonatomic) BOOL draggingToggle;

@end

@implementation ASSwitch

#pragma mark - Initialization

- (id)init {
    
    self = [self initWithFrame:CGRectZero];
    return self;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self fixSelfFrameWithFrameImage:[UIImage imageNamed:S_IMAGE_FRAME]];
        [self placeUIElements];
        [self addSingleTapRecognizer];
        self.clipsToBounds = YES;
        self.onState = NO;
        self.draggingToggle = NO;
        
    }
    
    return self;
    
}

- (void) fixSelfFrameWithFrameImage:(UIImage *)frameImage {
    
    CGRect frame = self.frame;
    frame.size.width = frameImage.size.width;
    frame.size.height = frameImage.size.height;
    self.frame = frame;
    
}

- (void) placeUIElements {
    
    [self placeToggleWithToggleImage:[UIImage imageNamed:S_IMAGE_TOGGLE]];
    [self placeOnTextLabel];
    [self placeOffTextLabel];
    [self placeBackgroundFrameWithFrameImage:[UIImage imageNamed:S_IMAGE_FRAME]];
    
}

- (void) placeBackgroundFrameWithFrameImage:(UIImage *)frameImage {
    
    if (self.frameImageView == nil) {
        self.frameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(C_ORIGIN_ZERO,
                                                                            C_ORIGIN_ZERO,
                                                                            frameImage.size.width,
                                                                            frameImage.size.height)];
        [self addSubview:self.frameImageView];
    }
    
    self.frameImageView.image = frameImage;
    
}

- (void) placeOnTextLabel {
    
    self.onTextLabel = [[UILabel alloc] initWithFrame:CGRectMake((C_TOGGLE_SECTION_WIDTH + C_TOGGLE_MODIFIER_FOR_STROKE_COMPENSATION - C_LABEL_SWITCH_WIDTH) / 2,
                                                                  (C_TOGGLE_SECTION_HEIGHT - C_LABEL_SWITCH_HEIGHT) / 2,
                                                                  C_LABEL_SWITCH_WIDTH,
                                                                  C_LABEL_SWITCH_HEIGHT)];
    
    self.onTextLabel.text = S_LABEL_DEFAULT_ON;
    [self prepareSwitchTextLabel:self.onTextLabel];
    [self.toggleImageView addSubview:self.onTextLabel];
    
    
}

- (void) placeOffTextLabel {
    
    self.offTextLabel = [[UILabel alloc] initWithFrame:CGRectMake((2.5 * C_TOGGLE_SECTION_WIDTH) + C_TOGGLE_MODIFIER_FOR_STROKE_COMPENSATION - (C_LABEL_SWITCH_WIDTH / 2),
                                                                   (C_TOGGLE_SECTION_HEIGHT - C_LABEL_SWITCH_HEIGHT) / 2,
                                                                   C_LABEL_SWITCH_WIDTH,
                                                                   C_LABEL_SWITCH_HEIGHT)];
    
    self.offTextLabel.text = S_LABEL_DEFAULT_OFF;
    [self prepareSwitchTextLabel:self.offTextLabel];
    [self.toggleImageView addSubview:self.offTextLabel];
    
}

- (void) placeToggleWithToggleImage:(UIImage *)toggleImage {
    
    if (self.toggleImageView == nil) {
        self.toggleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-C_TOGGLE_SECTION_WIDTH,
                                                                             C_ORIGIN_ZERO,
                                                                             toggleImage.size.width,
                                                                             toggleImage.size.height)];
        [self addSubview:self.toggleImageView];
    }
    
    self.toggleImageView.image = toggleImage;
    
}

- (void) prepareSwitchTextLabel:(UILabel *)textLabel {
    
    textLabel.textAlignment = UITextAlignmentCenter;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont boldSystemFontOfSize:C_LABEL_FONT_SIZE];
    textLabel.minimumFontSize = C_LABEL_FONT_MINIMUM_SIZE;
    textLabel.adjustsFontSizeToFitWidth = YES;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.shadowColor = [UIColor blackColor];
    textLabel.shadowOffset = CGSizeMake(C_SHADOW_X,
                                        C_SHADOW_Y);
    
}

- (void) addSingleTapRecognizer {
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(switchState:)];
    tapRecognizer.delaysTouchesEnded = NO;
    tapRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapRecognizer];
    
}

#pragma mark - Description

- (NSString *) description {
    
    return [NSString stringWithFormat:@"%@, Switch State: %@, Switch Off Label: %@, Switch On Label: %@",
            [super description],
            self.onState? @"Yes":@"No",
            self.offTextLabel.text,
            self.onTextLabel.text];
    
}

#pragma mark - On State

- (void) setOnState:(BOOL)onState {
    
    [self setOn:onState animated:YES];
    
}


#pragma mark - User Methods

- (void) setOn:(BOOL)on
      animated:(BOOL)animated {
    
    if (self.onState && on) {
        return;
    }
    
    if (!self.onState && !on) {
        return;
    }
    
    if (animated) {
        [self changeStateWithAnimation];
    } else {
        [self changeStateNoAnimation];
    }
    
    _onState = on;
    
}

- (void) changeStateWithAnimation {
    
    CGRect movableToggleFrame = self.toggleImageView.frame;
    
    if (!self.onState) {
        movableToggleFrame.origin.x = 0;
    } else {
        movableToggleFrame.origin.x = - C_TOGGLE_SECTION_WIDTH;
    }
    
    [UIView animateWithDuration:C_ANIMATION_DURATION
                     animations:^{
                         
                         self.toggleImageView.frame = movableToggleFrame;
                         
                     }];
    
}

- (void) changeStateNoAnimation {
    
    CGRect movableToggleFrame = self.toggleImageView.frame;
    
    if (!self.onState) {
        movableToggleFrame.origin.x = 0;
        self.onState = YES;
    } else {
        movableToggleFrame.origin.x = - C_TOGGLE_SECTION_WIDTH;
        self.onState = NO;
    }
    
    self.toggleImageView.frame = movableToggleFrame;
    
}

- (void) setOnLabelText:(NSString *)onText
           offLabelText:(NSString *)offText {
    
    if (onText) {
        self.onTextLabel.text = onText;
    }
    
    if (offText) {
        self.offTextLabel.text = offText;
    }
    
}

- (void) setOnLabelTextColor:(UIColor *)onLabelTextColor {
    
    self.onTextLabel.textColor = onLabelTextColor ? onLabelTextColor:[UIColor whiteColor];
    
}

- (void) setOffLabelTextColor:(UIColor *)offLabelTextColor {
    
    self.offTextLabel.textColor = offLabelTextColor ? offLabelTextColor:[UIColor whiteColor];
    
}

- (void) setSwitchFrameImage:(UIImage *)switchFrameImage {
    
    if (switchFrameImage == nil) return;
    
    [self placeBackgroundFrameWithFrameImage:switchFrameImage];
    
}

- (void) setSwitchToggleImage:(UIImage *)switchToggleImage {
    
    if (switchToggleImage == nil) return;
    
    [self placeToggleWithToggleImage:switchToggleImage];
    
}

#pragma mark - Touch Events

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    self.draggingToggle = NO;
    
    self.toggleImageView.image = [UIImage imageNamed:S_IMAGE_TOGGLE_SELECTED];
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    self.draggingToggle = YES;
    
    UITouch *aTouch = [touches anyObject];
    CGPoint currentLocation = [aTouch locationInView:self];
    CGPoint previousLocation = [aTouch previousLocationInView:self];
    
    CGRect movableToggleFrame = self.toggleImageView.frame;
    
    float deltaX = currentLocation.x - previousLocation.x;
    
    movableToggleFrame.origin.x += deltaX;
    
    if (deltaX < 0) {
        if (movableToggleFrame.origin.x < -C_TOGGLE_SECTION_WIDTH) {
            movableToggleFrame.origin.x = -C_TOGGLE_SECTION_WIDTH;
        }
        
    } else {
        if (movableToggleFrame.origin.x > 0) {
            movableToggleFrame.origin.x = 0;
        }
        
    }
    
    self.toggleImageView.frame = movableToggleFrame;
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    self.toggleImageView.image = [UIImage imageNamed:S_IMAGE_TOGGLE];
    
    CGRect movableToggleFrame = self.toggleImageView.frame;
    
    if (!self.onState) {
        
        if (movableToggleFrame.origin.x >= -C_TOGGLE_SECTION_WIDTH / 2) {
            [self setStatus:YES];
            movableToggleFrame.origin.x = 0;
            
        } else {
            movableToggleFrame.origin.x = -C_TOGGLE_SECTION_WIDTH;
            
        }
        
        [UIView animateWithDuration:C_ANIMATION_DURATION
                         animations:^{
                             self.toggleImageView.frame = movableToggleFrame;
                             
                         }];
        
    } else {
        
        if (movableToggleFrame.origin.x <= -C_TOGGLE_SECTION_WIDTH / 2) {
            [self setStatus:NO];
            movableToggleFrame.origin.x = -C_TOGGLE_SECTION_WIDTH;
            
        } else {
            movableToggleFrame.origin.x = 0;
            
        }
        
        [UIView animateWithDuration:C_ANIMATION_DURATION
                         animations:^{
                             
                             self.toggleImageView.frame = movableToggleFrame;
                             
                         }];
        
    }
    
}

#pragma mark - Gesture Recognizer

- (void) switchState:(UITapGestureRecognizer *)recognizer {
    
    if (self.draggingToggle) {
        return;
    }
    
    self.toggleImageView.image = [UIImage imageNamed:S_IMAGE_TOGGLE];
    [self changeStateWithAnimation];
    [self setStatus:!self.onState];
    
}

#pragma mark - Setting Current State

- (void) setStatus:(BOOL)status {
    
    self.onState = status;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

@end
