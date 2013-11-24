//
//  SoundsPlayManger.h
//  Honey
//
//  Created by Daisy on 13-11-24.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <AudioToolbox/AudioToolbox.h>

@interface SoundPlayManager : NSObject{
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

/**
 * 初始化单例
 **/
+ (SoundPlayManager*)sharedInstance;

/**
 * @brief 根据提供的音频播放音效
 *
 */
- (void)playSoundWithName:(NSString*)name;
@end
