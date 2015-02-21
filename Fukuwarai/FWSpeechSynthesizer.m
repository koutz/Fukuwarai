//
//  FWSpeechSynthesizer.m
//  Fukuwarai
//
//  Created by Hiroshi Murata on 2015/01/10.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

#import "FWSpeechSynthesizer.h"

static FWSpeechSynthesizer *_instance = nil;

@interface FWSpeechSynthesizer () <AVSpeechSynthesizerDelegate>
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@end

@implementation FWSpeechSynthesizer

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (id)getInstance {
	return _instance;
}

- (void)setupSynthesizer
{
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    _synthesizer.delegate = self;
}

- (BOOL)stopSpeakingAtBoundary:(AVSpeechBoundary)boundary
{
    return [self.synthesizer stopSpeakingAtBoundary:boundary];
}

- (void)speakUtterance:(AVSpeechUtterance *)utterance
{
    [self.synthesizer speakUtterance:utterance];
}

@end
