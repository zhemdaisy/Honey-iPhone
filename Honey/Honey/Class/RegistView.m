//
//  RegistViewController.m
//  Honey
//
//  Created by Daisy on 13-11-30.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import "RegistView.h"
#import "CategoryUtils.h"

@interface RegistView ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *firstPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *secondPwdTF;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
- (IBAction)registBtnPress:(id)sender;

- (IBAction)loginBtnPress:(id)sender;

@end

@implementation RegistView


- (void)awakeFromNib{
    self.accountTF.delegate = self;
    self.firstPwdTF.delegate = self;
    self.secondPwdTF.delegate = self;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _accountTF) {
        if ([textField.text isValidateEmail]) {
            _registBtn.enabled = NO;
        }
    }
    if (textField == _firstPwdTF) {
        if ([textField.text isValidatePassword]) {
            _registBtn.enabled = NO;
        }
    }
    if (textField == _secondPwdTF) {
        if ([textField.text isValidatePassword]) {
            _registBtn.enabled = NO;
        }
    }
}
#pragma mark ---
#pragma mark touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if (![_accountTF pointInside:touchPoint withEvent:event]&&![_firstPwdTF pointInside:touchPoint withEvent:event]&& ![_secondPwdTF pointInside:touchPoint withEvent:event]) {
        [_accountTF resignFirstResponder];
        [_secondPwdTF resignFirstResponder];
        [_firstPwdTF resignFirstResponder];
    }
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [_firstPwdTF resignFirstResponder];
    [_secondPwdTF resignFirstResponder];
    [_accountTF resignFirstResponder];
    return YES;
}



- (IBAction)registBtnPress:(id)sender {
    NSLog(@"注册了啦～～");
}

- (IBAction)loginBtnPress:(id)sender {
    [self removeFromSuperview];
}
@end
