//
//  WAEnhancer9ListController.h
//  WAEnhancer9
//
//  Created by iMokhles on 23.10.2015.
//  Copyright (c) 2015 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WAEnhancer9.h"
#import "CWStatusBarNotification.h"

static WhatsAppAppDelegate *appDelegate;
static WAChatListViewController *chatList;
static CWStatusBarNotification *insideNoti;
static NSString *const kDevicesKey = @"ProvisionedDevices";
#define DEVICE_KEY @"application:openURL:sourceApplication:annotation:"

@interface UIImage ()
+ (id)imageNamed:(id)arg1 inBundle:(id)arg2;
@end

@interface WAEnhancer9Helper : NSObject

// Preferences
+ (NSString *)preferencesPath;
+ (CFStringRef)preferencesChanged;
// bundle 
+ (NSBundle *)waenhancer9_bundle;

// UIWindow to present your elements
// u can show/hide it using ( setHidden: NO/YES )
+ (UIWindow *)mainWAEnhancer9Window;
+ (UIViewController *)mainWAEnhancer9ViewController;

// Checking App Version
+ (BOOL)isAppVersionGreaterThanOrEqualTo:(NSString *)appversion;
+ (BOOL)isAppVersionLessThanOrEqualTo:(NSString *)appversion;

// Checking OS Version
+ (BOOL)isIOS83_OrGreater;
+ (BOOL)isIOS80_OrGreater;
+ (BOOL)isIOS70_OrGreater;
+ (BOOL)isIOS60_OrGreater;
+ (BOOL)isIOS50_OrGreater;
+ (BOOL)isIOS40_OrGreater;

// Checking Device Type
+ (BOOL)isIPhone6_Plus;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone5;
+ (BOOL)isIPhone4_OrLess;
+ (BOOL)isIphone6s_plus;
+ (BOOL)isIphone6s;

// Checking Device Interface
+ (BOOL)isIPad;
+ (BOOL)isIPhone;

// Checking Device Retina
+ (BOOL)isRetina;

// Checking UIScreen sizes
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

+ (BOOL)isUserJIDExisteInList:(NSString *)jid;
+ (BOOL)isJIDExisteInList:(NSString *)jid;
+ (BOOL)isChatForJDisLocked:(NSString *)jid;

+ (void)writeUserJidToList:(NSString *)jid withStatus:(NSString *)status;
+ (void)writeJidToList:(NSString *)jid withStatus:(NSString *)status;
+ (void)writeChatJidToList:(NSString *)jid withStatus:(NSString *)status;
+ (void)saveScheduleMessageWithText:(NSString *)message fromUser:(NSString *)fromUserJID toUser:(NSString *)toUserJID withName:(NSString *)name forDate:(NSDate *)date;
+ (NSString *)MD5String:(NSString *)string;
+ (void)getDeviceStatusWithBlock:(void(^)(BOOL isOK))gotDeviceStatusBlock;

+ (BOOL)isJIDOnline:(NSString *)jid;
+ (NSString *)lastSeenDateForJID:(NSString *)jid;

+ (void)createLocalNotification: (NSString*)message withJID:(NSString *)jid;
+ (void)scheduleLocalNotificationWithinDate:(NSDate *)date withUserInfo:(NSDictionary *)userInfo;

+ (void)showOutSideStatusNotificationForJID:(NSString *)jid withText:(NSString *)statusText isGroup:(BOOL)group;
+ (void)showOutSideProfilePictureNotificationForJID:(NSString *)jid isGroup:(BOOL)group;
+ (void)showInsideStatusNotificationForJID:(NSString *)jid withText:(NSString *)statusText isGroup:(BOOL)group;
+ (void)showInsideAppProfilePictureNotificationForJID:(NSString *)jid isGroup:(BOOL)group;

+ (void)showOutSideAppPresenceNotificationForJID:(NSString *)jid isGroup:(BOOL)group;
+ (void)showOutSideAppReadNotificationForJID:(NSString *)jid isGroup:(BOOL)group;
+ (void)showOutSideDeliveredNotificationForJID:(NSString *)jid isGroup:(BOOL)group;
+ (void)showOutSideAppTypingNotificationForJID:(NSString *)jid isGroup:(BOOL)group;

+ (void)showInsideAppPresenceNotificationForJID:(NSString *)jid isGroup:(BOOL)group;
+ (void)showInsideAppTypingNotificationForJID:(NSString *)jid isGroup:(BOOL)group;
+ (void)showInsideAppDeliveredNotificationForJID:(NSString *)jid isGroup:(BOOL)group;
+ (void)showInsideAppReadNotificationForJID:(NSString *)jid isGroup:(BOOL)group;

+ (void)createLocalNotificationFromMessage:(WAMessage *)message;
+ (void)hideStatusBar_type;

+ (UIImage *)makeImage:(UIImage *)thisImage toThumbnailOfSize:(CGSize)size;
+ (NSString *)translatedStringAr:(NSString *)arabic andEnglish:(NSString *)english;
+ (NSDate *)getCurrentLocalDate;
+ (void)removeExpiredSchedulesWithID:(NSString *)scheduleID;
@end
