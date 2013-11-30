//
//  LoginViewController.m
//  Honey
//
//  Created by Daisy on 13-11-25.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import "LoginViewController.h"
#import "PreDefine.h"
#import "RegistView.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
- (IBAction)registBtnPress:(id)sender;

@end

@implementation LoginViewController
@synthesize userName, password;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.userName.delegate = self;
    self.password.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---
#pragma mark textField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y-100);
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    self.view.center = CGPointMake(self.view.center.x, self.view.center.y+100);
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [password resignFirstResponder];
    [userName resignFirstResponder];
    return YES;
}

#pragma mark ---
#pragma mark touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    if (![password pointInside:touchPoint withEvent:event]&&![password pointInside:touchPoint withEvent:event] ) {
        [self.password resignFirstResponder];
        [self.userName resignFirstResponder];
    }
}

- (IBAction)registBtnPress:(id)sender {
    
    RegistView *registView = [[[NSBundle mainBundle] loadNibNamed:@"RegistView" owner:self options:nil] objectAtIndex:0];
    [self.view addSubview:registView];
}
@end
