//
//  FWViewController.m
//  Fukuwarai
//
//  Created by Hiroshi Murata on 2015/01/04.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

#import "FWViewController.h"
#import "FWPartImageView.h"
#import "FWSpeechSynthesizer.h"

@interface FWViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *baseImageView;
@property (weak, nonatomic) IBOutlet FWPartLeftEyebrowImageView *leftEyebrowImageView;
@property (weak, nonatomic) IBOutlet FWPartRightEyebrowImageView *rightEyebrowImageView;
@property (weak, nonatomic) IBOutlet FWPartLeftEyeImageView *leftEyeImageView;
@property (weak, nonatomic) IBOutlet FWPartRightEyeImageView *rightEyeImageView;
@property (weak, nonatomic) IBOutlet FWPartNoseImageView *noseImageView;
@property (weak, nonatomic) IBOutlet FWPartMouthImageView *mouthImageView;

@property (weak, nonatomic) FWPartImageView *movingView;

@end


@implementation FWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ジェスチャーの設定
    UIPanGestureRecognizer *panGestureRecognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    UIRotationGestureRecognizer *rotationGestureRecognizer =
        [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    rotationGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    
    // speechSynthesizerの設定
    [[FWSpeechSynthesizer getInstance] setupSynthesizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Touches

// UIGestureRecognizerでは touch down のイベントを扱いにくいのでこちらを使う。
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.movingView) {
        // touch down 時に操作対象の部品ビューを特定しておく。
        [self setupMovingViewWithTouches:touches];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.movingView = nil;
}


#pragma mark - Mothion

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self.leftEyebrowImageView moveRandomly];
    [self.rightEyebrowImageView moveRandomly];
    [self.leftEyeImageView moveRandomly];
    [self.rightEyeImageView moveRandomly];
    [self.noseImageView moveRandomly];
    [self.mouthImageView moveRandomly];
}


#pragma mark - Action

// 移動
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateChanged:
            
            if (!self.movingView) {
                // 部品ビュー以外の位置からドラッグを開始した場合は、部品ビューを触ったときに移動の対象にする。
                [self setupMovingViewWithGesture:recognizer];
                
                // ドラッグ開始から部品ビューが特定されるまでの移動分をクリアする。
                [recognizer setTranslation:CGPointZero inView:self.view];
            }
            
            [self.movingView handlePanGesture:recognizer];
            
            break;
            
        case UIGestureRecognizerStateEnded:
            
            self.movingView = nil;
            
            break;
            
        default:
            break;
    }
}

// 回転
- (void)handleRotationGesture:(UIRotationGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateChanged:
            
            if (!self.movingView) {
                // 部品ビュー以外の位置から回転を開始した場合は、部品ビューを触ったときに回転の対象にする。
                [self setupMovingViewWithGesture:recognizer];
                
                // 回転開始時から部品ビューが特定されるまでの回転分をクリアする。
                recognizer.rotation = 0;
            }
            
            [self.movingView handleRotationGesture:recognizer];

            break;
            
        case UIGestureRecognizerStateEnded:
            
            self.movingView = nil;
            
            break;
            
        default:
            break;
    }
}


#pragma mark - Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // ドラッグと回転を同時に行う。
    return YES;
}


#pragma mark - Private

// 移動・回転対象の部品ビューの設定
- (void)setupMovingViewWithGesture:(UIGestureRecognizer *)recognizer
{
    self.movingView = [self touchedPartImageViewWithRecognizer:recognizer];
    [self.movingView setupForMoving];
}
- (void)setupMovingViewWithTouches:(NSSet *)touches
{
    self.movingView = [self touchedPartImageViewWithTouches:touches];
    [self.movingView setupForMoving];
}

// タッチ位置の部品ビューを取得
- (FWPartImageView *)touchedPartImageViewWithRecognizer:(UIGestureRecognizer *)recognizer
{
    FWPartImageView *partImageView = nil;
    
    for (NSInteger i = 0; i < recognizer.numberOfTouches; i++) {
        CGPoint location = [recognizer locationOfTouch:i inView:self.view];
        UIView *view = [self.view hitTest:location withEvent:[[UIEvent alloc] init]];
        if ([view isKindOfClass:[FWPartImageView class]]) {
            partImageView = (FWPartImageView *)view;
            break;
        }
    }
    
    return partImageView;
}
- (FWPartImageView *)touchedPartImageViewWithTouches:(NSSet *)touches
{
    FWPartImageView *partImageView = nil;
    
    UITouch *touch = touches.anyObject;
    if ([touch.view isKindOfClass:[FWPartImageView class]]) {
        partImageView = (FWPartImageView *)touch.view;
    }
    
    return partImageView;
}


@end
