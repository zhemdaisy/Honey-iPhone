//
//  FeedbackView.m
//  Honey
//
//  Created by Daisy on 13-12-1.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import "FeedbackView.h"
#import "PreDefine.h"
#import "ClientSocket.h"
#import <Foundation/NSJSONSerialization.h>

@interface FeedbackView()
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)commitBtnPress:(id)sender;

@end


@implementation FeedbackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)commitBtnPress:(id)sender {
    if ([self.textView.text isEqualToString:@""]) {
        mAlertView(@"您是不是忘记写下您的宝贵意见和建议了？");
        return;
    }
    NSDictionary *dicFeedback = @{@"module": @"feedback", @"content": self.textView.text};
    NSError *error = nil;
    NSData *content = [NSJSONSerialization dataWithJSONObject:dicFeedback options:kNilOptions error:&error];
    if (error != nil) {
        NSLog(@"parase json error : %@", error);
    }
    NSNumber *len = [NSNumber numberWithInt: [content length]];
    NSDictionary *length = @{@"len": len};
    NSData *header = [NSJSONSerialization dataWithJSONObject:length options:kNilOptions error:&error];
    if (error != nil) {
        NSLog(@"parase json error : %@", error);
    }

    NSMutableData *cData = [NSMutableData dataWithData:header];
    NSData *xData = [NSData dataWithBytes:[@"*" UTF8String] length:[@"*" lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    for (; [cData length]<12; ) {
        [cData appendData:xData];
    }
    [cData appendData:content];

    [[ClientSocket sharedInstance]sendNetworkPacket:cData withTag:socketFeedback];
}
@end
