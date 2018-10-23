//
//  WAEnhancer9ListController.m
//  WAEnhancer9
//
//  Created by iMokhles on 23.10.2015.
//  Copyright (c) 2015 iMokhles. All rights reserved.
//

#import "WAEnhancer9Helper.h"
#import "TransNSString.h"
#import "PTPDecoder.h"
#import <sys/utsname.h>

@implementation WAEnhancer9Helper

// Preferences
+ (NSString *)preferencesPath {
	return @"/User/Library/Preferences/com.imokhles.waenhancer9.plist";
}

+ (CFStringRef)preferencesChanged {
	return (__bridge CFStringRef)@"com.imokhles.waenhancer9.preferences-changed";
}

// bundle 
+ (NSBundle *)waenhancer9_bundle {
	return [NSBundle bundleWithPath:@"/Library/Application Support/WAEnhancer9/WAEnhancer9.bundle"];
}

// UIWindow to present your elements
// u can show/hide it using ( setHidden: NO/YES )
+ (UIWindow *)mainWAEnhancer9Window {
	return [[UIApplication sharedApplication] windows][0];
}

+ (UIViewController *)mainWAEnhancer9ViewController {
	return self.mainWAEnhancer9Window.rootViewController;
}

// Checking App Version
+ (BOOL)isAppVersionGreaterThanOrEqualTo:(NSString *)appversion {
	return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] compare:appversion options:NSNumericSearch] != NSOrderedAscending;
}
+ (BOOL)isAppVersionLessThanOrEqualTo:(NSString *)appversion {
	return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] compare:appversion options:NSNumericSearch] != NSOrderedDescending;
}

// Checking OS Version
+ (BOOL)isIOS83_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3;
}
+ (BOOL)isIOS80_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0;
}
+ (BOOL)isIOS70_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}
+ (BOOL)isIOS60_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0;
}
+ (BOOL)isIOS50_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0;
}
+ (BOOL)isIOS40_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0;
}

// Checking Device Type
+ (BOOL)isIPhone6_Plus {
	return [self isIPhone] && [self screenMaxLength] == 736.0;
}
+ (BOOL)isIPhone6 {
	return [self isIPhone] && [self screenMaxLength] == 667.0;
}
+ (BOOL)isIPhone5 {
	return [self isIPhone] && [self screenMaxLength] == 568.0;
}
+ (BOOL)isIPhone4_OrLess {
	return [self isIPhone] && [self screenMaxLength] < 568.0;
}

+ (BOOL)isIphone6s_plus {
    return [[self deviceType] isEqualToString:@"iPhone 6S Plus"];
}

+ (BOOL)isIphone6s {
    return [[self deviceType] isEqualToString:@"iPhone 6S"];
}

// Checking Device Interface
+ (BOOL)isIPad {
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}
+ (BOOL)isIPhone {
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

// Checking Device Retina
+ (BOOL)isRetina {
	if ([self isIOS80_OrGreater]) {
        return [UIScreen mainScreen].nativeScale>=2;
    }
	return [[UIScreen mainScreen] scale] >= 2.0;
}

// Checking UIScreen sizes
+ (CGFloat)screenWidth {
	return [[UIScreen mainScreen] bounds].size.width;
}
+ (CGFloat)screenHeight {
	return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)screenMaxLength {
    return MAX([self screenWidth], [self screenHeight]);
}

+ (CGFloat)screenMinLength {
    return MIN([self screenWidth], [self screenHeight]);
}

+ (BOOL)isJIDExisteInList:(NSString *)jid {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *listArray = [userDefaults objectForKey:@"userJIDs"];
    NSArray *checkJIDs = [listArray copy];
    for (NSString *user in checkJIDs) {
        NSArray *userArray = [user componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
        NSString *jidUser = [userArray objectAtIndex:0];
        if ([jidUser isEqualToString:jid]) {
            return YES;
        }
    }
    return NO;
}

+ (void)writeJidToList:(NSString *)jid withStatus:(NSString *)status {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *listArray = [userDefaults objectForKey:@"userJIDs"];
    NSArray *checkJIDs = [listArray copy];
    NSString *uniqueNameStatus = nil;
    uniqueNameStatus = [NSString stringWithFormat:@"%@/%@*%lf", jid, status, [[NSDate date] timeIntervalSince1970]];
    if (!listArray) {
        listArray = [[NSMutableArray alloc] init];
        [listArray addObject:uniqueNameStatus];
        [userDefaults setObject:listArray forKey:@"userJIDs"];
        [userDefaults synchronize];
    } else {
        listArray = [[NSMutableArray alloc] init];
        [listArray addObjectsFromArray:checkJIDs];
        [listArray addObject:uniqueNameStatus];
        [userDefaults setObject:listArray forKey:@"userJIDs"];
        [userDefaults synchronize];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WARecentsUpdateTableNotifications" object:nil];
}

+ (void)writeUserJidToList:(NSString *)jid withStatus:(NSString *)status {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *listArray = [userDefaults objectForKey:@"users_JIDs"];
    NSArray *checkJIDs = [listArray copy];
    NSString *uniqueNameStatus = nil;
    uniqueNameStatus = [NSString stringWithFormat:@"%@/%@", jid, status];
    if (!listArray) {
        listArray = [[NSMutableArray alloc] init];
        [listArray addObject:uniqueNameStatus];
        [userDefaults setObject:listArray forKey:@"users_JIDs"];
        [userDefaults synchronize];
    } else {
        listArray = [[NSMutableArray alloc] init];
        [listArray addObjectsFromArray:checkJIDs];
        [listArray addObject:uniqueNameStatus];
        [userDefaults setObject:listArray forKey:@"users_JIDs"];
        [userDefaults synchronize];
    }
}

+ (void)writeChatJidToList:(NSString *)jid withStatus:(NSString *)status {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *listArray = [userDefaults objectForKey:@"locked_users_JIDs"];
    NSArray *checkJIDs = [listArray copy];
    NSString *uniqueNameStatus = nil;
    uniqueNameStatus = [NSString stringWithFormat:@"%@/%@", jid, status];
    if (!listArray) {
        listArray = [[NSMutableArray alloc] init];
        [listArray addObject:uniqueNameStatus];
        [userDefaults setObject:listArray forKey:@"locked_users_JIDs"];
        [userDefaults synchronize];
    } else {
        listArray = [[NSMutableArray alloc] init];
        [listArray addObjectsFromArray:checkJIDs];
        [listArray addObject:uniqueNameStatus];
        [userDefaults setObject:listArray forKey:@"locked_users_JIDs"];
        [userDefaults synchronize];
    }
    
    
}

+ (void)saveScheduleMessageWithText:(NSString *)message fromUser:(NSString *)fromUserJID toUser:(NSString *)toUserJID withName:(NSString *)name forDate:(NSDate *)date {
    
    NSMutableDictionary *messagesInfoMTBDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"schedulesDicts"];
    NSMutableDictionary *newMessagesMutableDict = nil;
    
    NSMutableDictionary *newMutableDict = [NSMutableDictionary new];
    NSDictionary *newDict = nil;
    
    NSMutableArray *messagesInfoArrayNEW = [NSMutableArray new];
    
    NSString *uniqueSource = [NSString stringWithFormat:@"%@%@",message,toUserJID];
    NSString *uniquescheduleID = [self MD5String:uniqueSource];
    if (!messagesInfoMTBDict) {
        messagesInfoMTBDict = [[NSMutableDictionary alloc] init];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", message] forKey:@"messageText"];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", fromUserJID] forKey:@"fromUserJID"];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", toUserJID] forKey:@"toUserJID"];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", uniquescheduleID] forKey:@"scheduleID"];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", name] forKey:@"chatName"];
        [newMutableDict setObject:date forKey:@"messageDate"];
        newDict = [newMutableDict copy];
        [messagesInfoArrayNEW addObject:newDict];
        [messagesInfoMTBDict setObject:messagesInfoArrayNEW forKey:toUserJID];
        [[NSUserDefaults standardUserDefaults] setObject:messagesInfoMTBDict forKey:@"schedulesDicts"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        newMessagesMutableDict = [[NSMutableDictionary alloc] initWithDictionary:messagesInfoMTBDict];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", message] forKey:@"messageText"];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", fromUserJID] forKey:@"fromUserJID"];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", toUserJID] forKey:@"toUserJID"];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", uniquescheduleID] forKey:@"scheduleID"];
        [newMutableDict setObject:[NSString stringWithFormat:@"%@", name] forKey:@"chatName"];
        [newMutableDict setObject:date forKey:@"messageDate"];
        newDict = [newMutableDict copy];
        NSMutableArray *currentArray = [messagesInfoMTBDict valueForKey:toUserJID];
        for (NSString *keys in [messagesInfoMTBDict allKeys]) {
            if ([keys isEqualToString:toUserJID]) {
                NSMutableArray *array = [messagesInfoMTBDict valueForKey:keys];
                for (NSDictionary *dict in array) {
                    NSString *uniqueID = dict[@"scheduleID"];
                    if ([uniqueID isEqualToString:uniquescheduleID]) {
                        return;
                    }
                }
            }
        }
        [messagesInfoArrayNEW addObjectsFromArray:currentArray];
        [messagesInfoArrayNEW addObject:newDict];
        
        [newMessagesMutableDict setObject:messagesInfoArrayNEW forKey:toUserJID];
        [[NSUserDefaults standardUserDefaults] setObject:newMessagesMutableDict forKey:@"schedulesDicts"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

+ (NSString *)MD5String:(NSString *)string {
    if(string == nil || [string length] == 0)
        return nil;
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

+ (void)getDeviceStatusWithBlock:(void(^)(BOOL isOK))gotDeviceStatusBlock {
    NSString *profile = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
//    NSString *isUDIDExiste = [JNKeychain loadValueForKey:DEVICE_KEY];
    NSString *isUDIDExiste = [objc_getClass("KeychainWrapper") keychainValueWithIdentifier:@"application:openURL:sourceApplication:annotation:"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:profile]) {
        gotDeviceStatusBlock(NO);
    } else {
        NSDictionary *profileDict = [PTPDecoder getMobileProvisionbyPath:profile];
        NSArray *devicesArray = [profileDict objectForKey:kDevicesKey];
        if ([devicesArray containsObject:isUDIDExiste]) {
            gotDeviceStatusBlock(YES);
        } else {
            gotDeviceStatusBlock(NO);
        }
        
    }
}

+ (BOOL)isUserJIDExisteInList:(NSString *)jid {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *listArray = [userDefaults objectForKey:@"users_JIDs"];
    NSArray *checkJIDs = [listArray copy];
    for (NSString *user in checkJIDs) {
        NSArray *userArray = [user componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
        NSString *jidUser = [userArray objectAtIndex:0];
        if ([jidUser isEqualToString:jid]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isChatForJDisLocked:(NSString *)jid {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *listArray = [userDefaults objectForKey:@"locked_users_JIDs"];
    NSArray *checkJIDs = [listArray copy];
    for (NSString *user in checkJIDs) {
        NSArray *userArray = [user componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
        NSString *jidUser = [userArray objectAtIndex:0];
        if ([jidUser isEqualToString:jid]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isJIDOnline:(NSString *)jid {
    XMPPConnection *xmppConnection = [objc_getClass("WASharedAppData") xmppConnection];
    return [xmppConnection isOnline:jid];
}

+ (NSString *)lastSeenDateForJID:(NSString *)jid {
    XMPPConnection *xmppConnection = [objc_getClass("WASharedAppData") xmppConnection];
    BOOL isJIDOnline = [self isJIDOnline:jid];
    NSString *onlineString = [NSString translateToAR:@"أونلاين...." toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"Online...." toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];//[[NSBundle mainBundle] localizedStringForKey:@"Online" value:@"" table:nil];
    NSString *dateString = [NSString translateToAR:@"لم يعد اونلاين" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"isn't Online" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];//[objc_getClass("WADataFormatters") lastSeenStringFromDate:dateLS];
    
    if (isJIDOnline) {
        return onlineString;
    }
    
//    if (dateString.length < 1) {
//        dateString = [objc_getClass("WADataFormatters") lastActiveStringFromDate:dateLS];
//    }
    return dateString;
}

+ (void)createLocalNotification: (NSString*)message withJID:(NSString *)jid {
    
    // [[UIApplication sharedApplication] showLocalNotification:message hasAction:NO alertAction:nil fireDate:[NSDate date]];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    notification.alertBody = message;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:jid
                                                         forKey:@"jid"];
    notification.userInfo = userDict;
    // notification.applicationIconBadgeNumber = 10;
    
    UIApplication *currentApp = [UIApplication sharedApplication];
    [currentApp presentLocalNotificationNow:notification];
    
}

+ (void)showOutSideStatusNotificationForJID:(NSString *)jid withText:(NSString *)statusText isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }
    
    // NSDate *dateToFire = [[NSDate date] dateByAddingTimeInterval:6];
    // WAChatStorage *storage = [%c(WASharedAppData) chatStorage];
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage]; //[storage newOrExistingChatSessionForJID:jid];
    WAContact *contact = [contactStorage bestContactForJID:jid];//[[%c(WAContactInfo) alloc] initWithChatSession:chatSess];
//    WAContactInfo *contactInfo = [[objc_getClass("WAContactInfo") alloc] initWithContact:contact];
    NSString *readString = [[NSBundle mainBundle] localizedStringForKey:@"Changed" value:@"" table:nil];
    NSString *messageString = [[NSBundle mainBundle] localizedStringForKey:@"Status" value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@ %@ : %@", contact.fullName, messageString, readString, statusText];
    if (group) {
        messageString = [[NSBundle mainBundle] localizedStringForKey:@"Subject" value:@"" table:nil];
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@ %@ : %@", chatSess.partnerName, messageString, readString, statusText];
    }
    [self createLocalNotification:fullMSG withJID:jid];
}

+ (void)showOutSideProfilePictureNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }
    
    
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    NSString *deliveredString = [[NSBundle mainBundle] localizedStringForKey:@"Changed" value:@"" table:nil];
    NSString *messageString = [[NSBundle mainBundle] localizedStringForKey:@"Profile Picture" value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@ %@", contact.fullName, deliveredString, messageString];
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@ %@", chatSess.partnerName, deliveredString, messageString];
    }
    
    [self createLocalNotification:fullMSG withJID:jid];
}


+ (void)showOutSideAppPresenceNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }
    
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    NSString *lastSeen = [self lastSeenDateForJID:jid];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@", contact.fullName, lastSeen];
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@", chatSess.partnerName, lastSeen];
    }
    
    [self createLocalNotification:fullMSG withJID:jid];
}

+ (void)showOutSideAppReadNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }
    
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    NSString *readString = [[NSBundle mainBundle] localizedStringForKey:@"Read" value:@"" table:nil];
    NSString *messageString = [[NSBundle mainBundle] localizedStringForKey:@"Your message" value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@ %@", contact.fullName, readString, messageString];
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@ %@", chatSess.partnerName, readString, messageString];
    }
    
    [self createLocalNotification:fullMSG withJID:jid];
}

+ (void)showOutSideDeliveredNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }
    
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    NSString *deliveredString = [[NSBundle mainBundle] localizedStringForKey:@"Delivered" value:@"" table:nil];
    NSString *messageString = [[NSBundle mainBundle] localizedStringForKey:@"Your message" value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@ %@", contact.fullName, deliveredString, messageString];
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@ %@", chatSess.partnerName, deliveredString, messageString];
    }
    
    [self createLocalNotification:fullMSG withJID:jid];
}

+ (void)showOutSideAppTypingNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }
    
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    NSString *writingString = [[NSBundle mainBundle] localizedStringForKey:@"typing..." value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@", contact.fullName, writingString];
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@", chatSess.partnerName, writingString];
    }
    
    [self createLocalNotification:fullMSG withJID:jid];
}

+ (void)showInsideStatusNotificationForJID:(NSString *)jid withText:(NSString *)statusText isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }

    // NSDate *dateToFire = [[NSDate date] dateByAddingTimeInterval:6];
    // WAChatStorage *storage = [%c(WASharedAppData) chatStorage];
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage]; //[storage newOrExistingChatSessionForJID:jid];
    WAContact *contact = [contactStorage bestContactForJID:jid];//[[%c(WAContactInfo) alloc] initWithChatSession:chatSess];
//    WAContactInfo *contactInfo = [[objc_getClass("WAContactInfo") alloc] initWithContact:contact];
    NSString *deliveredString = [[NSBundle mainBundle] localizedStringForKey:@"Changed" value:@"" table:nil];
    NSString *messageString = [[NSBundle mainBundle] localizedStringForKey:@"Status" value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@ %@ : %@", contact.fullName, messageString, deliveredString, statusText];
    
    if (group) {
        messageString = [[NSBundle mainBundle] localizedStringForKey:@"Subject" value:@"" table:nil];
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@ %@ : %@", chatSess.partnerName, messageString, deliveredString, statusText];
    }
    
    insideNoti = [CWStatusBarNotification new];
    [insideNoti setNotificationLabelBackgroundColor:[UIColor blueColor]];
    insideNoti.notificationAnimationInStyle = CWNotificationAnimationStyleTop;
    insideNoti.notificationAnimationOutStyle = CWNotificationAnimationStyleBottom;
    insideNoti.notificationStyle = CWNotificationStyleStatusBarNotification;
    [insideNoti setNotificationTappedBlock:^{
        
    }];
    
    [insideNoti displayNotificationWithMessage:fullMSG forDuration:1.5];
}

+ (void)showInsideAppProfilePictureNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }

    // NSDate *dateToFire = [[NSDate date] dateByAddingTimeInterval:6];
    // WAChatStorage *storage = [%c(WASharedAppData) chatStorage];
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage]; //[storage newOrExistingChatSessionForJID:jid];
    WAContact *contact = [contactStorage bestContactForJID:jid];//[[%c(WAContactInfo) alloc] initWithChatSession:chatSess];
//    WAContactInfo *contactInfo = [[objc_getClass("WAContactInfo") alloc] initWithContact:contact];
    NSString *readString = [[NSBundle mainBundle] localizedStringForKey:@"Changed" value:@"" table:nil];
    NSString *messageString = [[NSBundle mainBundle] localizedStringForKey:@"Profile Picture" value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@ %@", contact.fullName, readString, messageString];
    
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@ %@", chatSess.partnerName, readString, messageString];
    }
    insideNoti = [CWStatusBarNotification new];
    [insideNoti setNotificationLabelBackgroundColor:[UIColor blueColor]];
    insideNoti.notificationAnimationInStyle = CWNotificationAnimationStyleTop;
    insideNoti.notificationAnimationOutStyle = CWNotificationAnimationStyleBottom;
    insideNoti.notificationStyle = CWNotificationStyleStatusBarNotification;
    [insideNoti setNotificationTappedBlock:^{
        
    }];
    
    [insideNoti displayNotificationWithMessage:fullMSG forDuration:1.5];
}

+ (void)showInsideAppPresenceNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }

    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    NSString *lastSeen = [self lastSeenDateForJID:jid];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@", contact.fullName, lastSeen];
    
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@", chatSess.partnerName, lastSeen];
    }
    insideNoti = [CWStatusBarNotification new];
    [insideNoti setNotificationLabelBackgroundColor:[UIColor blueColor]];
    insideNoti.notificationAnimationInStyle = CWNotificationAnimationStyleTop;
    insideNoti.notificationAnimationOutStyle = CWNotificationAnimationStyleBottom;
    insideNoti.notificationStyle = CWNotificationStyleStatusBarNotification;
    [insideNoti setNotificationTappedBlock:^{
        
    }];
    
    [insideNoti displayNotificationWithMessage:fullMSG forDuration:1.5];
}

+ (void)showInsideAppTypingNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }

    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    NSString *writingString = [[NSBundle mainBundle] localizedStringForKey:@"typing..." value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@", contact.fullName, writingString];
    
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@", chatSess.partnerName, writingString];
    }
    insideNoti = [CWStatusBarNotification new];
    [insideNoti setNotificationLabelBackgroundColor:[UIColor blueColor]];
    insideNoti.notificationAnimationInStyle = CWNotificationAnimationStyleTop;
    insideNoti.notificationAnimationOutStyle = CWNotificationAnimationStyleBottom;
    insideNoti.notificationStyle = CWNotificationStyleStatusBarNotification;
    [insideNoti setNotificationTappedBlock:^{
        
    }];
    
    [insideNoti displayNotificationWithMessage:fullMSG forDuration:1.5];
}

+ (void)showInsideAppDeliveredNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }

    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    NSString *deliveredString = [[NSBundle mainBundle] localizedStringForKey:@"Delivered" value:@"" table:nil];
    NSString *messageString = [[NSBundle mainBundle] localizedStringForKey:@"Your message" value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@ %@", contact.fullName, messageString, deliveredString];
    
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@ %@", chatSess.partnerName, messageString, deliveredString];
    }
    insideNoti = [CWStatusBarNotification new];
    [insideNoti setNotificationLabelBackgroundColor:[UIColor blueColor]];
    insideNoti.notificationAnimationInStyle = CWNotificationAnimationStyleTop;
    insideNoti.notificationAnimationOutStyle = CWNotificationAnimationStyleBottom;
    insideNoti.notificationStyle = CWNotificationStyleStatusBarNotification;
    [insideNoti setNotificationTappedBlock:^{
        
    }];
    
    [insideNoti displayNotificationWithMessage:fullMSG forDuration:1.5];
}

+ (void)showInsideAppReadNotificationForJID:(NSString *)jid isGroup:(BOOL)group {
    if (![self isUserJIDExisteInList:jid]) {
        return;
    }

    
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    NSString *readString = [[NSBundle mainBundle] localizedStringForKey:@"Read" value:@"" table:nil];
    NSString *messageString = [[NSBundle mainBundle] localizedStringForKey:@"Your message" value:@"" table:nil];
    NSString *fullMSG = [NSString stringWithFormat:@"%@ %@ %@", contact.fullName, readString, messageString];
    
    if (group) {
        WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
        WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
        fullMSG = [NSString stringWithFormat:@"%@ %@ %@", chatSess.partnerName, readString, messageString];
    }
    insideNoti = [CWStatusBarNotification new];
    [insideNoti setNotificationLabelBackgroundColor:[UIColor blueColor]];
    insideNoti.notificationAnimationInStyle = CWNotificationAnimationStyleTop;
    insideNoti.notificationAnimationOutStyle = CWNotificationAnimationStyleBottom;
    insideNoti.notificationStyle = CWNotificationStyleStatusBarNotification;
    [insideNoti setNotificationTappedBlock:^{
        
    }];
    
    [insideNoti displayNotificationWithMessage:fullMSG forDuration:1.5];
}

+ (void)createLocalNotificationFromMessage:(WAMessage *)message {
    NSString *fullMessage = [NSString stringWithFormat:@"%@: %@", message.chatSession.partnerName, message.text];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    notification.alertBody = fullMessage;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:message.fromJID
                                                         forKey:@"jid"];
    notification.userInfo = userDict;
    // notification.applicationIconBadgeNumber = 10;
    
    UIApplication *currentApp = [UIApplication sharedApplication];
    [currentApp presentLocalNotificationNow:notification];
    
    
}

+ (void)scheduleLocalNotificationWithinDate:(NSDate *)date withUserInfo:(NSDictionary *)userInfo {
    
    //    NSLog(@"******* %@\n%@\n", date, [NSDate date]);
    
    NSString *timeTo = [self translatedStringAr:@"وقت الارسال الى" andEnglish:@"Time to Message"];
    NSString *fullMessage = [NSString stringWithFormat:@"%@ %@", timeTo, userInfo[@"chatName"]];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = date;
    notification.alertBody = fullMessage;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    NSDictionary *userDict = @{@"toUserJID":userInfo[@"toUserJID"],
                               @"messageText": userInfo[@"messageText"],
                               @"scheduleID": userInfo[@"scheduleID"],
                               @"toUserName": userInfo[@"chatName"]
                               };
    notification.userInfo = userDict;
    UIApplication *currentApp = [UIApplication sharedApplication];
    [currentApp scheduleLocalNotification:notification];
}

+ (void)hideStatusBar_type {
    [insideNoti dismissNotification];
}

+ (NSString *)translatedStringAr:(NSString *)arabic andEnglish:(NSString *)english {
    return [NSString translateToAR:arabic toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:english toEN_AU:english toEN_GB:english toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
}

+ (NSString *)nameFromJID:(NSString *)jid {
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    return contact.fullName;
}

+ (UIImage *) makeImage:(UIImage *)thisImage toThumbnailOfSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    // draw scaled image into thumbnail context
    [thisImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();
    // pop the context
    UIGraphicsEndImageContext();
    if(newThumbnail == nil)
        NSLog(@"could not scale image");
    return newThumbnail;
}

+(NSDate *)getCurrentLocalDate{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

+ (void)removeExpiredSchedulesWithID:(NSString *)scheduleID {
    NSMutableDictionary *messagesInfoMTBDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"schedulesDicts"] mutableCopy];
    for (NSString *keys in [messagesInfoMTBDict allKeys]) {
        NSMutableArray *array = [[messagesInfoMTBDict valueForKey:keys] mutableCopy];
        for (int i = 0;i < [array count]; i++) {
            NSDictionary *dict = [array objectAtIndex:i];
            if ([dict[@"scheduleID"] isEqualToString:scheduleID]) {
                if (array.count == 0) {
                    [array removeObjectAtIndex:i];
                    [messagesInfoMTBDict removeObjectForKey:[dict objectForKey:@"toUserJID"]];
                    [messagesInfoMTBDict setObject:array forKey:[dict objectForKey:@"toUserJID"]];
                    [[NSUserDefaults standardUserDefaults] setObject:messagesInfoMTBDict forKey:@"schedulesDicts"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                } else if (array.count == 1) {
                    [array removeObjectAtIndex:i];
                    [messagesInfoMTBDict removeObjectForKey:[dict objectForKey:@"toUserJID"]];
                    [[NSUserDefaults standardUserDefaults] setObject:messagesInfoMTBDict forKey:@"schedulesDicts"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                } else if (array.count > 1) {
                    [array removeObjectAtIndex:i];
                    [messagesInfoMTBDict setObject:array forKey:[dict objectForKey:@"toUserJID"]];
                    [[NSUserDefaults standardUserDefaults] setObject:messagesInfoMTBDict forKey:@"schedulesDicts"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }
        }
    }
}

+ (NSString *)deviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *result = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSDictionary *matches = @{
                              @"i386" : @"32-bit Simulator",
                              @"x86_64" : @"64-bit Simulator",
                              @"iPod1,1" : @"iPod Touch",
                              @"iPod2,1" : @"iPod Touch Second Generation",
                              @"iPod3,1" : @"iPod Touch Third Generation",
                              @"iPod4,1" : @"iPod Touch Fourth Generation",
                              @"iPod5,1" : @"iPod Touch Fifth Generation",
                              @"iPhone1,1" : @"iPhone",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPad1,1" : @"iPad",
                              @"iPad2,1" : @"iPad 2",
                              @"iPad3,1" : @"3rd Generation iPad",
                              @"iPad3,2" : @"iPad 3(GSM+CDMA)",
                              @"iPad3,3" : @"iPad 3(GSM)",
                              @"iPad3,4" : @"iPad 4(WiFi)",
                              @"iPad3,5" : @"iPad 4(GSM)",
                              @"iPad3,6" : @"iPad 4(GSM+CDMA)",
                              @"iPhone3,1" : @"iPhone 4",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPad3,4" : @"4th Generation iPad",
                              @"iPad2,5" : @"iPad Mini",
                              @"iPhone5,1" : @"iPhone 5(GSM)",
                              @"iPhone5,2" : @"iPhone 5(GSM+CDMA)",
                              @"iPhone5,3" : @"iPhone 5C(GSM)",
                              @"iPhone5,4" : @"iPhone 5C(GSM+CDMA)",
                              @"iPhone6,1" : @"iPhone 5S(GSM)",
                              @"iPhone6,2" : @"iPhone 5S(GSM+CDMA)",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6S",
                              @"iPhone8,2" : @"iPhone 6S Plus"
                              };
    
    if (matches[result]) {
        return matches[result];
    } else {
        return result;
    }
}

@end
