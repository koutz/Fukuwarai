//
//  FWPart.h
//  Fukuwarai
//
//  Created by Hiroshi Murata on 2015/01/09.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWPart : NSObject
- (void)playTouchSE;
@end

@interface FWPartLeftEyebrow : FWPart
@end

@interface FWPartRightEyebrow : FWPart
@end

@interface FWPartLeftEye : FWPart
@end

@interface FWPartRightEye : FWPart
@end

@interface FWPartNose : FWPart
@end

@interface FWPartMouth : FWPart
@end