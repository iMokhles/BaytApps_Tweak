
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos


#include <sys/sysctl.h>
#include <sys/types.h>
#include <dirent.h>
#include <sys/stat.h>
#import <AudioToolbox/AudioServices.h>

#import "WAEnhancer9.h"
#import "WAESetTableViewController.h"
#import "BOSetting.h"
#import "UIColor+CustomColors.h"
#import "CWStatusBarNotification.h"
//#import "WARecentsList.h"
#import "WAEnhancer9Helper.h"
//#import "KVNProgress.h"
//#import "WAESavedUsersViewController.h"
#import "TransNSString.h"
//#import "WAELockedChatsViewController.h"
//#import "WAEPassCheckViewController.h"
#import "WATweakHelper.h"
//#import "WAContactsPicturesViewController.h"
//#import <libimodevtools2/iMoDevTools2Own.h>
////#import "WAEPaymentSystem.h"
//#import "ChatsNewView.h"
//#import "SOPLockViewController.h"
//#import "CAPopUpViewController.h"
//#import "WAEScheduleViewController.h"
//#import "FLEXManager.h"
//
#import <Parse/Parse.h>

%config(generator=internal)


extern "C" void AudioServicesPlaySystemSoundWithVibration(SystemSoundID inSystemSoundID, id unknown, NSDictionary *options);
static NSThread *thread;
WAMessage *waofaMessage = nil;

OneSignal *oneSignal;

/// This environment MUST be used for App Store submissions.
extern NSString * const PayPalEnvironmentProduction;
/// Sandbox: Uses the PayPal sandbox for transactions. Useful for development.
extern NSString * const PayPalEnvironmentSandbox;
/// NoNetwork: Mock mode. Does not submit transactions to PayPal. Fakes successful responses. Useful for unit tests.
extern NSString * const PayPalEnvironmentNoNetwork;

@interface RMUniversalAlert : NSObject
@end

__attribute__((always_inline, visibility("hidden")))
static BOOL isThisFileExiste(const char *path) {
    return (access(path,F_OK) != -1);
}
__attribute__((always_inline, visibility("hidden")))
static BOOL isVaildBundle(const char *bundleID) {
    
    if(strstr(bundleID, "baytapps") != NULL) {
        return YES;
    }
    return NO;
}

__attribute__((always_inline, visibility("hidden")))
static BOOL isVaildProfile(const char *accountID) {
    
    if(strstr(accountID, "wrong") != NULL || strstr(accountID, "simulator") != NULL) {
        return NO;
    }
    return YES;
}
#pragma mark - Shop Version

#pragma mark -
#pragma mark - iPAD Support

%group WATweaks

%hook UIDevice
- (BOOL)wa_isDeviceSupported {
    return YES;
}
- (BOOL)wa_shouldBeAskedToReview {
    return NO;
}
- (BOOL)wa_isDeviceSuspicious {
    return NO;
}

%end

%hook WAMediaBrowserViewController
- (void)shareMediaInMessageExternally:(id)arg1 {
    
    WAMessage *currentMessage = [self currentMessage];
    if ([currentMessage.messageType intValue] == 3) { // music
        
        WABlockBasedAlertView *alertView = [objc_getClass("WABlockBasedAlertView") alertViewWithTitle:@"Music Options" message:[NSString translateToAR:@"هل تريد مشاركة هذا المقطع الصوتي؟" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"Would you like to share this sound ?" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil]];
        
        [alertView addButtonWithTitle:[NSString translateToAR:@"مشاركة" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"Share" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil] handler:^{
            
            NSString *musicPath = currentMessage.mediaPath;
            NSURL *outURL = [NSURL fileURLWithPath:musicPath];
            
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[outURL] applicationActivities:nil];
            
            NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                           UIActivityTypePrint,
                                           UIActivityTypeCopyToPasteboard,
                                           UIActivityTypeAssignToContact,
                                           UIActivityTypeSaveToCameraRoll,
                                           UIActivityTypeAddToReadingList,
                                           UIActivityTypePostToFlickr,
                                           UIActivityTypePostToVimeo];
            activityVC.excludedActivityTypes = excludeActivities;
            
            // In iPads case, we need to show the share sheet from the share buttons view, but only on iOS 8+
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [WAEnhancer9Helper isIOS80_OrGreater]) {
                activityVC.popoverPresentationController.sourceView = self.view;
            }
            
            // Show the activity view controller
            [self presentViewController:activityVC animated:YES completion:nil];
        }];
        
        [alertView addCancelButtonWithTitle:@"Cancel" handler:^{
            
        }];
        
        [alertView show];
        
    } else {
        if (IS_IPAD) {
            
            UIView *view;
            if (!view) {
                UIWindow *keyWindow = [UIWindow keyWindow];
                if ([UIWindow respondsToSelector:@selector(rootViewController)])
                    view = [[keyWindow rootViewController] view];
                    if (!view)
                        view = [keyWindow.subviews lastObject];
                        }
            
            WAForwardActivity *waActivity = [[objc_getClass("WAForwardActivity") alloc] initWithMessages:@[arg1]];
            WAActivityViewController *activityVC = [[objc_getClass("WAActivityViewController") alloc] initWithActivityItems:@[arg1] applicationActivities:@[waActivity]];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                [(WAMediaBrowserViewController *)self presentViewController:activityVC animated:YES completion:nil];
            }
            //if iPad
            else {
                // Change Rect to position Popover
                UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityVC];
                [popup presentPopoverFromRect:CGRectMake(view.frame.size.width/2, view.frame.size.height/4, 0, 0) inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
        } else {
            %orig;
        }
    }
    
}
%end

%hook _WAActionSheetPresenterOS8
- (void)presentFromViewController:(UIViewController *)arg1 {
    
    if (IS_IPAD) {
        UIView *view;
        if (!view) {
            UIWindow *keyWindow = [UIWindow keyWindow];
            if ([UIWindow respondsToSelector:@selector(rootViewController)])
                view = [[keyWindow rootViewController] view];
                if (!view)
                    view = [keyWindow.subviews lastObject];
                    }
        UIAlertController *alertController = [self valueForKey:@"_alertController"];
        alertController.popoverPresentationController.sourceView = view;
        alertController.popoverPresentationController.sourceRect = CGRectMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0, 1.0, 1.0);
        UIAlertController *retainedControllerBeforePresentation = [self valueForKey:@"_retainedControllerBeforePresentation"];
        [arg1 presentViewController:alertController animated:0x1 completion:nil];
        retainedControllerBeforePresentation = nil;
    } else {
        %orig;
    }
    
}
%end

%hook _WAAlertViewPresenterOS8
- (void)presentFromViewController:(UIViewController *)arg1 {
    if (IS_IPAD) {
        UIView *view;
        if (!view) {
            UIWindow *keyWindow = [UIWindow keyWindow];
            if ([UIWindow respondsToSelector:@selector(rootViewController)])
                view = [[keyWindow rootViewController] view];
                if (!view)
                    view = [keyWindow.subviews lastObject];
                    }
        UIAlertController *alertController = [self valueForKey:@"_alertController"];
        alertController.popoverPresentationController.sourceView = view;
        alertController.popoverPresentationController.sourceRect = CGRectMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0, 1.0, 1.0);
        UIAlertController *retainedControllerBeforePresentation = [self valueForKey:@"_retainedControllerBeforePresentation"];
        [arg1 presentViewController:alertController animated:0x1 completion:nil];
        retainedControllerBeforePresentation = nil;
    } else {
        %orig;
    }
}
%end

#pragma mark -
#pragma mark - jailbreak detection
%hook WASharedAppData
+ (void)showLocalNotificationForJailbrokenPhoneAndTerminate {
    return;
}
%end

#pragma mark -
#pragma mark - WAEnhancer Settings



#pragma mark -
#pragma mark - Login FIX

//%hook XMPPStream
//+ (id)serverStaticKeychainQuery {
//    id r = %orig;
//    NSMutableDictionary *keychainQuery = [%orig() mutableCopy];
//    [keychainQuery setObject:[WATweakHelper imo_accessGroup] forKey:(__bridge id)kSecAttrAccessGroup];
//    return [keychainQuery copy];
//}
//%new
//+ (NSString *)imo_accessGroup {
//    static NSString *glAppID = nil;
//    
//    if ( glAppID == nil ) {
//        NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
//                               (__bridge NSString *)kSecClassGenericPassword, (__bridge NSString *)kSecClass,
//                               @"bundleSeedID", kSecAttrAccount,
//                               [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"], kSecAttrService,
//                               (id)kCFBooleanTrue, kSecReturnAttributes,
//                               nil];
//        CFDictionaryRef result = nil;
//        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
//        if (status == errSecItemNotFound)
//            status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
//            if (status == errSecSuccess) {
//                glAppID = [(__bridge NSDictionary *)result objectForKey:(__bridge NSString *)kSecAttrAccessGroup];
//            }
//        
//        if ( result != nil ) {
//            CFRelease(result);
//        }
//    }
//    return glAppID;
//}
//%end
//
//%hook WASignalKeyStore
//+ (id)baseKeychainQuery {
//    id r = %orig;
//    NSMutableDictionary *keychainQuery = [%orig() mutableCopy];
//    [keychainQuery setObject:[WATweakHelper imo_accessGroup] forKey:(__bridge id)kSecAttrAccessGroup];
//    return [keychainQuery copy];
//}
//%new
//+ (NSString *)imo_accessGroup {
//    static NSString *glAppID = nil;
//    
//    if ( glAppID == nil ) {
//        NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
//                               (__bridge NSString *)kSecClassGenericPassword, (__bridge NSString *)kSecClass,
//                               @"bundleSeedID", kSecAttrAccount,
//                               [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"], kSecAttrService,
//                               (id)kCFBooleanTrue, kSecReturnAttributes,
//                               nil];
//        CFDictionaryRef result = nil;
//        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
//        if (status == errSecItemNotFound)
//            status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
//            if (status == errSecSuccess) {
//                glAppID = [(__bridge NSDictionary *)result objectForKey:(__bridge NSString *)kSecAttrAccessGroup];
//            }
//        
//        if ( result != nil ) {
//            CFRelease(result);
//        }
//    }
//    return glAppID;
//}
//%end
//
//%hook KeychainWrapper
//+ (id)searchDictionary:(id)arg1 withAccessibilityControl:(_Bool)arg2 {
//    
//    NSMutableDictionary *keychainQuery = [%orig() mutableCopy];
//    [keychainQuery setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:(__bridge id)kSecAttrService];
//    return keychainQuery;
//}
//%end
//
//%hook WAEndToEndEncryptionManager
//- (NSDictionary *)keychainIdentityQuery {
//    id r = %orig;
//    NSMutableDictionary *keychainQuery = [%orig() mutableCopy];
//    [keychainQuery setObject:[WATweakHelper imo_accessGroup] forKey:(__bridge id)kSecAttrAccessGroup];
//    return [keychainQuery copy];
//}
//
//%new
//- (NSString *)getFullAppleIdentifier:(NSString *)bundleIdentifier
//{
//    NSString *bundleSeedIdentifier = [self imo_accessGroup];
//    if (bundleSeedIdentifier != nil && [bundleIdentifier rangeOfString:bundleSeedIdentifier].location == NSNotFound) {
//        bundleIdentifier = [NSString stringWithFormat:@"%@.%@", bundleSeedIdentifier, bundleIdentifier];
//    }
//    return bundleIdentifier;
//}
//
//%new
//- (NSString *)imo_accessGroup {
//    static NSString *glAppID = nil;
//    
//    if ( glAppID == nil ) {
//        NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
//                               (__bridge NSString *)kSecClassGenericPassword, (__bridge NSString *)kSecClass,
//                               @"bundleSeedID", kSecAttrAccount,
//                               [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"], kSecAttrService,
//                               (id)kCFBooleanTrue, kSecReturnAttributes,
//                               nil];
//        CFDictionaryRef result = nil;
//        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
//        if (status == errSecItemNotFound)
//            status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
//            if (status == errSecSuccess) {
//                glAppID = [(__bridge NSDictionary *)result objectForKey:(__bridge NSString *)kSecAttrAccessGroup];
//            }
//        
//        if ( result != nil ) {
//            CFRelease(result);
//        }
//    }
//    return glAppID;
//}
//%end

#pragma mark -
#pragma mark - Advanced Options

#pragma mark -
#pragma mark - UserInterface

#pragma mark -
#pragma mark - Hide Call Buttons

#pragma mark -
#pragma mark - App Delegate & Pervent Updates

#pragma mark - App Delegate & Pervent Updates

//%hook NSDate

//+ (id)dateWithTimeIntervalSince1970:(NSTimeInterval)secs {
//    
//    NSLog(@"********* dateWithTimeIntervalSince1970 %f", secs);
//    // secs == 1484360105.000000 || secs == 1484513793.000000 || secs == 1481921854.047651
//    if (secs == 1464812287.000000) {
//        
//        //|| secs == 1479930257.000000 || secs == 1479930257.000000) {
//        secs = 9464812287.00000;
//    }
//    return %orig(secs);
//}
//%end

//%hook WAExpiredBuildNotificationViewController
//+ (_Bool)canPresentBuildExpirationReminderReturningNumberOfDaysToExpiration:(id)arg1 {
//    return NO;
//}
//%end

%hook WhatsAppAppDelegate

//- (void)presentHelperScreenIfNecessaryWithColdLaunch:(id)arg1 {
//    return;
//}
//- (void)presentPhoneDateInaccurateAlert {
//    return;
//}
//- (void)checkForUpdatedBetaBuildIfNeeded {
//    return;
//}
- (void)applicationDidBecomeActive:(id)arg1 {
    NSString *profile1 = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    
    //    if (!isVaildBundle([[WATweakHelper currentBundleID] UTF8String])){//[[WATweakHelper currentBundleID] containsString:@"baytapps"]) {
    //        NSString *imTitle = [NSString translateToAR:@"(2) baytapps تحذير" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"baytapps WARNING" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
    //
    //        NSString *imMessage = [NSString translateToAR:@"للاسف لم تقم بتحميل هذه النسخه من موقع baytapps" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"OPS you don't download it from baytapps Site" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
    //
    //        UIAlertView *deleteWarning = [[UIAlertView alloc]
    //                                      initWithTitle:imTitle
    //                                      message:imMessage
    //                                      delegate:self
    //                                      cancelButtonTitle:nil
    //                                      otherButtonTitles:nil, nil];
    //        [deleteWarning show];
    //    }
    
    NSDictionary* mobileProvision = nil;
    if (!mobileProvision) {
        NSString *provisioningPath = profile1;
        if (!provisioningPath) {
            mobileProvision = @{};
            return;
        }
        NSString *binaryString = [NSString stringWithContentsOfFile:provisioningPath encoding:NSISOLatin1StringEncoding error:NULL];
        if (!binaryString) {
            return;
        }
        NSScanner *scanner = [NSScanner scannerWithString:binaryString];
        BOOL ok = [scanner scanUpToString:@"<plist" intoString:nil];
        if (!ok) { NSLog(@"unable to find beginning of plist");
        }
        NSString *plistString;
        ok = [scanner scanUpToString:@"</plist>" intoString:&plistString];
        if (!ok) { NSLog(@"unable to find end of plist");
        }
        plistString = [NSString stringWithFormat:@"%@</plist>",plistString];
        NSData *plistdata_latin1 = [plistString dataUsingEncoding:NSISOLatin1StringEncoding];
        NSError *error = nil;
        mobileProvision = [NSPropertyListSerialization propertyListWithData:plistdata_latin1 options:NSPropertyListImmutable format:NULL error:&error];
        if (error) {
            NSLog(@"error parsing extracted plist — %@",error);
            if (mobileProvision) {
                mobileProvision = nil;
            }
            return;
        }
    }
    
    NSDictionary *profile = mobileProvision;
    NSString *teamID = [profile[@"TeamIdentifier"] objectAtIndex:0];
    
    if (teamID.length > 0) {
        
        if (![teamID isEqualToString:@"KH5MPTCV98"] || ![teamID isEqualToString:@"FC4F38T32K"] || ![teamID isEqualToString:@"2EPK7SEG45"] || ![teamID isEqualToString:@"EAST223S7M"] || ![teamID isEqualToString:@"6SH9WE2ENU"] || ![teamID isEqualToString:@"3QZW2N7S46"]) {
            
            return;
        }
    } else {
        return;
    }
    if (!isThisFileExiste([profile1 UTF8String])) {
        NSString *imTitle = [NSString translateToAR:@"(2) baytapps تحذير" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"baytapps WARNING" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
        
        NSString *imMessage = [NSString translateToAR:@"للاسف لم تقم بتحميل هذه النسخه من موقع baytapps" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"OPS you don't download it from baytapps Site" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
        
        UIAlertView *deleteWarning = [[UIAlertView alloc]
                                      initWithTitle:imTitle
                                      message:imMessage
                                      delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
        [deleteWarning show];
    }
    
    if (!isVaildProfile([[WATweakHelper accountType] UTF8String])){
        NSString *imTitle = [NSString translateToAR:@"(2) baytapps تحذير" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"baytapps WARNING" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
        
        NSString *imMessage = [NSString translateToAR:@"للاسف لم تقم بتحميل هذه النسخه من موقع baytapps" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"OPS you don't download it from baytapps Site" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
        
        UIAlertView *deleteWarning = [[UIAlertView alloc]
                                      initWithTitle:imTitle
                                      message:imMessage
                                      delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
        [deleteWarning show];
    }
    
    [[WATweakHelper sharedInstance] stopBackgroundTask];
//    NSLog(@"*********** applicationDidBecomeActive s98df7yhsdnfi7sdftyg34bkrjsdbvsi7dftgsdbfmk87tsdgfb");
    //    [[RunInBackground sharedBg] stopAudioPlay];
    //    if (![thread isMainThread]) {
    //        //        [self.thread cancel];
    //    }
    %orig;
}
//- (void)applicationReallyDidBecomeActive:(id)arg1 {
//    
//    NSString *profile1 = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];

//    if (!isVaildBundle([[WATweakHelper currentBundleID] UTF8String])){//[[WATweakHelper currentBundleID] containsString:@"baytapps"]) {
//        NSString *imTitle = [NSString translateToAR:@"(2) baytapps تحذير" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"baytapps WARNING" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
//        
//        NSString *imMessage = [NSString translateToAR:@"للاسف لم تقم بتحميل هذه النسخه من موقع baytapps" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"OPS you don't download it from baytapps Site" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
//        
//        UIAlertView *deleteWarning = [[UIAlertView alloc]
//                                      initWithTitle:imTitle
//                                      message:imMessage
//                                      delegate:self
//                                      cancelButtonTitle:nil
//                                      otherButtonTitles:nil, nil];
//        [deleteWarning show];
//    }
    
//    NSDictionary* mobileProvision = nil;
//    if (!mobileProvision) {
//        NSString *provisioningPath = profile1;
//        if (!provisioningPath) {
//            mobileProvision = @{};
//            return;
//        }
//        NSString *binaryString = [NSString stringWithContentsOfFile:provisioningPath encoding:NSISOLatin1StringEncoding error:NULL];
//        if (!binaryString) {
//            return;
//        }
//        NSScanner *scanner = [NSScanner scannerWithString:binaryString];
//        BOOL ok = [scanner scanUpToString:@"<plist" intoString:nil];
//        if (!ok) { NSLog(@"unable to find beginning of plist");
//        }
//        NSString *plistString;
//        ok = [scanner scanUpToString:@"</plist>" intoString:&plistString];
//        if (!ok) { NSLog(@"unable to find end of plist");
//        }
//        plistString = [NSString stringWithFormat:@"%@</plist>",plistString];
//        NSData *plistdata_latin1 = [plistString dataUsingEncoding:NSISOLatin1StringEncoding];
//        NSError *error = nil;
//        mobileProvision = [NSPropertyListSerialization propertyListWithData:plistdata_latin1 options:NSPropertyListImmutable format:NULL error:&error];
//        if (error) {
//            NSLog(@"error parsing extracted plist — %@",error);
//            if (mobileProvision) {
//                mobileProvision = nil;
//            }
//            return;
//        }
//    }
//    
//    NSDictionary *profile = mobileProvision;
//    NSString *teamID = [profile[@"TeamIdentifier"] objectAtIndex:0];
//    
//    if (teamID.length > 0) {
//        
//        if (![teamID isEqualToString:@"KH5MPTCV98"] || ![teamID isEqualToString:@"FC4F38T32K"] || ![teamID isEqualToString:@"2EPK7SEG45"] || ![teamID isEqualToString:@"EAST223S7M"] || ![teamID isEqualToString:@"6SH9WE2ENU"] || ![teamID isEqualToString:@"3QZW2N7S46"]) {
//            
//            return;
//        }
//    } else {
//        return;
//    }
//    if (!isThisFileExiste([profile1 UTF8String])) {
//        NSString *imTitle = [NSString translateToAR:@"(2) baytapps تحذير" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"baytapps WARNING" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
//        
//        NSString *imMessage = [NSString translateToAR:@"للاسف لم تقم بتحميل هذه النسخه من موقع baytapps" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"OPS you don't download it from baytapps Site" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
//        
//        UIAlertView *deleteWarning = [[UIAlertView alloc]
//                                      initWithTitle:imTitle
//                                      message:imMessage
//                                      delegate:self
//                                      cancelButtonTitle:nil
//                                      otherButtonTitles:nil, nil];
//        [deleteWarning show];
//    }
//    
//    if (!isVaildProfile([[WATweakHelper accountType] UTF8String])){
//        NSString *imTitle = [NSString translateToAR:@"(2) baytapps تحذير" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"baytapps WARNING" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
//        
//        NSString *imMessage = [NSString translateToAR:@"للاسف لم تقم بتحميل هذه النسخه من موقع baytapps" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"OPS you don't download it from baytapps Site" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
//        
//        UIAlertView *deleteWarning = [[UIAlertView alloc]
//                                      initWithTitle:imTitle
//                                      message:imMessage
//                                      delegate:self
//                                      cancelButtonTitle:nil
//                                      otherButtonTitles:nil, nil];
//        [deleteWarning show];
//    }
//    
//    [[WATweakHelper sharedInstance] stopBackgroundTask];
////    NSLog(@"*********** applicationReallyDidBecomeActive s98df7yhsdnfi7sdftyg34bkrjsdbvsi7dftgsdbfmk87tsdgfb");
////    [[RunInBackground sharedBg] stopAudioPlay];
////    if (![thread isMainThread]) {
////        //        [self.thread cancel];
////    }
//    %orig;
//    
//}

- (void)applicationDidEnterBackground:(id)arg1 {
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [[RunInBackground sharedBg] startRunInbackGround];
//        [[NSRunLoop currentRunLoop] run];
//        thread = [NSThread currentThread];
//    });
//    NSLog(@"*********** applicationDidEnterBackground s98df7yhsdnfi7sdftyg34bkrjsdbvsi7dftgsdbfmk87tsdgfb");
    %orig;
    [[WATweakHelper sharedInstance] startBackgroundTasks:2 target:self selector:@selector(backgroundCallback:)];
    
}

%new
-(void) backgroundCallback:(id)info
{
    
//    [[objc_getClass("WASharedAppData") xmppConnection] runWhenConnected:YES];
//    NSLog(@"BackroundTaskRunning: %f", [UIApplication sharedApplication].backgroundTimeRemaining);
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    
//    oneSignal = [[OneSignal alloc] initWithLaunchOptions:launchOptions appId:[WATweakHelper accountType_whatsapp_noti_id] handleNotification:^(NSString *message, NSDictionary *additionalData, BOOL isActive) {
//        
//        [self applicationReallyDidResume];
//        [self setAppWakeReason:0x1];
//        
////        [self performSelector:@selector(backgroundCallback:) withObject:nil];
//        
//    } autoRegister:YES];
//    
//    NSLog(@"*********** didFinishLaunchingWithOptions s98df7yhsdnfi7sdftyg34bkrjsdbvsi7dftgsdbfmk87tsdgfb");
//    [oneSignal enableInAppAlertNotification:NO];
//    
//    BOOL isOrig = %orig();
//    if (isOrig) {
//        
//    }
//    
//    
//    return isOrig;
//}

//- (BOOL)application:(UIApplication *)application reallyDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    
//    oneSignal = [[OneSignal alloc] initWithLaunchOptions:launchOptions appId:[WATweakHelper accountType_whatsapp_noti_id] handleNotification:^(NSString *message, NSDictionary *additionalData, BOOL isActive) {
//        [self applicationReallyDidResume];
//        [self setAppWakeReason:0x1];
////        [self performSelector:@selector(backgroundCallback:) withObject:nil];
//        
//    } autoRegister:YES];
//    
//    NSLog(@"*********** reallyDidFinishLaunchingWithOptions s98df7yhsdnfi7sdftyg34bkrjsdbvsi7dftgsdbfmk87tsdgfb");
//    [oneSignal enableInAppAlertNotification:NO];
//    
//    BOOL isOrig = %orig();
//    if (isOrig) {
//        
//    }
//    
//    
//    return isOrig;
//}

- (void)registerForPushTokens {
    
    
    %orig;
}
-(BOOL)application:(id)arg1 openURL:(NSURL *)url sourceApplication:(id)arg3 annotation:(id)arg4 {
    return %orig;
}

%end

#pragma mark -
#pragma mark - Backup

#pragma mark -
#pragma mark - WAChatSessionViewController

%hook WAChatSessionViewController

- (void)presentShareDocumentController {
    
    UIDocumentMenuViewController *documentPicker = [[UIDocumentMenuViewController alloc] initWithDocumentTypes:@[@"public.data"]
                                                                                                        inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = (WAChatSessionViewController *)self;
    [WAEnhancer9Helper getDeviceStatusWithBlock:^(BOOL isOK) {
        if (isOK) {
            [self _presentForCurrentInterface:documentPicker];
        }
    }];
    
    
}

%new
- (void)_presentForCurrentInterface:(UIViewController *)viewController {
    UIView *view;
    if (!view) {
        UIWindow *keyWindow = [UIWindow keyWindow];
        if ([UIWindow respondsToSelector:@selector(rootViewController)])
            view = [[keyWindow rootViewController] view];
            if (!view)
                view = [keyWindow.subviews lastObject];
                }
    if (IS_IPAD) {
        UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:viewController];
        [popOver setDelegate:(WAChatSessionViewController *)self];
        [popOver presentPopoverFromRect:CGRectMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0, 1.0, 1.0) inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [(WAChatSessionViewController *)self presentViewController:viewController animated:YES completion:nil];
    }
}

%new
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker {
    documentPicker.delegate = (WAChatSessionViewController *)self;
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [(WAChatSessionViewController *)self presentViewController:documentPicker animated:YES completion:nil];
    
}

%new
- (void)documentMenuWasCancelled:(UIDocumentMenuViewController *)documentMenu {
    [documentMenu dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSURL *fileURL = url;
        if ([fileURL isFileURL] == NO) {
            fileURL = [NSURL fileURLWithPath:url.absoluteString];
        }
        WADocumentAttachment *docAttach = [[objc_getClass("WADocumentAttachment") alloc] initWithFileURL:fileURL transferFileOwnership:YES];
        [(WAChatSessionViewController *)self sendDocumentAttachment:docAttach];
    });
    
    
}
%end

#pragma mark -
#pragma mark - Add delete all Broadcasts


#pragma mark -
#pragma mark - Last Seend

#pragma mark -
#pragma mark - WARecentUpdates

%hook ChatManager

- (void)chatStorage:(id)arg1 didReceiveMessage:(id)arg2 {
    %orig;
    [WAEnhancer9Helper createLocalNotificationFromMessage:arg2];
    
}

%end

%hook WAChatStorage

- (void)registerSiriKitVocabularyIfNeeded {
    return;
}

%end

%end

%group SCTweak



%hook SCChatLogger
- (void)logChatReceived:(id)arg1 from:(id)arg2 {
    %orig;
}
%end

%hook SCChat
- (void)deliverMessage:(id)arg1 {
    [WATweakHelper createLocalNotificationFromMessage:arg1];
    %orig;
}
%end

%hook SCAppDelegate
- (void)applicationDidBecomeActive:(id)arg1 {
    
    NSString *profile1 = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    
//    if (!isVaildBundle([[WATweakHelper currentBundleID] UTF8String])){//[[WATweakHelper currentBundleID] containsString:@"baytapps"]) {
//        NSString *imTitle = [NSString translateToAR:@"(2) baytapps تحذير" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"baytapps WARNING" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
//        
//        NSString *imMessage = [NSString translateToAR:@"للاسف لم تقم بتحميل هذه النسخه من موقع baytapps" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"OPS you don't download it from baytapps Site" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
//        
//        UIAlertView *deleteWarning = [[UIAlertView alloc]
//                                      initWithTitle:imTitle
//                                      message:imMessage
//                                      delegate:self
//                                      cancelButtonTitle:nil
//                                      otherButtonTitles:nil, nil];
//        [deleteWarning show];
//    }
    
    
    NSDictionary* mobileProvision = nil;
    if (!mobileProvision) {
        NSString *provisioningPath = profile1;
        if (!provisioningPath) {
            mobileProvision = @{};
            return;
        }
        NSString *binaryString = [NSString stringWithContentsOfFile:provisioningPath encoding:NSISOLatin1StringEncoding error:NULL];
        if (!binaryString) {
            return;
        }
        NSScanner *scanner = [NSScanner scannerWithString:binaryString];
        BOOL ok = [scanner scanUpToString:@"<plist" intoString:nil];
        if (!ok) { NSLog(@"unable to find beginning of plist");
        }
        NSString *plistString;
        ok = [scanner scanUpToString:@"</plist>" intoString:&plistString];
        if (!ok) { NSLog(@"unable to find end of plist");
        }
        plistString = [NSString stringWithFormat:@"%@</plist>",plistString];
        NSData *plistdata_latin1 = [plistString dataUsingEncoding:NSISOLatin1StringEncoding];
        NSError *error = nil;
        mobileProvision = [NSPropertyListSerialization propertyListWithData:plistdata_latin1 options:NSPropertyListImmutable format:NULL error:&error];
        if (error) {
            NSLog(@"error parsing extracted plist — %@",error);
            if (mobileProvision) {
                mobileProvision = nil;
            }
            return;
        }
    }
    
    NSDictionary *profile = mobileProvision;
    NSString *teamID = [profile[@"TeamIdentifier"] objectAtIndex:0];
    
    if (teamID.length > 0) {
        
        if (![teamID isEqualToString:@"KH5MPTCV98"] || ![teamID isEqualToString:@"FC4F38T32K"] || ![teamID isEqualToString:@"2EPK7SEG45"] || ![teamID isEqualToString:@"EAST223S7M"] || ![teamID isEqualToString:@"6SH9WE2ENU"] || ![teamID isEqualToString:@"3QZW2N7S46"]) {
            
            return;
        }
    } else {
        return;
    }
    
    if (!isThisFileExiste([profile1 UTF8String])) {
        NSString *imTitle = [NSString translateToAR:@"(2) baytapps تحذير" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"baytapps WARNING" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
        
        NSString *imMessage = [NSString translateToAR:@"للاسف لم تقم بتحميل هذه النسخه من موقع baytapps" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"OPS you don't download it from baytapps Site" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
        
        UIAlertView *deleteWarning = [[UIAlertView alloc]
                                      initWithTitle:imTitle
                                      message:imMessage
                                      delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
        [deleteWarning show];
    }
    
    if (!isVaildProfile([[WATweakHelper accountType] UTF8String])){
        NSString *imTitle = [NSString translateToAR:@"(2) baytapps تحذير" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"baytapps WARNING" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
        
        NSString *imMessage = [NSString translateToAR:@"للاسف لم تقم بتحميل هذه النسخه من موقع baytapps" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"OPS you don't download it from baytapps Site" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
        
        UIAlertView *deleteWarning = [[UIAlertView alloc]
                                      initWithTitle:imTitle
                                      message:imMessage
                                      delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
        [deleteWarning show];
    }
    
    [objc_getClass("SCPushNotificationRegistrar") registerForPushNotifications];
    
    [[WATweakHelper sharedInstance] stopBackgroundTask];
    //    [[RunInBackground sharedBg] stopAudioPlay];
    //    if (![thread isMainThread]) {
    //        //        [self.thread cancel];
    //    }
    %orig;
    
}

- (void)applicationDidEnterBackground:(id)arg1 {
    
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //        [[RunInBackground sharedBg] startRunInbackGround];
    //        [[NSRunLoop currentRunLoop] run];
    //        thread = [NSThread currentThread];
    //    });
    [[WATweakHelper sharedInstance] startBackgroundTasks:2 target:self selector:@selector(backgroundCallback:)];
    %orig;
    
}

%new
-(void) backgroundCallback:(id)info
{
    NSLog(@"BackroundTaskRunning: %f", [UIApplication sharedApplication].backgroundTimeRemaining);
}

%new
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler {
    
////    [[NSNotificationCenter defaultCenter] postNotificationName:@"QuickReplyGotTextNotification" object:[responseInfo objectForKey:UIUserNotificationActionResponseTypedTextKey] userInfo:nil];
    completionHandler();
}

%end

%hook UIMutableUserNotificationCategory

- (NSString *)identifier {
    
    id r = %orig();
    
    NSLog(@"****** ID: %@", r);
    return r;
}

%end

NSString * const NotificationCategoryIdent  = @"SCIncomingMessage";
NSString * const NotificationActionReplyIdent = @"Reply";
NSString * const NotificationActionIgnoreIndent = @"Ignore";

%hook SCPushNotificationRegistrar
+ (void)registerForPushNotifications {
    
    UIMutableUserNotificationAction *replyAction;
    UIMutableUserNotificationAction *ignoreAction;
    UIMutableUserNotificationCategory *actionCategory;
    
    replyAction = [[UIMutableUserNotificationAction alloc] init];
    replyAction.activationMode = UIUserNotificationActivationModeForeground;
    replyAction.title = @"Reply To Message";
    replyAction.identifier = NotificationActionReplyIdent;
    replyAction.destructive = NO;
    replyAction.authenticationRequired = NO;
    replyAction.behavior = UIUserNotificationActionBehaviorTextInput;
    replyAction.parameters = @{ UIUserNotificationTextInputActionButtonTitleKey: @"Reply" };
    
    ignoreAction = [[UIMutableUserNotificationAction alloc] init];
    ignoreAction.activationMode = UIUserNotificationActivationModeBackground;
    ignoreAction.title = @"Ignore";
    ignoreAction.identifier = NotificationActionIgnoreIndent;
    ignoreAction.destructive = NO;
    ignoreAction.authenticationRequired = NO;
    
    actionCategory = [[UIMutableUserNotificationCategory alloc] init];
    actionCategory.identifier = NotificationCategoryIdent;
    [actionCategory setActions:@[ ignoreAction, replyAction ] forContext:UIUserNotificationActionContextDefault];
    [actionCategory setActions:@[ ignoreAction, replyAction ] forContext:UIUserNotificationActionContextMinimal];
    
    
    NSSet *categories = [NSSet setWithObjects:actionCategory, nil];
    UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
}
%end

//%hook UIUserNotificationSettings
//+ (id)settingsForTypes:(UIUserNotificationType)types categories:(NSSet*)categories {
//    
//    NSSet *n_categories = categories;
//    
//    UIMutableUserNotificationAction *replyAction;
//    UIMutableUserNotificationAction *ignoreAction;
//    UIMutableUserNotificationCategory *actionCategory;
//    
//    replyAction = [[UIMutableUserNotificationAction alloc] init];
//    replyAction.activationMode = UIUserNotificationActivationModeForeground;
//    replyAction.title = @"Reply";
//    replyAction.identifier = NotificationActionReplyIdent;
//    replyAction.destructive = NO;
//    replyAction.authenticationRequired = NO;
//    replyAction.behavior = UIUserNotificationActionBehaviorTextInput;
//    replyAction.parameters = @{ UIUserNotificationTextInputActionButtonTitleKey: @"Reply" };
//    
//    ignoreAction = [[UIMutableUserNotificationAction alloc] init];
//    ignoreAction.activationMode = UIUserNotificationActivationModeBackground;
//    ignoreAction.title = @"Ignore";
//    ignoreAction.identifier = NotificationActionIgnoreIndent;
//    ignoreAction.destructive = NO;
//    ignoreAction.authenticationRequired = NO;
//    
//    actionCategory = [[UIMutableUserNotificationCategory alloc] init];
//    actionCategory.identifier = NotificationCategoryIdent;
//    [actionCategory setActions:@[ ignoreAction, replyAction ] forContext:UIUserNotificationActionContextDefault];
//    [actionCategory setActions:@[ ignoreAction, replyAction ] forContext:UIUserNotificationActionContextMinimal];
//    
//    n_categories = [n_categories setByAddingObject:actionCategory];
//    
//    return %orig(types, n_categories);
//}
//%end


%hook UIDevice
- (NSString *) systemVersion {
    return @"10.1";
}
%end

%hook NSBundle
- (id)sc_groupIdentifier {
    return [WATweakHelper accountType_snapchat_group];
}
- (id)sc_keychainAccessIdentifier {
    
    return [WATweakHelper getFullAppleIdentifier:[WATweakHelper currentBundleID]];
}
//- (NSDictionary *)infoDictionary {
//    NSDictionary *dic = [self infoDictionary];
//    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
//    [dic2 setObject:@"9.42.1.2" forKey:@"CFBundleVersion"];
//    [dic2 setObject:@"9.42.1" forKey:@"CFBundleShortVersionString"];
//    
//    return [dic2 copy];
//}
%end


%end
#pragma mark -
#pragma mark - ICloud Support


%hook NSFileManager
- (NSURL *)URLForUbiquityContainerIdentifier:(NSString *)containerIdentifier {
    if ([containerIdentifier isEqualToString:@"57T9237FN3.net.whatsapp.WhatsApp"]) {
        containerIdentifier = [WATweakHelper accountType_whatsapp_icloud];
    }
    return %orig(containerIdentifier);
}
- (id)containerURLForSecurityApplicationGroupIdentifier:(NSString *)arg1 {
    id newString = arg1;
    if ([newString rangeOfString:@"group.net.whatsapp.WhatsApp.shared"].location != NSNotFound) {
        newString = [WATweakHelper accountType_whatsapp_group];
    }
    return %orig(newString);
}
%end

%hook NSUserDefaults
- (id)initWithSuiteName:(NSString *)arg1 {
    id newString = arg1;
    if ([newString rangeOfString:@"group.net.whatsapp.WhatsApp.shared"].location != NSNotFound) {
        newString = [WATweakHelper accountType_whatsapp_group];
    }
    return %orig(newString);
}
%end

%hook NSURLSession
- (id)sharedContainerIdentifier {
    id newString = %orig;
    if ([newString rangeOfString:@"group.net.whatsapp.WhatsApp.shared"].location != NSNotFound) {
        newString = [WATweakHelper accountType_whatsapp_group];
    }
    return newString;
}
- (void)setSharedContainerIdentifier:(NSString *)arg1 {
    id newString = arg1;
    if ([newString rangeOfString:@"group.net.whatsapp.WhatsApp.shared"].location != NSNotFound) {
        newString = [WATweakHelper accountType_whatsapp_group];
    }
    return %orig(newString);
}
%end


%ctor {
    
    if ([[WATweakHelper currentBundleID] containsString:@"whatsapp"] || [[WATweakHelper currentBundleID] containsString:@"waenhancer"]) {
        %init(WATweaks);
    } else if ([[WATweakHelper currentBundleID] containsString:@"picaboo"]) {
        %init(SCTweak);
    }
    %init();
}
