//
//  FlexibleFrame.h
//  WAEnhancer9
//
//  Created by iMokhles on 18/05/16.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FlexibleFrame : NSObject

- (CGFloat)ratio;
+ (CGFloat)flexibleFloat:(CGFloat)aFloat;
+ (CGRect)frameFromIphone5Frame:(CGRect)iphone5Frame;

+ (void)flexibleWithSuperView:(UIView *)superView;
+ (void)flexibleFontSizeWithSuperView:(UIView *)superView;
@end
