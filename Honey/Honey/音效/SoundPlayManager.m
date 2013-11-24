//
//  SoundsPlayManger.m
//  Honey
//
//  Created by Daisy on 13-11-24.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import "SoundPlayManager.h"



@implementation SoundPlayManager

@synthesize soundFileObject;
@synthesize soundFileURLRef;


static SoundPlayManager *soundPlayManagerObj = nil;
- (id)init{
    @synchronized(self){
        self = [super init];
        
        return self;
    }
    return nil;
}
+ (SoundPlayManager*)sharedInstance{
    static SoundPlayManager *sharedSoundPlayManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedSoundPlayManager = [[self alloc]init];
    });
    return nil;
}

- (void)playSoundWithName:(NSString *)name{
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: name
                                                withExtension: @"aif"];
    
    // Store the URL as a CFURLRef instance
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (
                                      soundFileURLRef,
                                      &soundFileObject
                                      );
    AudioServicesPlaySystemSound (soundFileObject);
}

@end
