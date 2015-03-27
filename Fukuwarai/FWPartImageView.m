//
//  FWPartImageView.m
//  Fukuwarai
//
//  Created by Hiroshi Murata on 2015/01/04.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

#import "FWPartImageView.h"
#import "FWPart.h"

@interface FWPartImageView () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) FWPart *part;
@end

@implementation FWPartImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _currentTransform = CGAffineTransformIdentity;
    }
    
    return self;
}

// 移動
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    // 移動した距離を取得
    CGPoint translation = [recognizer translationInView:self.superview];
    // 移動した距離だけ部品を移動させる。
    CGPoint location = CGPointMake(self.center.x + translation.x,
                                   self.center.y + translation.y);
    self.center = location;
    
    // translationInView: が返す距離は、ドラッグが始まってからの累積値となるため、ドラッグで移動した距離を初期化する。
    [recognizer setTranslation:CGPointZero inView:self.superview];
}

// 回転
- (void)handleRotationGesture:(UIRotationGestureRecognizer *)recognizer
{
    CGAffineTransform transform = CGAffineTransformRotate(self.currentTransform, recognizer.rotation);
    self.transform = transform;
}

// 移動前の設定
- (void)setupForMoving
{
    // タッチ時SE再生
    [self.part playTouchSE];
    
    // 一番手前へ移動
    [self.superview bringSubviewToFront:self];
    
    // 回転処理のために、現在のtransformプロパティを保持
    self.currentTransform = self.transform;
}

// ランダムに移動
- (void)moveRandomly
{
    CGFloat x = arc4random() % (uint32_t)self.superview.frame.size.width;
    CGFloat y = arc4random() % (uint32_t)self.superview.frame.size.height;
    CGFloat degrees = arc4random() % 360;
    CGFloat radians = (degrees / 360.0) * 2 * M_PI;
    CGAffineTransform transform = CGAffineTransformRotate(self.currentTransform, radians);
    [UIView animateWithDuration:0.25 animations:^{
        self.center = CGPointMake(x, y);
        self.transform = transform;
    }];
}

@end


@implementation FWPartLeftEyebrowImageView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.part = [[FWPartLeftEyebrow alloc] init];
    }
    
    return self;
}
@end

@implementation FWPartRightEyebrowImageView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.part = [[FWPartRightEyebrow alloc] init];
    }
    
    return self;
}
@end

@implementation FWPartLeftEyeImageView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.part = [[FWPartLeftEye alloc] init];
    }
    
    return self;
}
@end

@implementation FWPartRightEyeImageView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.part = [[FWPartRightEye alloc] init];
    }
    
    return self;
}
@end

@implementation FWPartNoseImageView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.part = [[FWPartNose alloc] init];
    }
    
    return self;
}
@end

@implementation FWPartMouthImageView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.part = [[FWPartMouth alloc] init];
    }
    
    return self;
}
@end