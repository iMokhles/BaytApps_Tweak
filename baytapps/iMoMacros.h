//
//  iMoMacros.h
//  iMDownloader
//
//  Created by Mokhlas Hussein on 09/09/15.
//  Copyright (c) 2015 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <spawn.h>
#import <dlfcn.h>
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>
#import <Accounts/Accounts.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreGraphics/CoreGraphics.h>
#import "UIImage+Additions.h"
#import <MobileCoreServices/MobileCoreServices.h> // For UTI
#import <MessageUI/MessageUI.h>
#import "RunInBackground.h"
#import "AssetPicker.h"

#import "MBProgressHUD.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define WIDTH_FOR_ORIENTATION(orientation) (UIInterfaceOrientationIsLandscape(orientation) \
? [UIScreen mainScreen].bounds.size.height \
: [UIScreen mainScreen].bounds.size.width)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_OS_4_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_8_3_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3)

#define tweakLocalization [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0]

#define iMoAppVersionGreaterThanOrEqualTo(v)  ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define iMoAppVersionLessThanOrEqualTo(v)     ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define DWTableViewCell_ID @"DWTableViewCell"
#define FilesTableViewCell_ID @"FilesTableViewCell"
#define SettingsTableViewCell_ID @"SetingsTableViewCell"

#define iMDUserAgentChrome @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.92 Safari/537.36"
#define iMDUserAgentFirefox @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Firefox/24.0"
#define iMDUserAgentSafari @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.74.9 (KHTML, like Gecko) Version/7.0.2 Safari/537.74.9"
#define iMDUserAgentOpera @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36 OPR/20.0.1387.82"
#define iMDUserAgentIE @"Mozilla/5.0 (IE 11.0; Windows NT 6.3; Trident/7.0; .NET4.0E; .NET4.0C; rv:11.0) like Gecko"
#define iMDUserAgentiPad @"Mozilla/5.0 (iPad; CPU OS 7_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D167 Safari/9537.53"
#define iMDUserAgentiPhone @"Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D167 Safari/9537.53"
#define iMDUserAgentiPod @"Mozilla/5.0 (iPod; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D167 Safari/9537.53"

#define WeakObject(object) typeof(object) __weak
#define WeakSelf WeakObject(self)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define DefaultYellowColor RGBCOLOR_HEX(0xe7d082)
#define DefaultTitleColor RGBCOLOR(60, 60, 60)
#define DefaultBackgroundColor UIColorFromRGB(0xf5f5f5)
#define DefaultDarkBackgroundColor RGBCOLOR(29, 27, 24)

#pragma mark
#pragma mark - Log

#ifdef DEBUG
#define Log(fmt, ...) do {                                            \
NSString* file = [NSString stringWithFormat:@"%s", __FILE__]; \
NSLog((@"%@(%d) " fmt), [file lastPathComponent], __LINE__, ##__VA_ARGS__); \
} while(0)

#define LogMethod() do {                                            \
NSString* file = [NSString stringWithFormat:@"%s", __FILE__]; \
NSLog((@"%@(%d) method:%s"), [file lastPathComponent], __LINE__, __PRETTY_FUNCTION__); \
} while(0)
#else
#define Log(...)
#define LogMethod()
#endif

#pragma mark
#pragma mark - Block

#define weakSelf() __weak __typeof(self) weakSelf = self
#define strongSelf() __strong __typeof(weakSelf) strongSelf = weakSelf
#define blockSelf() __block __typeof(self) blockSelf = self

#pragma mark
#pragma mark - Version

#define OSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define YDAvalibleOS(os_version) OSVersion >= os_version

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <  568.0)
#define IS_IPHONE_5         (IS_IPHONE && fabs((double)SCREEN_MAX_LENGTH - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6         (IS_IPHONE && fabs((double)SCREEN_MAX_LENGTH - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6P        (IS_IPHONE && fabs((double)SCREEN_MAX_LENGTH - (double)736) < DBL_EPSILON)

#pragma mark
#pragma mark - Singleton

#define DECLARE_SHARED_INSTANCE  \
+ (instancetype)sharedInstance;


#define IMPLEMENT_SHARED_INSTANCE \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t onceToken; \
static id sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[[self class] alloc] init]; \
}); \
return sharedInstance; \
}

#pragma mark
#pragma mark - UI

#define px (1.0 / [UIScreen mainScreen].scale)

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define RGBCOLOR_HEX(h) RGBCOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF))
#define RGBACOLOR_HEX(h,a) RGBACOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF), (a))
#define RGBPureColor(h) RGBCOLOR(h, h, h)

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

#define RGBA(r,g,b,a) (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)

#define SystemFontWithSize(size) [UIFont systemFontOfSize:size]
#define SystemBoldFontWithSize(size) [UIFont boldSystemFontOfSize:size]

#pragma mark
#pragma mark - Image

#define LAUNCH_IMAGE_IPHONE4  @"LaunchImage-700"
#define LAUNCH_IMAGE_IPHONE5  @"LaunchImage-700-568h"
#define LAUNCH_IMAGE_IPHONE6  @"LaunchImage-800-667h"
#define LAUNCH_IMAGE_IPHONE6P @"LaunchImage-800-Portrait-736h"

#pragma mark
#pragma mark - Frame

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#pragma mark
#pragma mark - Time

#define aDay 60.0 * 60.0 * 24.0
#define aWeek aDay * 7.0


#define ACTIVITY_LOADING_TEXT_COMPRESSING @"Compressing..."
#define ACTIVITY_LOADING_TEXT_FETCHING_DATA @"Fetching data..."
#define ACTIVITY_LOADING_TEXT_LOADING @"Loading..."
#define ACTIVITY_LOADING_TEXT_MERGING @"Merging..."
#define ACTIVITY_LOADING_TEXT_FETCHING_VERSE @"Fetching verse..."
#define ACTIVITY_LOADING_TEXT_SAVING @"Saving..."
#define ACTIVITY_LOADING_TEXT_SIGNING_IN @"Signing In..."
#define ACTIVITY_LOADING_TEXT_TRIMMING @"Trimming..."

#define kMenuIconSize   72

