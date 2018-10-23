//
//  WATweakHelper.h
//  WAEnhancer9
//
//  Created by iMokhles on 11/05/16.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <OneSignal/OneSignal.h>
#import "UIAlertView+Blocks.h"

#define kWATweakBundlePath [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"baytapps.bundle"]


@interface LoginRegisterViewController : UIViewController

@end

@interface SCAppDelegate : UIResponder
@property(retain, nonatomic) UIWindow *window;
@end

@interface SCBaseMessage : NSObject
@property(retain, nonatomic) NSString *sender; // @synthesize sender=_sender;
@property(retain, nonatomic) NSString *text; // @synthesize text=_text;
@property(retain, nonatomic) NSString *conversationId;
@end

@interface SCPushNotificationRegistrar : NSObject
{
}

+ (void)didInvalidatePushTokenForType:(id)arg1;
+ (void)didUpdatePushCredentials:(id)arg1 forType:(id)arg2;
+ (void)didRegisterForRemoteNotificationsWithDeviceToken:(id)arg1;
+ (void)didFailToRegisterForRemoteNotificationsWithError:(id)arg1;
+ (void)didRegisterUserNotificationSettings:(id)arg1 withDelegate:(id)arg2;
+ (_Bool)isRegisteredForPushNotifications;
+ (void)registerForPushNotifications;
+ (id)stringifyToken:(id)arg1;

@end

@interface User : NSObject
+(void)performLoginWithUsernameOrEmail:(id)arg password:(id)arg2 isTwoFA:(bool)arg3 preAuthToken:(id)arg4 onComplete:(id)arg5;
-(void)setLoginInSession:(bool)arg;
-(void)setLoginUsername:(id)arg;
-(bool)isLoggedIn;
@end

@interface SCShareUser : NSObject
-(void)setUsername:(id)arg;
-(bool)isLoggedIn;
-(bool)hasLoggedOut;
-(bool)shouldDisplayCaptionHelp;
-(bool)needsVerification;
-(bool)hasLoggedIntoAnotherAccount;
@end

@interface GADDevice : NSObject
-(bool)isJailbroken;
@end

@interface WATweakHelper : NSObject
{
    __block UIBackgroundTaskIdentifier bgTask;
    __block dispatch_block_t expirationHandler;
    __block NSTimer * timer;
    __block AVAudioPlayer *player;
    
    NSInteger timerInterval;
    id target;
    SEL selector;
}
-(void) startBackgroundTasks:(NSInteger)time_  target:(id)target_ selector:(SEL)selector_;
-(void) stopBackgroundTask;


+ (id)sharedInstance;
+ (NSBundle *)tweakBundle;
+ (NSString *)tweakBundlePath;
+ (NSURL *)urlForTweakFileWithName:(NSString *)name extension:(NSString *)extension;
+ (NSString *)pathForTweakFileWithName:(NSString *)name extension:(NSString *)extension;
+ (NSString *)accountType;

+ (NSString *)accountType_whatsapp_noti_id;
+ (NSString *)accountType_whatsapp_icloud;
+ (NSString *)accountType_whatsapp_group;
+ (NSString *)accountType_snapchat_group;
+ (NSString *)currentBundleID;
+ (void)createLocalNotificationFromMessage:(SCBaseMessage *)message;
+ (NSString *)getFullAppleIdentifier:(NSString *)bundleIdentifier;
+ (NSString *)imo_accessGroup;

+ (NSString *)basc_username;
+ (NSString *)basc_password;
+ (NSString *)ows_tripToken:(NSData *)tokenData;
@end
