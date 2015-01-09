//
//  FWPartImageView.h
//  Fukuwarai
//
//  Created by Hiroshi Murata on 2015/01/04.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWPartImageView : UIImageView

@property (assign, nonatomic) CGAffineTransform currentTransform;

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer;
- (void)handleRotationGesture:(UIRotationGestureRecognizer *)recognizer;
- (void)setupForMoving;

- (void)moveRandomly;

@end


@interface FWPartLeftEyebrowImageView : FWPartImageView
@end

@interface FWPartRightEyebrowImageView : FWPartImageView
@end

@interface FWPartLeftEyeImageView : FWPartImageView
@end

@interface FWPartRightEyeImageView : FWPartImageView
@end

@interface FWPartNoseImageView : FWPartImageView
@end

@interface FWPartMouthImageView : FWPartImageView
@end