//
//  RegistViewController.m
//  Honey
//
//  Created by Daisy on 13-11-30.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import "RegistView.h"
#import "CategoryUtils.h"
#import "PreDefine.h"

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

#pragma mark----
#pragma mark textField delegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [_firstPwdTF resignFirstResponder];
    [_secondPwdTF resignFirstResponder];
    [_accountTF resignFirstResponder];
    return YES;
}


#pragma mark ----
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



- (IBAction)registBtnPress:(id)sender {
    if (![_accountTF.text isValidateEmail]) {
        mAlertView(@"您的邮箱输入有误");
        return;
    }
    if (![_firstPwdTF.text isValidatePassword]){
        mAlertView(@"请输入6-16位字母数字的密码");
        return;
    }
    if (![_firstPwdTF.text isEqualToString:_secondPwdTF.text]) {
        mAlertView(@"您两次输入的密码不一致哦" );
        return;
    }else{
        NSLog(@"注册了啦～～");
    }
}

- (IBAction)loginBtnPress:(id)sender {
    [self removeFromSuperview];
}
@end
