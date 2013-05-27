//
//  ViewController.m
//  ASSwitchExample
//
//  Created by عبدالرحمن شاتو on 5/26/13.
//  Copyright (c) 2013 Shatou. All rights reserved.
//

#import "ViewController.h"
#import "ASSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    ASSwitch *aSwitch = [[ASSwitch alloc] initWithFrame:CGRectMake(115,
                                                                   140,
                                                                   0,
                                                                   0)];
    
    [aSwitch setOnLabelText:@":-)" offLabelText:@":-("];
    [aSwitch setOn:YES animated:NO];
    
    [aSwitch addTarget:self
                action:@selector(switchChangedValue:)
      forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:aSwitch];
    
}

- (void)viewDidUnload {
    [self setSwitchStatusLabel:nil];
    [super viewDidUnload];
}

#pragma mark - Switch Action

- (void) switchChangedValue:(ASSwitch *) aSwitch {
    
    self.switchStatusLabel.text = aSwitch.onState ? @"Switch is On!":@"Switch is Off!!";
    
}

@end
