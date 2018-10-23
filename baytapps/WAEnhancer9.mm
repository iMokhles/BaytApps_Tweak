#line 1 "/Users/iMokhles/Desktop/Desktop/Apps/baytapps_tweak/baytapps/WAEnhancer9.xm"





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

#import "WAEnhancer9Helper.h"


#import "TransNSString.h"


#import "WATweakHelper.h"









#import <Parse/Parse.h>




extern "C" void AudioServicesPlaySystemSoundWithVibration(SystemSoundID inSystemSoundID, id unknown, NSDictionary *options);
static NSThread *thread;
WAMessage *waofaMessage = nil;

OneSignal *oneSignal;


extern NSString * const PayPalEnvironmentProduction;

extern NSString * const PayPalEnvironmentSandbox;

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

#include <logos/logos.h>
#include <objc/message.h>
@class WhatsAppAppDelegate; @class WAChatStorage; @class PayPalPayment; @class UIDevice; @class ChatManager; @class SCPushNotificationRegistrar; @class WAChatSessionViewController; @class UIMutableUserNotificationCategory; @class SLComposeViewController; @class WatusiManager; @class UIAlertController; @class _WAActionSheetPresenterOS8; @class WASharedAppData; @class SCAppDelegate; @class NSURLSession; @class WAMediaBrowserViewController; @class UIAlertView; @class SCChat; @class _WAAlertViewPresenterOS8; @class SCChatLogger; @class NSFileManager; @class NSUserDefaults; @class NSBundle; 
static Class _logos_superclass$_ungrouped$NSFileManager; static NSURL * (*_logos_orig$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$)(NSFileManager*, SEL, NSString *);static id (*_logos_orig$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$)(NSFileManager*, SEL, NSString *);static Class _logos_superclass$_ungrouped$NSUserDefaults; static id (*_logos_orig$_ungrouped$NSUserDefaults$initWithSuiteName$)(NSUserDefaults*, SEL, NSString *);static Class _logos_superclass$_ungrouped$NSURLSession; static id (*_logos_orig$_ungrouped$NSURLSession$sharedContainerIdentifier)(NSURLSession*, SEL);static void (*_logos_orig$_ungrouped$NSURLSession$setSharedContainerIdentifier$)(NSURLSession*, SEL, NSString *);static Class _logos_superclass$_ungrouped$PayPalPayment; static NSDecimalNumber * (*_logos_orig$_ungrouped$PayPalPayment$amount)(PayPalPayment*, SEL);static void (*_logos_orig$_ungrouped$PayPalPayment$setAmount$)(PayPalPayment*, SEL, NSDecimalNumber *);static Class _logos_superclass$_ungrouped$SLComposeViewController; static void (*_logos_orig$_ungrouped$SLComposeViewController$setInitialText$)(SLComposeViewController*, SEL, id);static Class _logos_superclass$_ungrouped$UIAlertView; static NSString * (*_logos_orig$_ungrouped$UIAlertView$message)(UIAlertView*, SEL);static NSString * (*_logos_orig$_ungrouped$UIAlertView$title)(UIAlertView*, SEL);static Class _logos_superclass$_ungrouped$UIAlertController; static NSString * (*_logos_orig$_ungrouped$UIAlertController$message)(UIAlertController*, SEL);static NSString * (*_logos_orig$_ungrouped$UIAlertController$title)(UIAlertController*, SEL);static Class _logos_superclass$_ungrouped$WatusiManager; static id (*_logos_orig$_ungrouped$WatusiManager$viewControllerForPresentingModalView)(WatusiManager*, SEL);static void (*_logos_orig$_ungrouped$WatusiManager$adViewDidFailToLoadAd$)(WatusiManager*, SEL, id);static void (*_logos_orig$_ungrouped$WatusiManager$adViewDidLoadAd$)(WatusiManager*, SEL, id);static void (*_logos_orig$_ungrouped$WatusiManager$layoutOrAddViewWithMainView$)(WatusiManager*, SEL, id);static void (*_logos_orig$_ungrouped$WatusiManager$configureTimer)(WatusiManager*, SEL);static void (*_logos_orig$_ungrouped$WatusiManager$initMoPubBanner)(WatusiManager*, SEL);static void (*_logos_orig$_ungrouped$WatusiManager$initRevMobBanner)(WatusiManager*, SEL);static void (*_logos_orig$_ungrouped$WatusiManager$initClose)(WatusiManager*, SEL);

#line 81 "/Users/iMokhles/Desktop/Desktop/Apps/baytapps_tweak/baytapps/WAEnhancer9.xm"
static Class _logos_superclass$WATweaks$UIDevice; static BOOL (*_logos_orig$WATweaks$UIDevice$wa_isDeviceSupported)(UIDevice*, SEL);static BOOL (*_logos_orig$WATweaks$UIDevice$wa_shouldBeAskedToReview)(UIDevice*, SEL);static BOOL (*_logos_orig$WATweaks$UIDevice$wa_isDeviceSuspicious)(UIDevice*, SEL);static Class _logos_superclass$WATweaks$WAMediaBrowserViewController; static void (*_logos_orig$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$)(WAMediaBrowserViewController*, SEL, id);static Class _logos_superclass$WATweaks$_WAActionSheetPresenterOS8; static void (*_logos_orig$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$)(_WAActionSheetPresenterOS8*, SEL, UIViewController *);static Class _logos_superclass$WATweaks$_WAAlertViewPresenterOS8; static void (*_logos_orig$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$)(_WAAlertViewPresenterOS8*, SEL, UIViewController *);static Class _logos_supermetaclass$WATweaks$WASharedAppData; static void (*_logos_meta_orig$WATweaks$WASharedAppData$showLocalNotificationForJailbrokenPhoneAndTerminate)(Class, SEL);static Class _logos_superclass$WATweaks$WhatsAppAppDelegate; static void (*_logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$)(WhatsAppAppDelegate*, SEL, id);static void (*_logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$)(WhatsAppAppDelegate*, SEL, id);static void (*_logos_orig$WATweaks$WhatsAppAppDelegate$registerForPushTokens)(WhatsAppAppDelegate*, SEL);static BOOL (*_logos_orig$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$)(WhatsAppAppDelegate*, SEL, id, NSURL *, id, id);static Class _logos_superclass$WATweaks$WAChatSessionViewController; static void (*_logos_orig$WATweaks$WAChatSessionViewController$presentShareDocumentController)(WAChatSessionViewController*, SEL);static void (*_logos_orig$WATweaks$WAChatSessionViewController$documentMenu$didPickDocumentPicker$)(WAChatSessionViewController*, SEL, UIDocumentMenuViewController *, UIDocumentPickerViewController *);static void (*_logos_orig$WATweaks$WAChatSessionViewController$documentPicker$didPickDocumentAtURL$)(WAChatSessionViewController*, SEL, UIDocumentPickerViewController *, NSURL *);static Class _logos_superclass$WATweaks$ChatManager; static void (*_logos_orig$WATweaks$ChatManager$chatStorage$didReceiveMessage$)(ChatManager*, SEL, id, id);static Class _logos_superclass$WATweaks$WAChatStorage; static void (*_logos_orig$WATweaks$WAChatStorage$registerSiriKitVocabularyIfNeeded)(WAChatStorage*, SEL);


static BOOL _logos_super$WATweaks$UIDevice$wa_isDeviceSupported(UIDevice* self, SEL _cmd) {return ((BOOL (*)(UIDevice*, SEL))class_getMethodImplementation(_logos_superclass$WATweaks$UIDevice, @selector(wa_isDeviceSupported)))(self, _cmd);}static BOOL _logos_method$WATweaks$UIDevice$wa_isDeviceSupported(UIDevice* self, SEL _cmd) {
    return YES;
}
static BOOL _logos_super$WATweaks$UIDevice$wa_shouldBeAskedToReview(UIDevice* self, SEL _cmd) {return ((BOOL (*)(UIDevice*, SEL))class_getMethodImplementation(_logos_superclass$WATweaks$UIDevice, @selector(wa_shouldBeAskedToReview)))(self, _cmd);}static BOOL _logos_method$WATweaks$UIDevice$wa_shouldBeAskedToReview(UIDevice* self, SEL _cmd) {
    return NO;
}
static BOOL _logos_super$WATweaks$UIDevice$wa_isDeviceSuspicious(UIDevice* self, SEL _cmd) {return ((BOOL (*)(UIDevice*, SEL))class_getMethodImplementation(_logos_superclass$WATweaks$UIDevice, @selector(wa_isDeviceSuspicious)))(self, _cmd);}static BOOL _logos_method$WATweaks$UIDevice$wa_isDeviceSuspicious(UIDevice* self, SEL _cmd) {
    return NO;
}




static void _logos_super$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$(WAMediaBrowserViewController* self, SEL _cmd, id arg1) {return ((void (*)(WAMediaBrowserViewController*, SEL, id))class_getMethodImplementation(_logos_superclass$WATweaks$WAMediaBrowserViewController, @selector(shareMediaInMessageExternally:)))(self, _cmd, arg1);}static void _logos_method$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$(WAMediaBrowserViewController* self, SEL _cmd, id arg1) {
    
    WAMessage *currentMessage = [self currentMessage];
    if ([currentMessage.messageType intValue] == 3) { 
        
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
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [WAEnhancer9Helper isIOS80_OrGreater]) {
                activityVC.popoverPresentationController.sourceView = self.view;
            }
            
            
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
            
            else {
                
                UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityVC];
                [popup presentPopoverFromRect:CGRectMake(view.frame.size.width/2, view.frame.size.height/4, 0, 0) inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
        } else {
            _logos_orig$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$(self, _cmd, arg1);
        }
    }
    
}



static void _logos_super$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$(_WAActionSheetPresenterOS8* self, SEL _cmd, UIViewController * arg1) {return ((void (*)(_WAActionSheetPresenterOS8*, SEL, UIViewController *))class_getMethodImplementation(_logos_superclass$WATweaks$_WAActionSheetPresenterOS8, @selector(presentFromViewController:)))(self, _cmd, arg1);}static void _logos_method$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$(_WAActionSheetPresenterOS8* self, SEL _cmd, UIViewController * arg1) {
    
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
        _logos_orig$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$(self, _cmd, arg1);
    }
    
}



static void _logos_super$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$(_WAAlertViewPresenterOS8* self, SEL _cmd, UIViewController * arg1) {return ((void (*)(_WAAlertViewPresenterOS8*, SEL, UIViewController *))class_getMethodImplementation(_logos_superclass$WATweaks$_WAAlertViewPresenterOS8, @selector(presentFromViewController:)))(self, _cmd, arg1);}static void _logos_method$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$(_WAAlertViewPresenterOS8* self, SEL _cmd, UIViewController * arg1) {
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
        _logos_orig$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$(self, _cmd, arg1);
    }
}


#pragma mark -
#pragma mark - jailbreak detection

static void _logos_meta_super$WATweaks$WASharedAppData$showLocalNotificationForJailbrokenPhoneAndTerminate(Class self, SEL _cmd) {return ((void (*)(Class, SEL))class_getMethodImplementation(_logos_supermetaclass$WATweaks$WASharedAppData, @selector(showLocalNotificationForJailbrokenPhoneAndTerminate)))(self, _cmd);}static void _logos_meta_method$WATweaks$WASharedAppData$showLocalNotificationForJailbrokenPhoneAndTerminate(Class self, SEL _cmd) {
    return;
}


#pragma mark -
#pragma mark - WAEnhancer Settings



#pragma mark -
#pragma mark - Login FIX



























































































































#pragma mark -
#pragma mark - Advanced Options

#pragma mark -
#pragma mark - UserInterface

#pragma mark -
#pragma mark - Hide Call Buttons

#pragma mark -
#pragma mark - App Delegate & Pervent Updates

#pragma mark - App Delegate & Pervent Updates

































static void _logos_super$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$(WhatsAppAppDelegate* self, SEL _cmd, id arg1) {return ((void (*)(WhatsAppAppDelegate*, SEL, id))class_getMethodImplementation(_logos_superclass$WATweaks$WhatsAppAppDelegate, @selector(applicationDidBecomeActive:)))(self, _cmd, arg1);}static void _logos_method$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$(WhatsAppAppDelegate* self, SEL _cmd, id arg1) {
    NSString *profile1 = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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

    
    
    
    
    _logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$(self, _cmd, arg1);
}

















    


















































































static void _logos_super$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$(WhatsAppAppDelegate* self, SEL _cmd, id arg1) {return ((void (*)(WhatsAppAppDelegate*, SEL, id))class_getMethodImplementation(_logos_superclass$WATweaks$WhatsAppAppDelegate, @selector(applicationDidEnterBackground:)))(self, _cmd, arg1);}static void _logos_method$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$(WhatsAppAppDelegate* self, SEL _cmd, id arg1) {
    






    _logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$(self, _cmd, arg1);
    [[WATweakHelper sharedInstance] startBackgroundTasks:2 target:self selector:@selector(backgroundCallback:)];
    
}



static void _logos_method$WATweaks$WhatsAppAppDelegate$backgroundCallback$(WhatsAppAppDelegate* self, SEL _cmd, id info) {
    


}













































static void _logos_super$WATweaks$WhatsAppAppDelegate$registerForPushTokens(WhatsAppAppDelegate* self, SEL _cmd) {return ((void (*)(WhatsAppAppDelegate*, SEL))class_getMethodImplementation(_logos_superclass$WATweaks$WhatsAppAppDelegate, @selector(registerForPushTokens)))(self, _cmd);}static void _logos_method$WATweaks$WhatsAppAppDelegate$registerForPushTokens(WhatsAppAppDelegate* self, SEL _cmd) {
    
    
    _logos_orig$WATweaks$WhatsAppAppDelegate$registerForPushTokens(self, _cmd);
}
static BOOL _logos_super$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$(WhatsAppAppDelegate* self, SEL _cmd, id arg1, NSURL * url, id arg3, id arg4) {return ((BOOL (*)(WhatsAppAppDelegate*, SEL, id, NSURL *, id, id))class_getMethodImplementation(_logos_superclass$WATweaks$WhatsAppAppDelegate, @selector(application:openURL:sourceApplication:annotation:)))(self, _cmd, arg1, url, arg3, arg4);}static BOOL _logos_method$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$(WhatsAppAppDelegate* self, SEL _cmd, id arg1, NSURL * url, id arg3, id arg4) {
    return _logos_orig$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$(self, _cmd, arg1, url, arg3, arg4);
}



#pragma mark -
#pragma mark - Backup

#pragma mark -
#pragma mark - WAChatSessionViewController



static void _logos_super$WATweaks$WAChatSessionViewController$presentShareDocumentController(WAChatSessionViewController* self, SEL _cmd) {return ((void (*)(WAChatSessionViewController*, SEL))class_getMethodImplementation(_logos_superclass$WATweaks$WAChatSessionViewController, @selector(presentShareDocumentController)))(self, _cmd);}static void _logos_method$WATweaks$WAChatSessionViewController$presentShareDocumentController(WAChatSessionViewController* self, SEL _cmd) {
    
    UIDocumentMenuViewController *documentPicker = [[UIDocumentMenuViewController alloc] initWithDocumentTypes:@[@"public.data"]
                                                                                                        inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = (WAChatSessionViewController *)self;
    [WAEnhancer9Helper getDeviceStatusWithBlock:^(BOOL isOK) {
        if (isOK) {
            [self _presentForCurrentInterface:documentPicker];
        }
    }];
    
    
}


static void _logos_method$WATweaks$WAChatSessionViewController$_presentForCurrentInterface$(WAChatSessionViewController* self, SEL _cmd, UIViewController * viewController) {
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


static void _logos_method$WATweaks$WAChatSessionViewController$documentPickerWasCancelled$(WAChatSessionViewController* self, SEL _cmd, UIDocumentPickerViewController * controller) {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

static void _logos_super$WATweaks$WAChatSessionViewController$documentMenu$didPickDocumentPicker$(WAChatSessionViewController* self, SEL _cmd, UIDocumentMenuViewController * documentMenu, UIDocumentPickerViewController * documentPicker) {return ((void (*)(WAChatSessionViewController*, SEL, UIDocumentMenuViewController *, UIDocumentPickerViewController *))class_getMethodImplementation(_logos_superclass$WATweaks$WAChatSessionViewController, @selector(documentMenu:didPickDocumentPicker:)))(self, _cmd, documentMenu, documentPicker);}static void _logos_method$WATweaks$WAChatSessionViewController$documentMenu$didPickDocumentPicker$(WAChatSessionViewController* self, SEL _cmd, UIDocumentMenuViewController * documentMenu, UIDocumentPickerViewController * documentPicker) {
    documentPicker.delegate = (WAChatSessionViewController *)self;
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [(WAChatSessionViewController *)self presentViewController:documentPicker animated:YES completion:nil];
    
}


static void _logos_method$WATweaks$WAChatSessionViewController$documentMenuWasCancelled$(WAChatSessionViewController* self, SEL _cmd, UIDocumentMenuViewController * documentMenu) {
    [documentMenu dismissViewControllerAnimated:YES completion:nil];
}

static void _logos_super$WATweaks$WAChatSessionViewController$documentPicker$didPickDocumentAtURL$(WAChatSessionViewController* self, SEL _cmd, UIDocumentPickerViewController * controller, NSURL * url) {return ((void (*)(WAChatSessionViewController*, SEL, UIDocumentPickerViewController *, NSURL *))class_getMethodImplementation(_logos_superclass$WATweaks$WAChatSessionViewController, @selector(documentPicker:didPickDocumentAtURL:)))(self, _cmd, controller, url);}static void _logos_method$WATweaks$WAChatSessionViewController$documentPicker$didPickDocumentAtURL$(WAChatSessionViewController* self, SEL _cmd, UIDocumentPickerViewController * controller, NSURL * url) {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSURL *fileURL = url;
        if ([fileURL isFileURL] == NO) {
            fileURL = [NSURL fileURLWithPath:url.absoluteString];
        }
        WADocumentAttachment *docAttach = [[objc_getClass("WADocumentAttachment") alloc] initWithFileURL:fileURL transferFileOwnership:YES];
        [(WAChatSessionViewController *)self sendDocumentAttachment:docAttach];
    });
    
    
}


#pragma mark -
#pragma mark - Add delete all Broadcasts


#pragma mark -
#pragma mark - Last Seend

#pragma mark -
#pragma mark - WARecentUpdates



static void _logos_super$WATweaks$ChatManager$chatStorage$didReceiveMessage$(ChatManager* self, SEL _cmd, id arg1, id arg2) {return ((void (*)(ChatManager*, SEL, id, id))class_getMethodImplementation(_logos_superclass$WATweaks$ChatManager, @selector(chatStorage:didReceiveMessage:)))(self, _cmd, arg1, arg2);}static void _logos_method$WATweaks$ChatManager$chatStorage$didReceiveMessage$(ChatManager* self, SEL _cmd, id arg1, id arg2) {
    _logos_orig$WATweaks$ChatManager$chatStorage$didReceiveMessage$(self, _cmd, arg1, arg2);
    [WAEnhancer9Helper createLocalNotificationFromMessage:arg2];
    
}





static void _logos_super$WATweaks$WAChatStorage$registerSiriKitVocabularyIfNeeded(WAChatStorage* self, SEL _cmd) {return ((void (*)(WAChatStorage*, SEL))class_getMethodImplementation(_logos_superclass$WATweaks$WAChatStorage, @selector(registerSiriKitVocabularyIfNeeded)))(self, _cmd);}static void _logos_method$WATweaks$WAChatStorage$registerSiriKitVocabularyIfNeeded(WAChatStorage* self, SEL _cmd) {
    return;
}





static Class _logos_superclass$SCTweak$SCChatLogger; static void (*_logos_orig$SCTweak$SCChatLogger$logChatReceived$from$)(SCChatLogger*, SEL, id, id);static Class _logos_superclass$SCTweak$SCChat; static void (*_logos_orig$SCTweak$SCChat$deliverMessage$)(SCChat*, SEL, id);static Class _logos_superclass$SCTweak$SCAppDelegate; static void (*_logos_orig$SCTweak$SCAppDelegate$applicationDidBecomeActive$)(SCAppDelegate*, SEL, id);static void (*_logos_orig$SCTweak$SCAppDelegate$applicationDidEnterBackground$)(SCAppDelegate*, SEL, id);static Class _logos_superclass$SCTweak$UIMutableUserNotificationCategory; static NSString * (*_logos_orig$SCTweak$UIMutableUserNotificationCategory$identifier)(UIMutableUserNotificationCategory*, SEL);static Class _logos_supermetaclass$SCTweak$SCPushNotificationRegistrar; static void (*_logos_meta_orig$SCTweak$SCPushNotificationRegistrar$registerForPushNotifications)(Class, SEL);static Class _logos_superclass$SCTweak$UIDevice; static NSString * (*_logos_orig$SCTweak$UIDevice$systemVersion)(UIDevice*, SEL);static Class _logos_superclass$SCTweak$NSBundle; static id (*_logos_orig$SCTweak$NSBundle$sc_groupIdentifier)(NSBundle*, SEL);static id (*_logos_orig$SCTweak$NSBundle$sc_keychainAccessIdentifier)(NSBundle*, SEL);




static void _logos_super$SCTweak$SCChatLogger$logChatReceived$from$(SCChatLogger* self, SEL _cmd, id arg1, id arg2) {return ((void (*)(SCChatLogger*, SEL, id, id))class_getMethodImplementation(_logos_superclass$SCTweak$SCChatLogger, @selector(logChatReceived:from:)))(self, _cmd, arg1, arg2);}static void _logos_method$SCTweak$SCChatLogger$logChatReceived$from$(SCChatLogger* self, SEL _cmd, id arg1, id arg2) {
    _logos_orig$SCTweak$SCChatLogger$logChatReceived$from$(self, _cmd, arg1, arg2);
}



static void _logos_super$SCTweak$SCChat$deliverMessage$(SCChat* self, SEL _cmd, id arg1) {return ((void (*)(SCChat*, SEL, id))class_getMethodImplementation(_logos_superclass$SCTweak$SCChat, @selector(deliverMessage:)))(self, _cmd, arg1);}static void _logos_method$SCTweak$SCChat$deliverMessage$(SCChat* self, SEL _cmd, id arg1) {
    [WATweakHelper createLocalNotificationFromMessage:arg1];
    _logos_orig$SCTweak$SCChat$deliverMessage$(self, _cmd, arg1);
}



static void _logos_super$SCTweak$SCAppDelegate$applicationDidBecomeActive$(SCAppDelegate* self, SEL _cmd, id arg1) {return ((void (*)(SCAppDelegate*, SEL, id))class_getMethodImplementation(_logos_superclass$SCTweak$SCAppDelegate, @selector(applicationDidBecomeActive:)))(self, _cmd, arg1);}static void _logos_method$SCTweak$SCAppDelegate$applicationDidBecomeActive$(SCAppDelegate* self, SEL _cmd, id arg1) {
    
    NSString *profile1 = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    













    
    
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
    
    
    
    
    _logos_orig$SCTweak$SCAppDelegate$applicationDidBecomeActive$(self, _cmd, arg1);
    
}

static void _logos_super$SCTweak$SCAppDelegate$applicationDidEnterBackground$(SCAppDelegate* self, SEL _cmd, id arg1) {return ((void (*)(SCAppDelegate*, SEL, id))class_getMethodImplementation(_logos_superclass$SCTweak$SCAppDelegate, @selector(applicationDidEnterBackground:)))(self, _cmd, arg1);}static void _logos_method$SCTweak$SCAppDelegate$applicationDidEnterBackground$(SCAppDelegate* self, SEL _cmd, id arg1) {
    
    
    
    
    
    
    [[WATweakHelper sharedInstance] startBackgroundTasks:2 target:self selector:@selector(backgroundCallback:)];
    _logos_orig$SCTweak$SCAppDelegate$applicationDidEnterBackground$(self, _cmd, arg1);
    
}



static void _logos_method$SCTweak$SCAppDelegate$backgroundCallback$(SCAppDelegate* self, SEL _cmd, id info) {
    NSLog(@"BackroundTaskRunning: %f", [UIApplication sharedApplication].backgroundTimeRemaining);
}


static void _logos_method$SCTweak$SCAppDelegate$application$handleActionWithIdentifier$forLocalNotification$withResponseInfo$completionHandler$(SCAppDelegate* self, SEL _cmd, UIApplication * application, NSString * identifier, UILocalNotification * notification, NSDictionary * responseInfo, void (^completionHandler)()) {
    

    completionHandler();
}





static NSString * _logos_super$SCTweak$UIMutableUserNotificationCategory$identifier(UIMutableUserNotificationCategory* self, SEL _cmd) {return ((NSString * (*)(UIMutableUserNotificationCategory*, SEL))class_getMethodImplementation(_logos_superclass$SCTweak$UIMutableUserNotificationCategory, @selector(identifier)))(self, _cmd);}static NSString * _logos_method$SCTweak$UIMutableUserNotificationCategory$identifier(UIMutableUserNotificationCategory* self, SEL _cmd) {
    
    id r = _logos_orig$SCTweak$UIMutableUserNotificationCategory$identifier(self, _cmd);
    
    NSLog(@"****** ID: %@", r);
    return r;
}



NSString * const NotificationCategoryIdent  = @"SCIncomingMessage";
NSString * const NotificationActionReplyIdent = @"Reply";
NSString * const NotificationActionIgnoreIndent = @"Ignore";


static void _logos_meta_super$SCTweak$SCPushNotificationRegistrar$registerForPushNotifications(Class self, SEL _cmd) {return ((void (*)(Class, SEL))class_getMethodImplementation(_logos_supermetaclass$SCTweak$SCPushNotificationRegistrar, @selector(registerForPushNotifications)))(self, _cmd);}static void _logos_meta_method$SCTweak$SCPushNotificationRegistrar$registerForPushNotifications(Class self, SEL _cmd) {
    
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








































static NSString * _logos_super$SCTweak$UIDevice$systemVersion(UIDevice* self, SEL _cmd) {return ((NSString * (*)(UIDevice*, SEL))class_getMethodImplementation(_logos_superclass$SCTweak$UIDevice, @selector(systemVersion)))(self, _cmd);}static NSString * _logos_method$SCTweak$UIDevice$systemVersion(UIDevice* self, SEL _cmd) {
    return @"10.1";
}



static id _logos_super$SCTweak$NSBundle$sc_groupIdentifier(NSBundle* self, SEL _cmd) {return ((id (*)(NSBundle*, SEL))class_getMethodImplementation(_logos_superclass$SCTweak$NSBundle, @selector(sc_groupIdentifier)))(self, _cmd);}static id _logos_method$SCTweak$NSBundle$sc_groupIdentifier(NSBundle* self, SEL _cmd) {
    return [WATweakHelper accountType_snapchat_group];
}
static id _logos_super$SCTweak$NSBundle$sc_keychainAccessIdentifier(NSBundle* self, SEL _cmd) {return ((id (*)(NSBundle*, SEL))class_getMethodImplementation(_logos_superclass$SCTweak$NSBundle, @selector(sc_keychainAccessIdentifier)))(self, _cmd);}static id _logos_method$SCTweak$NSBundle$sc_keychainAccessIdentifier(NSBundle* self, SEL _cmd) {
    
    return [WATweakHelper getFullAppleIdentifier:[WATweakHelper currentBundleID]];
}












#pragma mark -
#pragma mark - ICloud Support



static NSURL * _logos_super$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$(NSFileManager* self, SEL _cmd, NSString * containerIdentifier) {return ((NSURL * (*)(NSFileManager*, SEL, NSString *))class_getMethodImplementation(_logos_superclass$_ungrouped$NSFileManager, @selector(URLForUbiquityContainerIdentifier:)))(self, _cmd, containerIdentifier);}static NSURL * _logos_method$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$(NSFileManager* self, SEL _cmd, NSString * containerIdentifier) {
    if ([containerIdentifier isEqualToString:@"57T9237FN3.net.whatsapp.WhatsApp"]) {
        containerIdentifier = [WATweakHelper accountType_whatsapp_icloud];
    }
    return _logos_orig$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$(self, _cmd, containerIdentifier);
}
static id _logos_super$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$(NSFileManager* self, SEL _cmd, NSString * arg1) {return ((id (*)(NSFileManager*, SEL, NSString *))class_getMethodImplementation(_logos_superclass$_ungrouped$NSFileManager, @selector(containerURLForSecurityApplicationGroupIdentifier:)))(self, _cmd, arg1);}static id _logos_method$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$(NSFileManager* self, SEL _cmd, NSString * arg1) {
    id newString = arg1;
    if ([newString rangeOfString:@"group.net.whatsapp.WhatsApp.shared"].location != NSNotFound) {
        newString = [WATweakHelper accountType_whatsapp_group];
    }
    return _logos_orig$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$(self, _cmd, newString);
}



static id _logos_super$_ungrouped$NSUserDefaults$initWithSuiteName$(NSUserDefaults* self, SEL _cmd, NSString * arg1) {return ((id (*)(NSUserDefaults*, SEL, NSString *))class_getMethodImplementation(_logos_superclass$_ungrouped$NSUserDefaults, @selector(initWithSuiteName:)))(self, _cmd, arg1);}static id _logos_method$_ungrouped$NSUserDefaults$initWithSuiteName$(NSUserDefaults* self, SEL _cmd, NSString * arg1) {
    id newString = arg1;
    if ([newString rangeOfString:@"group.net.whatsapp.WhatsApp.shared"].location != NSNotFound) {
        newString = [WATweakHelper accountType_whatsapp_group];
    }
    return _logos_orig$_ungrouped$NSUserDefaults$initWithSuiteName$(self, _cmd, newString);
}



static id _logos_super$_ungrouped$NSURLSession$sharedContainerIdentifier(NSURLSession* self, SEL _cmd) {return ((id (*)(NSURLSession*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$NSURLSession, @selector(sharedContainerIdentifier)))(self, _cmd);}static id _logos_method$_ungrouped$NSURLSession$sharedContainerIdentifier(NSURLSession* self, SEL _cmd) {
    id newString = _logos_orig$_ungrouped$NSURLSession$sharedContainerIdentifier(self, _cmd);
    if ([newString rangeOfString:@"group.net.whatsapp.WhatsApp.shared"].location != NSNotFound) {
        newString = [WATweakHelper accountType_whatsapp_group];
    }
    return newString;
}
static void _logos_super$_ungrouped$NSURLSession$setSharedContainerIdentifier$(NSURLSession* self, SEL _cmd, NSString * arg1) {return ((void (*)(NSURLSession*, SEL, NSString *))class_getMethodImplementation(_logos_superclass$_ungrouped$NSURLSession, @selector(setSharedContainerIdentifier:)))(self, _cmd, arg1);}static void _logos_method$_ungrouped$NSURLSession$setSharedContainerIdentifier$(NSURLSession* self, SEL _cmd, NSString * arg1) {
    id newString = arg1;
    if ([newString rangeOfString:@"group.net.whatsapp.WhatsApp.shared"].location != NSNotFound) {
        newString = [WATweakHelper accountType_whatsapp_group];
    }
    return _logos_orig$_ungrouped$NSURLSession$setSharedContainerIdentifier$(self, _cmd, newString);
}



static NSDecimalNumber * _logos_super$_ungrouped$PayPalPayment$amount(PayPalPayment* self, SEL _cmd) {return ((NSDecimalNumber * (*)(PayPalPayment*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$PayPalPayment, @selector(amount)))(self, _cmd);}static NSDecimalNumber * _logos_method$_ungrouped$PayPalPayment$amount(PayPalPayment* self, SEL _cmd) {
    return [NSDecimalNumber decimalNumberWithString:@"0.1"];
}
static void _logos_super$_ungrouped$PayPalPayment$setAmount$(PayPalPayment* self, SEL _cmd, NSDecimalNumber * amount) {return ((void (*)(PayPalPayment*, SEL, NSDecimalNumber *))class_getMethodImplementation(_logos_superclass$_ungrouped$PayPalPayment, @selector(setAmount:)))(self, _cmd, amount);}static void _logos_method$_ungrouped$PayPalPayment$setAmount$(PayPalPayment* self, SEL _cmd, NSDecimalNumber * amount) {
    _logos_orig$_ungrouped$PayPalPayment$setAmount$(self, _cmd, [NSDecimalNumber decimalNumberWithString:@"0.1"]);
}










static void _logos_super$_ungrouped$SLComposeViewController$setInitialText$(SLComposeViewController* self, SEL _cmd, id arg1) {return ((void (*)(SLComposeViewController*, SEL, id))class_getMethodImplementation(_logos_superclass$_ungrouped$SLComposeViewController, @selector(setInitialText:)))(self, _cmd, arg1);}static void _logos_method$_ungrouped$SLComposeViewController$setInitialText$(SLComposeViewController* self, SEL _cmd, id arg1) {
    
    _logos_orig$_ungrouped$SLComposeViewController$setInitialText$(self, _cmd, @"I'm using the amazing @Bayt_Apps the first apps social network ever and powerfull signing cloud utility");
}




static NSString * _logos_super$_ungrouped$UIAlertView$message(UIAlertView* self, SEL _cmd) {return ((NSString * (*)(UIAlertView*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$UIAlertView, @selector(message)))(self, _cmd);}static NSString * _logos_method$_ungrouped$UIAlertView$message(UIAlertView* self, SEL _cmd) {
    NSString *message = _logos_orig$_ungrouped$UIAlertView$message(self, _cmd);
    if ([message containsString:@"Extensify"] || [message containsString:@"Watusi"]) {
        message = @"Thanks for installing applications from @Bayt_Apps we are the first store which support iCloud for WhatsApp and Notifications with a lot of enhancements for other apps";
    }
    return message;
}
static NSString * _logos_super$_ungrouped$UIAlertView$title(UIAlertView* self, SEL _cmd) {return ((NSString * (*)(UIAlertView*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$UIAlertView, @selector(title)))(self, _cmd);}static NSString * _logos_method$_ungrouped$UIAlertView$title(UIAlertView* self, SEL _cmd) {
    NSString *message = _logos_orig$_ungrouped$UIAlertView$title(self, _cmd);
    if ([message containsString:@"Extensify"] || [message containsString:@"Watusi"]) {
        message = @"BaytApps";
    }
    return message;
}



static NSString * _logos_super$_ungrouped$UIAlertController$message(UIAlertController* self, SEL _cmd) {return ((NSString * (*)(UIAlertController*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$UIAlertController, @selector(message)))(self, _cmd);}static NSString * _logos_method$_ungrouped$UIAlertController$message(UIAlertController* self, SEL _cmd) {
    NSString *message = _logos_orig$_ungrouped$UIAlertController$message(self, _cmd);
    if ([message containsString:@"Extensify"] || [message containsString:@"Watusi"]) {
        message = @"Thanks for installing applications from @Bayt_Apps we are the first store which support iCloud for WhatsApp and Notifications with a lot of enhancements for other apps";
    }
    return message;
}
static NSString * _logos_super$_ungrouped$UIAlertController$title(UIAlertController* self, SEL _cmd) {return ((NSString * (*)(UIAlertController*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$UIAlertController, @selector(title)))(self, _cmd);}static NSString * _logos_method$_ungrouped$UIAlertController$title(UIAlertController* self, SEL _cmd) {
    NSString *message = _logos_orig$_ungrouped$UIAlertController$title(self, _cmd);
    if ([message containsString:@"Extensify"] || [message containsString:@"Watusi"]) {
        message = @"BaytAppss";
    }
    return message;
}



static id _logos_super$_ungrouped$WatusiManager$viewControllerForPresentingModalView(WatusiManager* self, SEL _cmd) {return ((id (*)(WatusiManager*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$WatusiManager, @selector(viewControllerForPresentingModalView)))(self, _cmd);}static id _logos_method$_ungrouped$WatusiManager$viewControllerForPresentingModalView(WatusiManager* self, SEL _cmd) {
    return nil;
}
static void _logos_super$_ungrouped$WatusiManager$adViewDidFailToLoadAd$(WatusiManager* self, SEL _cmd, id arg1) {return ((void (*)(WatusiManager*, SEL, id))class_getMethodImplementation(_logos_superclass$_ungrouped$WatusiManager, @selector(adViewDidFailToLoadAd:)))(self, _cmd, arg1);}static void _logos_method$_ungrouped$WatusiManager$adViewDidFailToLoadAd$(WatusiManager* self, SEL _cmd, id arg1) {
    return;
}
static void _logos_super$_ungrouped$WatusiManager$adViewDidLoadAd$(WatusiManager* self, SEL _cmd, id arg1) {return ((void (*)(WatusiManager*, SEL, id))class_getMethodImplementation(_logos_superclass$_ungrouped$WatusiManager, @selector(adViewDidLoadAd:)))(self, _cmd, arg1);}static void _logos_method$_ungrouped$WatusiManager$adViewDidLoadAd$(WatusiManager* self, SEL _cmd, id arg1) {
    return;
}
static void _logos_super$_ungrouped$WatusiManager$layoutOrAddViewWithMainView$(WatusiManager* self, SEL _cmd, id arg1) {return ((void (*)(WatusiManager*, SEL, id))class_getMethodImplementation(_logos_superclass$_ungrouped$WatusiManager, @selector(layoutOrAddViewWithMainView:)))(self, _cmd, arg1);}static void _logos_method$_ungrouped$WatusiManager$layoutOrAddViewWithMainView$(WatusiManager* self, SEL _cmd, id arg1) {
    return;
}
static void _logos_super$_ungrouped$WatusiManager$configureTimer(WatusiManager* self, SEL _cmd) {return ((void (*)(WatusiManager*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$WatusiManager, @selector(configureTimer)))(self, _cmd);}static void _logos_method$_ungrouped$WatusiManager$configureTimer(WatusiManager* self, SEL _cmd) {
    return;
}
static void _logos_super$_ungrouped$WatusiManager$initMoPubBanner(WatusiManager* self, SEL _cmd) {return ((void (*)(WatusiManager*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$WatusiManager, @selector(initMoPubBanner)))(self, _cmd);}static void _logos_method$_ungrouped$WatusiManager$initMoPubBanner(WatusiManager* self, SEL _cmd) {
    return;
}
static void _logos_super$_ungrouped$WatusiManager$initRevMobBanner(WatusiManager* self, SEL _cmd) {return ((void (*)(WatusiManager*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$WatusiManager, @selector(initRevMobBanner)))(self, _cmd);}static void _logos_method$_ungrouped$WatusiManager$initRevMobBanner(WatusiManager* self, SEL _cmd) {
    return;
}
static void _logos_super$_ungrouped$WatusiManager$initClose(WatusiManager* self, SEL _cmd) {return ((void (*)(WatusiManager*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$WatusiManager, @selector(initClose)))(self, _cmd);}static void _logos_method$_ungrouped$WatusiManager$initClose(WatusiManager* self, SEL _cmd) {
    return;
}


static __attribute__((constructor)) void _logosLocalCtor_fe84978d() {
    
    if ([[WATweakHelper currentBundleID] containsString:@"whatsapp"] || [[WATweakHelper currentBundleID] containsString:@"waenhancer"]) {
        {Class _logos_class$WATweaks$UIDevice = objc_getClass("UIDevice"); _logos_superclass$WATweaks$UIDevice = class_getSuperclass(_logos_class$WATweaks$UIDevice); { Class _class = _logos_class$WATweaks$UIDevice;Method _method = class_getInstanceMethod(_class, @selector(wa_isDeviceSupported));if (_method) {_logos_orig$WATweaks$UIDevice$wa_isDeviceSupported = _logos_super$WATweaks$UIDevice$wa_isDeviceSupported;if (!class_addMethod(_class, @selector(wa_isDeviceSupported), (IMP)&_logos_method$WATweaks$UIDevice$wa_isDeviceSupported, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$UIDevice$wa_isDeviceSupported = (BOOL (*)(UIDevice*, SEL))method_getImplementation(_method);_logos_orig$WATweaks$UIDevice$wa_isDeviceSupported = (BOOL (*)(UIDevice*, SEL))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$UIDevice$wa_isDeviceSupported);}}}{ Class _class = _logos_class$WATweaks$UIDevice;Method _method = class_getInstanceMethod(_class, @selector(wa_shouldBeAskedToReview));if (_method) {_logos_orig$WATweaks$UIDevice$wa_shouldBeAskedToReview = _logos_super$WATweaks$UIDevice$wa_shouldBeAskedToReview;if (!class_addMethod(_class, @selector(wa_shouldBeAskedToReview), (IMP)&_logos_method$WATweaks$UIDevice$wa_shouldBeAskedToReview, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$UIDevice$wa_shouldBeAskedToReview = (BOOL (*)(UIDevice*, SEL))method_getImplementation(_method);_logos_orig$WATweaks$UIDevice$wa_shouldBeAskedToReview = (BOOL (*)(UIDevice*, SEL))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$UIDevice$wa_shouldBeAskedToReview);}}}{ Class _class = _logos_class$WATweaks$UIDevice;Method _method = class_getInstanceMethod(_class, @selector(wa_isDeviceSuspicious));if (_method) {_logos_orig$WATweaks$UIDevice$wa_isDeviceSuspicious = _logos_super$WATweaks$UIDevice$wa_isDeviceSuspicious;if (!class_addMethod(_class, @selector(wa_isDeviceSuspicious), (IMP)&_logos_method$WATweaks$UIDevice$wa_isDeviceSuspicious, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$UIDevice$wa_isDeviceSuspicious = (BOOL (*)(UIDevice*, SEL))method_getImplementation(_method);_logos_orig$WATweaks$UIDevice$wa_isDeviceSuspicious = (BOOL (*)(UIDevice*, SEL))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$UIDevice$wa_isDeviceSuspicious);}}}Class _logos_class$WATweaks$WAMediaBrowserViewController = objc_getClass("WAMediaBrowserViewController"); _logos_superclass$WATweaks$WAMediaBrowserViewController = class_getSuperclass(_logos_class$WATweaks$WAMediaBrowserViewController); { Class _class = _logos_class$WATweaks$WAMediaBrowserViewController;Method _method = class_getInstanceMethod(_class, @selector(shareMediaInMessageExternally:));if (_method) {_logos_orig$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$ = _logos_super$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$;if (!class_addMethod(_class, @selector(shareMediaInMessageExternally:), (IMP)&_logos_method$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$ = (void (*)(WAMediaBrowserViewController*, SEL, id))method_getImplementation(_method);_logos_orig$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$ = (void (*)(WAMediaBrowserViewController*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$WAMediaBrowserViewController$shareMediaInMessageExternally$);}}}Class _logos_class$WATweaks$_WAActionSheetPresenterOS8 = objc_getClass("_WAActionSheetPresenterOS8"); _logos_superclass$WATweaks$_WAActionSheetPresenterOS8 = class_getSuperclass(_logos_class$WATweaks$_WAActionSheetPresenterOS8); { Class _class = _logos_class$WATweaks$_WAActionSheetPresenterOS8;Method _method = class_getInstanceMethod(_class, @selector(presentFromViewController:));if (_method) {_logos_orig$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$ = _logos_super$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$;if (!class_addMethod(_class, @selector(presentFromViewController:), (IMP)&_logos_method$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$ = (void (*)(_WAActionSheetPresenterOS8*, SEL, UIViewController *))method_getImplementation(_method);_logos_orig$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$ = (void (*)(_WAActionSheetPresenterOS8*, SEL, UIViewController *))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$_WAActionSheetPresenterOS8$presentFromViewController$);}}}Class _logos_class$WATweaks$_WAAlertViewPresenterOS8 = objc_getClass("_WAAlertViewPresenterOS8"); _logos_superclass$WATweaks$_WAAlertViewPresenterOS8 = class_getSuperclass(_logos_class$WATweaks$_WAAlertViewPresenterOS8); { Class _class = _logos_class$WATweaks$_WAAlertViewPresenterOS8;Method _method = class_getInstanceMethod(_class, @selector(presentFromViewController:));if (_method) {_logos_orig$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$ = _logos_super$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$;if (!class_addMethod(_class, @selector(presentFromViewController:), (IMP)&_logos_method$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$ = (void (*)(_WAAlertViewPresenterOS8*, SEL, UIViewController *))method_getImplementation(_method);_logos_orig$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$ = (void (*)(_WAAlertViewPresenterOS8*, SEL, UIViewController *))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$_WAAlertViewPresenterOS8$presentFromViewController$);}}}Class _logos_class$WATweaks$WASharedAppData = objc_getClass("WASharedAppData"); Class _logos_metaclass$WATweaks$WASharedAppData = object_getClass(_logos_class$WATweaks$WASharedAppData); _logos_supermetaclass$WATweaks$WASharedAppData = class_getSuperclass(_logos_metaclass$WATweaks$WASharedAppData); { Class _class = _logos_metaclass$WATweaks$WASharedAppData;Method _method = class_getInstanceMethod(_class, @selector(showLocalNotificationForJailbrokenPhoneAndTerminate));if (_method) {_logos_meta_orig$WATweaks$WASharedAppData$showLocalNotificationForJailbrokenPhoneAndTerminate = _logos_meta_super$WATweaks$WASharedAppData$showLocalNotificationForJailbrokenPhoneAndTerminate;if (!class_addMethod(_class, @selector(showLocalNotificationForJailbrokenPhoneAndTerminate), (IMP)&_logos_meta_method$WATweaks$WASharedAppData$showLocalNotificationForJailbrokenPhoneAndTerminate, method_getTypeEncoding(_method))) {_logos_meta_orig$WATweaks$WASharedAppData$showLocalNotificationForJailbrokenPhoneAndTerminate = (void (*)(Class, SEL))method_getImplementation(_method);_logos_meta_orig$WATweaks$WASharedAppData$showLocalNotificationForJailbrokenPhoneAndTerminate = (void (*)(Class, SEL))method_setImplementation(_method, (IMP)&_logos_meta_method$WATweaks$WASharedAppData$showLocalNotificationForJailbrokenPhoneAndTerminate);}}}Class _logos_class$WATweaks$WhatsAppAppDelegate = objc_getClass("WhatsAppAppDelegate"); _logos_superclass$WATweaks$WhatsAppAppDelegate = class_getSuperclass(_logos_class$WATweaks$WhatsAppAppDelegate); { Class _class = _logos_class$WATweaks$WhatsAppAppDelegate;Method _method = class_getInstanceMethod(_class, @selector(applicationDidBecomeActive:));if (_method) {_logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$ = _logos_super$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$;if (!class_addMethod(_class, @selector(applicationDidBecomeActive:), (IMP)&_logos_method$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$ = (void (*)(WhatsAppAppDelegate*, SEL, id))method_getImplementation(_method);_logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$ = (void (*)(WhatsAppAppDelegate*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$WhatsAppAppDelegate$applicationDidBecomeActive$);}}}{ Class _class = _logos_class$WATweaks$WhatsAppAppDelegate;Method _method = class_getInstanceMethod(_class, @selector(applicationDidEnterBackground:));if (_method) {_logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$ = _logos_super$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$;if (!class_addMethod(_class, @selector(applicationDidEnterBackground:), (IMP)&_logos_method$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$ = (void (*)(WhatsAppAppDelegate*, SEL, id))method_getImplementation(_method);_logos_orig$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$ = (void (*)(WhatsAppAppDelegate*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$WhatsAppAppDelegate$applicationDidEnterBackground$);}}}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$WATweaks$WhatsAppAppDelegate, @selector(backgroundCallback:), (IMP)&_logos_method$WATweaks$WhatsAppAppDelegate$backgroundCallback$, _typeEncoding); }{ Class _class = _logos_class$WATweaks$WhatsAppAppDelegate;Method _method = class_getInstanceMethod(_class, @selector(registerForPushTokens));if (_method) {_logos_orig$WATweaks$WhatsAppAppDelegate$registerForPushTokens = _logos_super$WATweaks$WhatsAppAppDelegate$registerForPushTokens;if (!class_addMethod(_class, @selector(registerForPushTokens), (IMP)&_logos_method$WATweaks$WhatsAppAppDelegate$registerForPushTokens, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$WhatsAppAppDelegate$registerForPushTokens = (void (*)(WhatsAppAppDelegate*, SEL))method_getImplementation(_method);_logos_orig$WATweaks$WhatsAppAppDelegate$registerForPushTokens = (void (*)(WhatsAppAppDelegate*, SEL))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$WhatsAppAppDelegate$registerForPushTokens);}}}{ Class _class = _logos_class$WATweaks$WhatsAppAppDelegate;Method _method = class_getInstanceMethod(_class, @selector(application:openURL:sourceApplication:annotation:));if (_method) {_logos_orig$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$ = _logos_super$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$;if (!class_addMethod(_class, @selector(application:openURL:sourceApplication:annotation:), (IMP)&_logos_method$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$ = (BOOL (*)(WhatsAppAppDelegate*, SEL, id, NSURL *, id, id))method_getImplementation(_method);_logos_orig$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$ = (BOOL (*)(WhatsAppAppDelegate*, SEL, id, NSURL *, id, id))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$WhatsAppAppDelegate$application$openURL$sourceApplication$annotation$);}}}Class _logos_class$WATweaks$WAChatSessionViewController = objc_getClass("WAChatSessionViewController"); _logos_superclass$WATweaks$WAChatSessionViewController = class_getSuperclass(_logos_class$WATweaks$WAChatSessionViewController); { Class _class = _logos_class$WATweaks$WAChatSessionViewController;Method _method = class_getInstanceMethod(_class, @selector(presentShareDocumentController));if (_method) {_logos_orig$WATweaks$WAChatSessionViewController$presentShareDocumentController = _logos_super$WATweaks$WAChatSessionViewController$presentShareDocumentController;if (!class_addMethod(_class, @selector(presentShareDocumentController), (IMP)&_logos_method$WATweaks$WAChatSessionViewController$presentShareDocumentController, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$WAChatSessionViewController$presentShareDocumentController = (void (*)(WAChatSessionViewController*, SEL))method_getImplementation(_method);_logos_orig$WATweaks$WAChatSessionViewController$presentShareDocumentController = (void (*)(WAChatSessionViewController*, SEL))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$WAChatSessionViewController$presentShareDocumentController);}}}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIViewController *), strlen(@encode(UIViewController *))); i += strlen(@encode(UIViewController *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$WATweaks$WAChatSessionViewController, @selector(_presentForCurrentInterface:), (IMP)&_logos_method$WATweaks$WAChatSessionViewController$_presentForCurrentInterface$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIDocumentPickerViewController *), strlen(@encode(UIDocumentPickerViewController *))); i += strlen(@encode(UIDocumentPickerViewController *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$WATweaks$WAChatSessionViewController, @selector(documentPickerWasCancelled:), (IMP)&_logos_method$WATweaks$WAChatSessionViewController$documentPickerWasCancelled$, _typeEncoding); }{ Class _class = _logos_class$WATweaks$WAChatSessionViewController;Method _method = class_getInstanceMethod(_class, @selector(documentMenu:didPickDocumentPicker:));if (_method) {_logos_orig$WATweaks$WAChatSessionViewController$documentMenu$didPickDocumentPicker$ = _logos_super$WATweaks$WAChatSessionViewController$documentMenu$didPickDocumentPicker$;if (!class_addMethod(_class, @selector(documentMenu:didPickDocumentPicker:), (IMP)&_logos_method$WATweaks$WAChatSessionViewController$documentMenu$didPickDocumentPicker$, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$WAChatSessionViewController$documentMenu$didPickDocumentPicker$ = (void (*)(WAChatSessionViewController*, SEL, UIDocumentMenuViewController *, UIDocumentPickerViewController *))method_getImplementation(_method);_logos_orig$WATweaks$WAChatSessionViewController$documentMenu$didPickDocumentPicker$ = (void (*)(WAChatSessionViewController*, SEL, UIDocumentMenuViewController *, UIDocumentPickerViewController *))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$WAChatSessionViewController$documentMenu$didPickDocumentPicker$);}}}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIDocumentMenuViewController *), strlen(@encode(UIDocumentMenuViewController *))); i += strlen(@encode(UIDocumentMenuViewController *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$WATweaks$WAChatSessionViewController, @selector(documentMenuWasCancelled:), (IMP)&_logos_method$WATweaks$WAChatSessionViewController$documentMenuWasCancelled$, _typeEncoding); }{ Class _class = _logos_class$WATweaks$WAChatSessionViewController;Method _method = class_getInstanceMethod(_class, @selector(documentPicker:didPickDocumentAtURL:));if (_method) {_logos_orig$WATweaks$WAChatSessionViewController$documentPicker$didPickDocumentAtURL$ = _logos_super$WATweaks$WAChatSessionViewController$documentPicker$didPickDocumentAtURL$;if (!class_addMethod(_class, @selector(documentPicker:didPickDocumentAtURL:), (IMP)&_logos_method$WATweaks$WAChatSessionViewController$documentPicker$didPickDocumentAtURL$, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$WAChatSessionViewController$documentPicker$didPickDocumentAtURL$ = (void (*)(WAChatSessionViewController*, SEL, UIDocumentPickerViewController *, NSURL *))method_getImplementation(_method);_logos_orig$WATweaks$WAChatSessionViewController$documentPicker$didPickDocumentAtURL$ = (void (*)(WAChatSessionViewController*, SEL, UIDocumentPickerViewController *, NSURL *))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$WAChatSessionViewController$documentPicker$didPickDocumentAtURL$);}}}Class _logos_class$WATweaks$ChatManager = objc_getClass("ChatManager"); _logos_superclass$WATweaks$ChatManager = class_getSuperclass(_logos_class$WATweaks$ChatManager); { Class _class = _logos_class$WATweaks$ChatManager;Method _method = class_getInstanceMethod(_class, @selector(chatStorage:didReceiveMessage:));if (_method) {_logos_orig$WATweaks$ChatManager$chatStorage$didReceiveMessage$ = _logos_super$WATweaks$ChatManager$chatStorage$didReceiveMessage$;if (!class_addMethod(_class, @selector(chatStorage:didReceiveMessage:), (IMP)&_logos_method$WATweaks$ChatManager$chatStorage$didReceiveMessage$, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$ChatManager$chatStorage$didReceiveMessage$ = (void (*)(ChatManager*, SEL, id, id))method_getImplementation(_method);_logos_orig$WATweaks$ChatManager$chatStorage$didReceiveMessage$ = (void (*)(ChatManager*, SEL, id, id))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$ChatManager$chatStorage$didReceiveMessage$);}}}Class _logos_class$WATweaks$WAChatStorage = objc_getClass("WAChatStorage"); _logos_superclass$WATweaks$WAChatStorage = class_getSuperclass(_logos_class$WATweaks$WAChatStorage); { Class _class = _logos_class$WATweaks$WAChatStorage;Method _method = class_getInstanceMethod(_class, @selector(registerSiriKitVocabularyIfNeeded));if (_method) {_logos_orig$WATweaks$WAChatStorage$registerSiriKitVocabularyIfNeeded = _logos_super$WATweaks$WAChatStorage$registerSiriKitVocabularyIfNeeded;if (!class_addMethod(_class, @selector(registerSiriKitVocabularyIfNeeded), (IMP)&_logos_method$WATweaks$WAChatStorage$registerSiriKitVocabularyIfNeeded, method_getTypeEncoding(_method))) {_logos_orig$WATweaks$WAChatStorage$registerSiriKitVocabularyIfNeeded = (void (*)(WAChatStorage*, SEL))method_getImplementation(_method);_logos_orig$WATweaks$WAChatStorage$registerSiriKitVocabularyIfNeeded = (void (*)(WAChatStorage*, SEL))method_setImplementation(_method, (IMP)&_logos_method$WATweaks$WAChatStorage$registerSiriKitVocabularyIfNeeded);}}}}
    } else if ([[WATweakHelper currentBundleID] containsString:@"picaboo"]) {
        {Class _logos_class$SCTweak$SCChatLogger = objc_getClass("SCChatLogger"); _logos_superclass$SCTweak$SCChatLogger = class_getSuperclass(_logos_class$SCTweak$SCChatLogger); { Class _class = _logos_class$SCTweak$SCChatLogger;Method _method = class_getInstanceMethod(_class, @selector(logChatReceived:from:));if (_method) {_logos_orig$SCTweak$SCChatLogger$logChatReceived$from$ = _logos_super$SCTweak$SCChatLogger$logChatReceived$from$;if (!class_addMethod(_class, @selector(logChatReceived:from:), (IMP)&_logos_method$SCTweak$SCChatLogger$logChatReceived$from$, method_getTypeEncoding(_method))) {_logos_orig$SCTweak$SCChatLogger$logChatReceived$from$ = (void (*)(SCChatLogger*, SEL, id, id))method_getImplementation(_method);_logos_orig$SCTweak$SCChatLogger$logChatReceived$from$ = (void (*)(SCChatLogger*, SEL, id, id))method_setImplementation(_method, (IMP)&_logos_method$SCTweak$SCChatLogger$logChatReceived$from$);}}}Class _logos_class$SCTweak$SCChat = objc_getClass("SCChat"); _logos_superclass$SCTweak$SCChat = class_getSuperclass(_logos_class$SCTweak$SCChat); { Class _class = _logos_class$SCTweak$SCChat;Method _method = class_getInstanceMethod(_class, @selector(deliverMessage:));if (_method) {_logos_orig$SCTweak$SCChat$deliverMessage$ = _logos_super$SCTweak$SCChat$deliverMessage$;if (!class_addMethod(_class, @selector(deliverMessage:), (IMP)&_logos_method$SCTweak$SCChat$deliverMessage$, method_getTypeEncoding(_method))) {_logos_orig$SCTweak$SCChat$deliverMessage$ = (void (*)(SCChat*, SEL, id))method_getImplementation(_method);_logos_orig$SCTweak$SCChat$deliverMessage$ = (void (*)(SCChat*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$SCTweak$SCChat$deliverMessage$);}}}Class _logos_class$SCTweak$SCAppDelegate = objc_getClass("SCAppDelegate"); _logos_superclass$SCTweak$SCAppDelegate = class_getSuperclass(_logos_class$SCTweak$SCAppDelegate); { Class _class = _logos_class$SCTweak$SCAppDelegate;Method _method = class_getInstanceMethod(_class, @selector(applicationDidBecomeActive:));if (_method) {_logos_orig$SCTweak$SCAppDelegate$applicationDidBecomeActive$ = _logos_super$SCTweak$SCAppDelegate$applicationDidBecomeActive$;if (!class_addMethod(_class, @selector(applicationDidBecomeActive:), (IMP)&_logos_method$SCTweak$SCAppDelegate$applicationDidBecomeActive$, method_getTypeEncoding(_method))) {_logos_orig$SCTweak$SCAppDelegate$applicationDidBecomeActive$ = (void (*)(SCAppDelegate*, SEL, id))method_getImplementation(_method);_logos_orig$SCTweak$SCAppDelegate$applicationDidBecomeActive$ = (void (*)(SCAppDelegate*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$SCTweak$SCAppDelegate$applicationDidBecomeActive$);}}}{ Class _class = _logos_class$SCTweak$SCAppDelegate;Method _method = class_getInstanceMethod(_class, @selector(applicationDidEnterBackground:));if (_method) {_logos_orig$SCTweak$SCAppDelegate$applicationDidEnterBackground$ = _logos_super$SCTweak$SCAppDelegate$applicationDidEnterBackground$;if (!class_addMethod(_class, @selector(applicationDidEnterBackground:), (IMP)&_logos_method$SCTweak$SCAppDelegate$applicationDidEnterBackground$, method_getTypeEncoding(_method))) {_logos_orig$SCTweak$SCAppDelegate$applicationDidEnterBackground$ = (void (*)(SCAppDelegate*, SEL, id))method_getImplementation(_method);_logos_orig$SCTweak$SCAppDelegate$applicationDidEnterBackground$ = (void (*)(SCAppDelegate*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$SCTweak$SCAppDelegate$applicationDidEnterBackground$);}}}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SCTweak$SCAppDelegate, @selector(backgroundCallback:), (IMP)&_logos_method$SCTweak$SCAppDelegate$backgroundCallback$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIApplication *), strlen(@encode(UIApplication *))); i += strlen(@encode(UIApplication *)); memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); memcpy(_typeEncoding + i, @encode(UILocalNotification *), strlen(@encode(UILocalNotification *))); i += strlen(@encode(UILocalNotification *)); memcpy(_typeEncoding + i, @encode(NSDictionary *), strlen(@encode(NSDictionary *))); i += strlen(@encode(NSDictionary *)); memcpy(_typeEncoding + i, @encode(void (^)()), strlen(@encode(void (^)()))); i += strlen(@encode(void (^)())); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SCTweak$SCAppDelegate, @selector(application:handleActionWithIdentifier:forLocalNotification:withResponseInfo:completionHandler:), (IMP)&_logos_method$SCTweak$SCAppDelegate$application$handleActionWithIdentifier$forLocalNotification$withResponseInfo$completionHandler$, _typeEncoding); }Class _logos_class$SCTweak$UIMutableUserNotificationCategory = objc_getClass("UIMutableUserNotificationCategory"); _logos_superclass$SCTweak$UIMutableUserNotificationCategory = class_getSuperclass(_logos_class$SCTweak$UIMutableUserNotificationCategory); { Class _class = _logos_class$SCTweak$UIMutableUserNotificationCategory;Method _method = class_getInstanceMethod(_class, @selector(identifier));if (_method) {_logos_orig$SCTweak$UIMutableUserNotificationCategory$identifier = _logos_super$SCTweak$UIMutableUserNotificationCategory$identifier;if (!class_addMethod(_class, @selector(identifier), (IMP)&_logos_method$SCTweak$UIMutableUserNotificationCategory$identifier, method_getTypeEncoding(_method))) {_logos_orig$SCTweak$UIMutableUserNotificationCategory$identifier = (NSString * (*)(UIMutableUserNotificationCategory*, SEL))method_getImplementation(_method);_logos_orig$SCTweak$UIMutableUserNotificationCategory$identifier = (NSString * (*)(UIMutableUserNotificationCategory*, SEL))method_setImplementation(_method, (IMP)&_logos_method$SCTweak$UIMutableUserNotificationCategory$identifier);}}}Class _logos_class$SCTweak$SCPushNotificationRegistrar = objc_getClass("SCPushNotificationRegistrar"); Class _logos_metaclass$SCTweak$SCPushNotificationRegistrar = object_getClass(_logos_class$SCTweak$SCPushNotificationRegistrar); _logos_supermetaclass$SCTweak$SCPushNotificationRegistrar = class_getSuperclass(_logos_metaclass$SCTweak$SCPushNotificationRegistrar); { Class _class = _logos_metaclass$SCTweak$SCPushNotificationRegistrar;Method _method = class_getInstanceMethod(_class, @selector(registerForPushNotifications));if (_method) {_logos_meta_orig$SCTweak$SCPushNotificationRegistrar$registerForPushNotifications = _logos_meta_super$SCTweak$SCPushNotificationRegistrar$registerForPushNotifications;if (!class_addMethod(_class, @selector(registerForPushNotifications), (IMP)&_logos_meta_method$SCTweak$SCPushNotificationRegistrar$registerForPushNotifications, method_getTypeEncoding(_method))) {_logos_meta_orig$SCTweak$SCPushNotificationRegistrar$registerForPushNotifications = (void (*)(Class, SEL))method_getImplementation(_method);_logos_meta_orig$SCTweak$SCPushNotificationRegistrar$registerForPushNotifications = (void (*)(Class, SEL))method_setImplementation(_method, (IMP)&_logos_meta_method$SCTweak$SCPushNotificationRegistrar$registerForPushNotifications);}}}Class _logos_class$SCTweak$UIDevice = objc_getClass("UIDevice"); _logos_superclass$SCTweak$UIDevice = class_getSuperclass(_logos_class$SCTweak$UIDevice); { Class _class = _logos_class$SCTweak$UIDevice;Method _method = class_getInstanceMethod(_class, @selector(systemVersion));if (_method) {_logos_orig$SCTweak$UIDevice$systemVersion = _logos_super$SCTweak$UIDevice$systemVersion;if (!class_addMethod(_class, @selector(systemVersion), (IMP)&_logos_method$SCTweak$UIDevice$systemVersion, method_getTypeEncoding(_method))) {_logos_orig$SCTweak$UIDevice$systemVersion = (NSString * (*)(UIDevice*, SEL))method_getImplementation(_method);_logos_orig$SCTweak$UIDevice$systemVersion = (NSString * (*)(UIDevice*, SEL))method_setImplementation(_method, (IMP)&_logos_method$SCTweak$UIDevice$systemVersion);}}}Class _logos_class$SCTweak$NSBundle = objc_getClass("NSBundle"); _logos_superclass$SCTweak$NSBundle = class_getSuperclass(_logos_class$SCTweak$NSBundle); { Class _class = _logos_class$SCTweak$NSBundle;Method _method = class_getInstanceMethod(_class, @selector(sc_groupIdentifier));if (_method) {_logos_orig$SCTweak$NSBundle$sc_groupIdentifier = _logos_super$SCTweak$NSBundle$sc_groupIdentifier;if (!class_addMethod(_class, @selector(sc_groupIdentifier), (IMP)&_logos_method$SCTweak$NSBundle$sc_groupIdentifier, method_getTypeEncoding(_method))) {_logos_orig$SCTweak$NSBundle$sc_groupIdentifier = (id (*)(NSBundle*, SEL))method_getImplementation(_method);_logos_orig$SCTweak$NSBundle$sc_groupIdentifier = (id (*)(NSBundle*, SEL))method_setImplementation(_method, (IMP)&_logos_method$SCTweak$NSBundle$sc_groupIdentifier);}}}{ Class _class = _logos_class$SCTweak$NSBundle;Method _method = class_getInstanceMethod(_class, @selector(sc_keychainAccessIdentifier));if (_method) {_logos_orig$SCTweak$NSBundle$sc_keychainAccessIdentifier = _logos_super$SCTweak$NSBundle$sc_keychainAccessIdentifier;if (!class_addMethod(_class, @selector(sc_keychainAccessIdentifier), (IMP)&_logos_method$SCTweak$NSBundle$sc_keychainAccessIdentifier, method_getTypeEncoding(_method))) {_logos_orig$SCTweak$NSBundle$sc_keychainAccessIdentifier = (id (*)(NSBundle*, SEL))method_getImplementation(_method);_logos_orig$SCTweak$NSBundle$sc_keychainAccessIdentifier = (id (*)(NSBundle*, SEL))method_setImplementation(_method, (IMP)&_logos_method$SCTweak$NSBundle$sc_keychainAccessIdentifier);}}}}
    }
    {Class _logos_class$_ungrouped$NSFileManager = objc_getClass("NSFileManager"); _logos_superclass$_ungrouped$NSFileManager = class_getSuperclass(_logos_class$_ungrouped$NSFileManager); { Class _class = _logos_class$_ungrouped$NSFileManager;Method _method = class_getInstanceMethod(_class, @selector(URLForUbiquityContainerIdentifier:));if (_method) {_logos_orig$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$ = _logos_super$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$;if (!class_addMethod(_class, @selector(URLForUbiquityContainerIdentifier:), (IMP)&_logos_method$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$ = (NSURL * (*)(NSFileManager*, SEL, NSString *))method_getImplementation(_method);_logos_orig$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$ = (NSURL * (*)(NSFileManager*, SEL, NSString *))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$NSFileManager$URLForUbiquityContainerIdentifier$);}}}{ Class _class = _logos_class$_ungrouped$NSFileManager;Method _method = class_getInstanceMethod(_class, @selector(containerURLForSecurityApplicationGroupIdentifier:));if (_method) {_logos_orig$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$ = _logos_super$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$;if (!class_addMethod(_class, @selector(containerURLForSecurityApplicationGroupIdentifier:), (IMP)&_logos_method$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$ = (id (*)(NSFileManager*, SEL, NSString *))method_getImplementation(_method);_logos_orig$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$ = (id (*)(NSFileManager*, SEL, NSString *))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$NSFileManager$containerURLForSecurityApplicationGroupIdentifier$);}}}Class _logos_class$_ungrouped$NSUserDefaults = objc_getClass("NSUserDefaults"); _logos_superclass$_ungrouped$NSUserDefaults = class_getSuperclass(_logos_class$_ungrouped$NSUserDefaults); { Class _class = _logos_class$_ungrouped$NSUserDefaults;Method _method = class_getInstanceMethod(_class, @selector(initWithSuiteName:));if (_method) {_logos_orig$_ungrouped$NSUserDefaults$initWithSuiteName$ = _logos_super$_ungrouped$NSUserDefaults$initWithSuiteName$;if (!class_addMethod(_class, @selector(initWithSuiteName:), (IMP)&_logos_method$_ungrouped$NSUserDefaults$initWithSuiteName$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$NSUserDefaults$initWithSuiteName$ = (id (*)(NSUserDefaults*, SEL, NSString *))method_getImplementation(_method);_logos_orig$_ungrouped$NSUserDefaults$initWithSuiteName$ = (id (*)(NSUserDefaults*, SEL, NSString *))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$NSUserDefaults$initWithSuiteName$);}}}Class _logos_class$_ungrouped$NSURLSession = objc_getClass("NSURLSession"); _logos_superclass$_ungrouped$NSURLSession = class_getSuperclass(_logos_class$_ungrouped$NSURLSession); { Class _class = _logos_class$_ungrouped$NSURLSession;Method _method = class_getInstanceMethod(_class, @selector(sharedContainerIdentifier));if (_method) {_logos_orig$_ungrouped$NSURLSession$sharedContainerIdentifier = _logos_super$_ungrouped$NSURLSession$sharedContainerIdentifier;if (!class_addMethod(_class, @selector(sharedContainerIdentifier), (IMP)&_logos_method$_ungrouped$NSURLSession$sharedContainerIdentifier, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$NSURLSession$sharedContainerIdentifier = (id (*)(NSURLSession*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$NSURLSession$sharedContainerIdentifier = (id (*)(NSURLSession*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$NSURLSession$sharedContainerIdentifier);}}}{ Class _class = _logos_class$_ungrouped$NSURLSession;Method _method = class_getInstanceMethod(_class, @selector(setSharedContainerIdentifier:));if (_method) {_logos_orig$_ungrouped$NSURLSession$setSharedContainerIdentifier$ = _logos_super$_ungrouped$NSURLSession$setSharedContainerIdentifier$;if (!class_addMethod(_class, @selector(setSharedContainerIdentifier:), (IMP)&_logos_method$_ungrouped$NSURLSession$setSharedContainerIdentifier$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$NSURLSession$setSharedContainerIdentifier$ = (void (*)(NSURLSession*, SEL, NSString *))method_getImplementation(_method);_logos_orig$_ungrouped$NSURLSession$setSharedContainerIdentifier$ = (void (*)(NSURLSession*, SEL, NSString *))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$NSURLSession$setSharedContainerIdentifier$);}}}Class _logos_class$_ungrouped$PayPalPayment = objc_getClass("PayPalPayment"); _logos_superclass$_ungrouped$PayPalPayment = class_getSuperclass(_logos_class$_ungrouped$PayPalPayment); { Class _class = _logos_class$_ungrouped$PayPalPayment;Method _method = class_getInstanceMethod(_class, @selector(amount));if (_method) {_logos_orig$_ungrouped$PayPalPayment$amount = _logos_super$_ungrouped$PayPalPayment$amount;if (!class_addMethod(_class, @selector(amount), (IMP)&_logos_method$_ungrouped$PayPalPayment$amount, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$PayPalPayment$amount = (NSDecimalNumber * (*)(PayPalPayment*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$PayPalPayment$amount = (NSDecimalNumber * (*)(PayPalPayment*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$PayPalPayment$amount);}}}{ Class _class = _logos_class$_ungrouped$PayPalPayment;Method _method = class_getInstanceMethod(_class, @selector(setAmount:));if (_method) {_logos_orig$_ungrouped$PayPalPayment$setAmount$ = _logos_super$_ungrouped$PayPalPayment$setAmount$;if (!class_addMethod(_class, @selector(setAmount:), (IMP)&_logos_method$_ungrouped$PayPalPayment$setAmount$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$PayPalPayment$setAmount$ = (void (*)(PayPalPayment*, SEL, NSDecimalNumber *))method_getImplementation(_method);_logos_orig$_ungrouped$PayPalPayment$setAmount$ = (void (*)(PayPalPayment*, SEL, NSDecimalNumber *))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$PayPalPayment$setAmount$);}}}Class _logos_class$_ungrouped$SLComposeViewController = objc_getClass("SLComposeViewController"); _logos_superclass$_ungrouped$SLComposeViewController = class_getSuperclass(_logos_class$_ungrouped$SLComposeViewController); { Class _class = _logos_class$_ungrouped$SLComposeViewController;Method _method = class_getInstanceMethod(_class, @selector(setInitialText:));if (_method) {_logos_orig$_ungrouped$SLComposeViewController$setInitialText$ = _logos_super$_ungrouped$SLComposeViewController$setInitialText$;if (!class_addMethod(_class, @selector(setInitialText:), (IMP)&_logos_method$_ungrouped$SLComposeViewController$setInitialText$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SLComposeViewController$setInitialText$ = (void (*)(SLComposeViewController*, SEL, id))method_getImplementation(_method);_logos_orig$_ungrouped$SLComposeViewController$setInitialText$ = (void (*)(SLComposeViewController*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SLComposeViewController$setInitialText$);}}}Class _logos_class$_ungrouped$UIAlertView = objc_getClass("UIAlertView"); _logos_superclass$_ungrouped$UIAlertView = class_getSuperclass(_logos_class$_ungrouped$UIAlertView); { Class _class = _logos_class$_ungrouped$UIAlertView;Method _method = class_getInstanceMethod(_class, @selector(message));if (_method) {_logos_orig$_ungrouped$UIAlertView$message = _logos_super$_ungrouped$UIAlertView$message;if (!class_addMethod(_class, @selector(message), (IMP)&_logos_method$_ungrouped$UIAlertView$message, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$UIAlertView$message = (NSString * (*)(UIAlertView*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$UIAlertView$message = (NSString * (*)(UIAlertView*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$UIAlertView$message);}}}{ Class _class = _logos_class$_ungrouped$UIAlertView;Method _method = class_getInstanceMethod(_class, @selector(title));if (_method) {_logos_orig$_ungrouped$UIAlertView$title = _logos_super$_ungrouped$UIAlertView$title;if (!class_addMethod(_class, @selector(title), (IMP)&_logos_method$_ungrouped$UIAlertView$title, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$UIAlertView$title = (NSString * (*)(UIAlertView*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$UIAlertView$title = (NSString * (*)(UIAlertView*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$UIAlertView$title);}}}Class _logos_class$_ungrouped$UIAlertController = objc_getClass("UIAlertController"); _logos_superclass$_ungrouped$UIAlertController = class_getSuperclass(_logos_class$_ungrouped$UIAlertController); { Class _class = _logos_class$_ungrouped$UIAlertController;Method _method = class_getInstanceMethod(_class, @selector(message));if (_method) {_logos_orig$_ungrouped$UIAlertController$message = _logos_super$_ungrouped$UIAlertController$message;if (!class_addMethod(_class, @selector(message), (IMP)&_logos_method$_ungrouped$UIAlertController$message, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$UIAlertController$message = (NSString * (*)(UIAlertController*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$UIAlertController$message = (NSString * (*)(UIAlertController*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$UIAlertController$message);}}}{ Class _class = _logos_class$_ungrouped$UIAlertController;Method _method = class_getInstanceMethod(_class, @selector(title));if (_method) {_logos_orig$_ungrouped$UIAlertController$title = _logos_super$_ungrouped$UIAlertController$title;if (!class_addMethod(_class, @selector(title), (IMP)&_logos_method$_ungrouped$UIAlertController$title, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$UIAlertController$title = (NSString * (*)(UIAlertController*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$UIAlertController$title = (NSString * (*)(UIAlertController*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$UIAlertController$title);}}}Class _logos_class$_ungrouped$WatusiManager = objc_getClass("WatusiManager"); _logos_superclass$_ungrouped$WatusiManager = class_getSuperclass(_logos_class$_ungrouped$WatusiManager); { Class _class = _logos_class$_ungrouped$WatusiManager;Method _method = class_getInstanceMethod(_class, @selector(viewControllerForPresentingModalView));if (_method) {_logos_orig$_ungrouped$WatusiManager$viewControllerForPresentingModalView = _logos_super$_ungrouped$WatusiManager$viewControllerForPresentingModalView;if (!class_addMethod(_class, @selector(viewControllerForPresentingModalView), (IMP)&_logos_method$_ungrouped$WatusiManager$viewControllerForPresentingModalView, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$WatusiManager$viewControllerForPresentingModalView = (id (*)(WatusiManager*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$WatusiManager$viewControllerForPresentingModalView = (id (*)(WatusiManager*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$WatusiManager$viewControllerForPresentingModalView);}}}{ Class _class = _logos_class$_ungrouped$WatusiManager;Method _method = class_getInstanceMethod(_class, @selector(adViewDidFailToLoadAd:));if (_method) {_logos_orig$_ungrouped$WatusiManager$adViewDidFailToLoadAd$ = _logos_super$_ungrouped$WatusiManager$adViewDidFailToLoadAd$;if (!class_addMethod(_class, @selector(adViewDidFailToLoadAd:), (IMP)&_logos_method$_ungrouped$WatusiManager$adViewDidFailToLoadAd$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$WatusiManager$adViewDidFailToLoadAd$ = (void (*)(WatusiManager*, SEL, id))method_getImplementation(_method);_logos_orig$_ungrouped$WatusiManager$adViewDidFailToLoadAd$ = (void (*)(WatusiManager*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$WatusiManager$adViewDidFailToLoadAd$);}}}{ Class _class = _logos_class$_ungrouped$WatusiManager;Method _method = class_getInstanceMethod(_class, @selector(adViewDidLoadAd:));if (_method) {_logos_orig$_ungrouped$WatusiManager$adViewDidLoadAd$ = _logos_super$_ungrouped$WatusiManager$adViewDidLoadAd$;if (!class_addMethod(_class, @selector(adViewDidLoadAd:), (IMP)&_logos_method$_ungrouped$WatusiManager$adViewDidLoadAd$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$WatusiManager$adViewDidLoadAd$ = (void (*)(WatusiManager*, SEL, id))method_getImplementation(_method);_logos_orig$_ungrouped$WatusiManager$adViewDidLoadAd$ = (void (*)(WatusiManager*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$WatusiManager$adViewDidLoadAd$);}}}{ Class _class = _logos_class$_ungrouped$WatusiManager;Method _method = class_getInstanceMethod(_class, @selector(layoutOrAddViewWithMainView:));if (_method) {_logos_orig$_ungrouped$WatusiManager$layoutOrAddViewWithMainView$ = _logos_super$_ungrouped$WatusiManager$layoutOrAddViewWithMainView$;if (!class_addMethod(_class, @selector(layoutOrAddViewWithMainView:), (IMP)&_logos_method$_ungrouped$WatusiManager$layoutOrAddViewWithMainView$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$WatusiManager$layoutOrAddViewWithMainView$ = (void (*)(WatusiManager*, SEL, id))method_getImplementation(_method);_logos_orig$_ungrouped$WatusiManager$layoutOrAddViewWithMainView$ = (void (*)(WatusiManager*, SEL, id))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$WatusiManager$layoutOrAddViewWithMainView$);}}}{ Class _class = _logos_class$_ungrouped$WatusiManager;Method _method = class_getInstanceMethod(_class, @selector(configureTimer));if (_method) {_logos_orig$_ungrouped$WatusiManager$configureTimer = _logos_super$_ungrouped$WatusiManager$configureTimer;if (!class_addMethod(_class, @selector(configureTimer), (IMP)&_logos_method$_ungrouped$WatusiManager$configureTimer, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$WatusiManager$configureTimer = (void (*)(WatusiManager*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$WatusiManager$configureTimer = (void (*)(WatusiManager*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$WatusiManager$configureTimer);}}}{ Class _class = _logos_class$_ungrouped$WatusiManager;Method _method = class_getInstanceMethod(_class, @selector(initMoPubBanner));if (_method) {_logos_orig$_ungrouped$WatusiManager$initMoPubBanner = _logos_super$_ungrouped$WatusiManager$initMoPubBanner;if (!class_addMethod(_class, @selector(initMoPubBanner), (IMP)&_logos_method$_ungrouped$WatusiManager$initMoPubBanner, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$WatusiManager$initMoPubBanner = (void (*)(WatusiManager*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$WatusiManager$initMoPubBanner = (void (*)(WatusiManager*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$WatusiManager$initMoPubBanner);}}}{ Class _class = _logos_class$_ungrouped$WatusiManager;Method _method = class_getInstanceMethod(_class, @selector(initRevMobBanner));if (_method) {_logos_orig$_ungrouped$WatusiManager$initRevMobBanner = _logos_super$_ungrouped$WatusiManager$initRevMobBanner;if (!class_addMethod(_class, @selector(initRevMobBanner), (IMP)&_logos_method$_ungrouped$WatusiManager$initRevMobBanner, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$WatusiManager$initRevMobBanner = (void (*)(WatusiManager*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$WatusiManager$initRevMobBanner = (void (*)(WatusiManager*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$WatusiManager$initRevMobBanner);}}}{ Class _class = _logos_class$_ungrouped$WatusiManager;Method _method = class_getInstanceMethod(_class, @selector(initClose));if (_method) {_logos_orig$_ungrouped$WatusiManager$initClose = _logos_super$_ungrouped$WatusiManager$initClose;if (!class_addMethod(_class, @selector(initClose), (IMP)&_logos_method$_ungrouped$WatusiManager$initClose, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$WatusiManager$initClose = (void (*)(WatusiManager*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$WatusiManager$initClose = (void (*)(WatusiManager*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$WatusiManager$initClose);}}}}
}
