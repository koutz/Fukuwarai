//
//  FWSpeechSynthesizer.h
//  Fukuwarai
//
//  Created by Hiroshi Murata on 2015/01/10.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@interface FWSpeechSynthesizer : NSObject

+ (id)getInstance;

- (void)setupSynthesizer;
- (BOOL)stopSpeakingAtBoundary:(AVSpeechBoundary)boundary;
- (void)speakUtterance:(AVSpeechUtterance *)utterance;

@end
