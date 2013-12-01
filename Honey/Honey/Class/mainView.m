//
//  mainView.m
//  Honey
//
//  Created by Daisy on 13-11-30.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import "mainView.h"
#import "FeedbackView.h"

@interface mainView()
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end


@implementation mainView

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
- (void)awakeFromNib{
    self.tabBar.delegate = self;
}

#pragma mark ----
#pragma mark tabBar delegate
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 1) {
        NSLog(@"");
    }
    if (item.tag == 2) {
        NSLog(@"");
        FeedbackView *feedbackView = [[[NSBundle mainBundle] loadNibNamed:@"FeedbackView" owner:self options:nil] objectAtIndex:0];
        [self addSubview:feedbackView];

    }
}
@end
