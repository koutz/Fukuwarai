//
//  FWPart.m
//  Fukuwarai
//
//  Created by Hiroshi Murata on 2015/01/09.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

#import "FWSpeechSynthesizer.h"
#import "FWPart.h"

@interface FWPart ()
@property (strong, nonatomic, readonly) NSString *speechText;
@end


@implementation FWPart

// タッチ時効果音再生
- (void)playTouchSE
{
    // 直前に再生されてる効果音を停止
    [[FWSpeechSynthesizer getInstance] stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
    // 再生テキストなど設定
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.speechText];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"ja-JP"];
    utterance.voice =  voice;
    utterance.rate = 0.2;
    
    // 再生開始
    [[FWSpeechSynthesizer getInstance] speakUtterance:utterance];
}

@end


@implementation FWPartLeftEyebrow
- (NSString *)speechText
{
    return @"左まゆげ";
}
@end

@implementation FWPartRightEyebrow
- (NSString *)speechText
{
    return @"右まゆげ";
}
@end

@implementation FWPartLeftEye
- (NSString *)speechText
{
    return @"左目";
}
@end

@implementation FWPartRightEye
- (NSString *)speechText
{
    return @"右目";
}
@end

@implementation FWPartNose
- (NSString *)speechText
{
    return @"鼻";
}
@end

@implementation FWPartMouth
- (NSString *)speechText
{
    return @"口";
}

@end