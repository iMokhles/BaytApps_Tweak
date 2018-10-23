//
//  WATweakHelper.m
//  WAEnhancer9
//
//  Created by iMokhles on 11/05/16.
//
//

#import "WATweakHelper.h"
#import <AVFoundation/AVFoundation.h>

__attribute__((always_inline, visibility("hidden")))
void interruptionListenerCallback (void *inUserData, UInt32 interruptionState);

@implementation WATweakHelper


-(id) init
{
    self = [super init];
    if(self)
    {
        bgTask =UIBackgroundTaskInvalid;
        expirationHandler =nil;
        timer =nil;
        
    }
    return  self;
    
}

-(void) startBackgroundTasks:(NSInteger)time_  target:(id)target_ selector:(SEL)selector_
{
    timerInterval =time_;
    target = target_;
    selector = selector_;
    
    [self initBackgroudTask];
    
    //minimum 600 sec
    [[UIApplication sharedApplication] setKeepAliveTimeout:900 handler:^{
        [self initBackgroudTask];
    }];
}
-(void) initBackgroudTask
{
    
    dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       if([self running])
                           [self stopAudio];
                       
                       while([self running])
                       {
                           [NSThread sleepForTimeInterval:2]; //wait for finish
                       }
                       [self playAudio];
                   });
    
}
- (void) audioInterrupted:(NSNotification*)notification
{
    NSDictionary *interuptionDict = notification.userInfo;
    NSNumber *interuptionType = [interuptionDict valueForKey:AVAudioSessionInterruptionTypeKey];
    if([interuptionType intValue] == 1)
    {
        [self initBackgroudTask];
    }
    
}
__attribute__((always_inline, visibility("hidden")))
void interruptionListenerCallback (void *inUserData, UInt32 interruptionState)
{
    //NSLog(@"Got Interrupt######");
    if (interruptionState == kAudioSessionBeginInterruption)
    {
        /// [self initBackgroudTask];
    }
}
-(void) playAudio
{
    
    UIApplication * app = [UIApplication sharedApplication];
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    if([version floatValue] >= 6.0f)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioInterrupted:) name:AVAudioSessionInterruptionNotification object:nil];
    }
    else
    {
        AudioSessionInitialize(NULL, NULL, interruptionListenerCallback, nil);
        
    }
    expirationHandler = ^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
        [timer invalidate];
        [player stop];
        NSLog(@"BGTask Expired.");
//         [self playAudio];
    };
    bgTask = [app beginBackgroundTaskWithExpirationHandler:expirationHandler];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        const char bytes[] = {0x52, 0x49, 0x46, 0x46, 0x26, 0x0, 0x0, 0x0, 0x57, 0x41, 0x56, 0x45, 0x66, 0x6d, 0x74, 0x20, 0x10, 0x0, 0x0, 0x0, 0x1, 0x0, 0x1, 0x0, 0x44, 0xac, 0x0, 0x0, 0x88, 0x58, 0x1, 0x0, 0x2, 0x0, 0x10, 0x0, 0x64, 0x61, 0x74, 0x61, 0x2, 0x0, 0x0, 0x0, 0xfc, 0xff};
//        NSData* data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
//        NSString * docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//        
//        // Build the path to the database file
//        NSString * filePath = [[NSString alloc] initWithString:
//                               [docsDir stringByAppendingPathComponent: @"background.wav"]];
//        [data writeToFile:filePath atomically:YES];
        
        NSString *filePath = [WATweakHelper pathForTweakFileWithName:@"imo_tweak_song" extension:@"mp3"];
        
        //[[NSBundle mainBundle] pathForResource:@"imo_tweak_song" ofType:@"mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
        
        NSURL *soundFileURL = fileURL; //[NSURL fileURLWithPath:filePath];
        OSStatus osStatus;
        NSError * error;
        if([version floatValue] >= 6.0f)
        {
            
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
            [[AVAudioSession sharedInstance] setActive: YES error: &error];
            
        }
        else
        {
            osStatus = AudioSessionSetActive(true);
            
            UInt32 category = kAudioSessionCategory_MediaPlayback;
            osStatus = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
            
            UInt32 allowMixing = true;
            osStatus = AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof (allowMixing), &allowMixing );
        }
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
        player.volume = 0.01;
        player.numberOfLoops = -1; //Infinite
        [player prepareToPlay];
        [player play];
        timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:target selector:selector userInfo:nil repeats:YES];
        
    });
}

-(void) stopAudio
{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    if([version floatValue] >= 6.0f)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionInterruptionNotification object:nil];
    }
    if(timer != nil && [timer isValid])
        [timer invalidate];
    
    if(player != nil && [player isPlaying])
        [player stop];
    
    if(bgTask != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        bgTask=UIBackgroundTaskInvalid;
    }
}
-(BOOL) running
{
    if(bgTask == UIBackgroundTaskInvalid)
        return FALSE;
    return TRUE;
}
-(void) stopBackgroundTask
{
    [self stopAudio];
}

+ (id)sharedInstance {
    static WATweakHelper *__sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[self alloc] init];
    });
    
    return __sharedInstance;
}

+ (BOOL)isRunningInOpenEnv {
    return ![[NSFileManager defaultManager] fileExistsAtPath:kWATweakBundlePath];
}

+ (NSString *)tweakBundlePath {
    if ([WATweakHelper isRunningInOpenEnv]) {
        return @"/Library/Application Support/BaytApps/baytapps.bundle";
    } else {
        return kWATweakBundlePath;
    }
}

+ (NSBundle *)tweakBundle {
    return [NSBundle bundleWithPath:[[self class] tweakBundlePath]];
}

+ (NSString *)pathForTweakFileWithName:(NSString *)name extension:(NSString *)extension {
    NSString *pathInTweakDir = [[[[self class] tweakBundlePath] stringByAppendingPathComponent:name] stringByAppendingPathExtension:extension ? : @""];
    return [[NSFileManager defaultManager] fileExistsAtPath:pathInTweakDir] ? pathInTweakDir : nil;
}

+ (NSURL *)urlForTweakFileWithName:(NSString *)name extension:(NSString *)extension {
    NSURL *urlInTweakDir = [NSURL fileURLWithPath:[[[[self class] tweakBundlePath] stringByAppendingPathComponent:name] stringByAppendingPathExtension:extension ? : @""]];
    return [[NSFileManager defaultManager] fileExistsAtPath:[urlInTweakDir path]] ? urlInTweakDir : nil;
}

+(NSDictionary*) getMobileProvisionbyPath:(NSString *)path
{
    NSDictionary* mobileProvision = nil;
    if (!mobileProvision) {
        NSString *provisioningPath = path;
        if (!provisioningPath) {
            mobileProvision = @{};
            return mobileProvision;
        }
        NSString *binaryString = [NSString stringWithContentsOfFile:provisioningPath encoding:NSISOLatin1StringEncoding error:NULL];
        if (!binaryString) {
            return nil;
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
            return nil;
        }
    }
    return mobileProvision;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA1_noti_ipa() {
    char s_New[] = {0x36, 0x67, 0x66, 0x38, 0x69, 0x6c, 0x6b, 0x6c, 0x36, 0x43, 0x6e, 0x3f, 0x3e, 0x3b, 0x43, 0x46, 0x74, 0x49, 0x40, 0x4d, 0x78, 0x46, 0x7a, 0x45, 0x4e, 0x4d, 0x4d, 0x52, 0x53, 0x57, 0xffffff81, 0xffffff84, 0xffffff86, 0xffffff88, 0x54, 0xffffff89, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

//__attribute__((always_inline, visibility("hidden")))
//static NSString *WA2_noti_ipa() {
//    char s_New[] = {0x6a, 0x45, 0x6f, 0x73, 0x7a, 0x6a, 0x35, 0x6b, 0x78, 0x77, 0x39, 0x75, 0x7a, 0x7d, 0x7a, 0x78, 0x7d, 0x77, 0xffffff86, 0x42, 0xffffff8c, 0x77, 0x7c, 0xffffff86, 0xffffff81, 0x7b, 0xffffff89, 0x7f, 0xffffff82, 0xffffff90, 0xffffff80, 0xffffff88, 0xffffff8e, 0xffffff87, 0xffffff87, 0x55, 0x00};
//    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
//    {
//        s_New[i] = s_New[i] - (0x01 * (i + 1));
//    }
//    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
//    
//    return new_PATH;
//}
//
//__attribute__((always_inline, visibility("hidden")))
//static NSString *WA3_noti_ipa() {
//    char s_New[] = {0x6a, 0x45, 0x6f, 0x73, 0x7a, 0x6a, 0x35, 0x6b, 0x78, 0x77, 0x39, 0x75, 0x7a, 0x7d, 0x7a, 0x78, 0x7d, 0x77, 0xffffff86, 0x42, 0xffffff8c, 0x77, 0x7c, 0xffffff86, 0xffffff81, 0x7b, 0xffffff89, 0x7f, 0xffffff82, 0xffffff90, 0xffffff80, 0xffffff8e, 0x52, 0x00};
//    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
//    {
//        s_New[i] = s_New[i] - (0x01 * (i + 1));
//    }
//    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
//    
//    return new_PATH;
//}
//
//__attribute__((always_inline, visibility("hidden")))
//static NSString *WA4_noti_ipa() {
//    char s_New[] = {0x6a, 0x45, 0x6f, 0x73, 0x7a, 0x6a, 0x35, 0x6b, 0x78, 0x77, 0x39, 0x75, 0x7a, 0x7d, 0x7a, 0x78, 0x7d, 0x77, 0xffffff86, 0x42, 0xffffff8c, 0x77, 0x7c, 0xffffff86, 0xffffff81, 0x7b, 0xffffff89, 0x7f, 0xffffff82, 0xffffff90, 0xffffff88, 0xffffff8d, 0x00};
//    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
//    {
//        s_New[i] = s_New[i] - (0x01 * (i + 1));
//    }
//    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
//    
//    return new_PATH;
//}
//
//__attribute__((always_inline, visibility("hidden")))
//static NSString *WA5_noti_ipa() {
//    char s_New[] = {0x64, 0x71, 0x70, 0x32, 0x6e, 0x73, 0x76, 0x73, 0x71, 0x76, 0x70, 0x7f, 0x3b, 0xffffff85, 0x70, 0x75, 0x7f, 0x7a, 0x74, 0xffffff82, 0x78, 0x7b, 0xffffff89, 0xffffff81, 0xffffff89, 0x7b, 0x50, 0x00};
//    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
//    {
//        s_New[i] = s_New[i] - (0x01 * (i + 1));
//    }
//    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
//    
//    return new_PATH;
//}
//
//__attribute__((always_inline, visibility("hidden")))
//static NSString *WA6_noti_ipa() {
//    char s_New[] = {0x64, 0x71, 0x70, 0x32, 0x6e, 0x73, 0x76, 0x73, 0x71, 0x76, 0x70, 0x7f, 0x3b, 0xffffff85, 0x70, 0x75, 0x7f, 0x7a, 0x74, 0xffffff82, 0x78, 0x7b, 0xffffff89, 0xffffff81, 0xffffff89, 0x7b, 0x51, 0x00};
//    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
//    {
//        s_New[i] = s_New[i] - (0x01 * (i + 1));
//    }
//    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
//    
//    return new_PATH;
//}

+ (NSString *)accountType_whatsapp_noti_id {
    
    NSString *provisioningPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:provisioningPath]) {
#if TARGET_IPHONE_SIMULATOR
        return @"ipa";
#else
        return @"isn't existe";
#endif
    }
    NSDictionary *profile = [WATweakHelper getMobileProvisionbyPath:provisioningPath];
    NSString *teamID = [profile[@"TeamIdentifier"] objectAtIndex:0];
    NSString *teamID2 = profile[@"UUID"];
    NSString *accountType;
    if (teamID.length > 0) {
        if ([teamID2 isEqualToString:@"dd7dc237-6c96-4b70-b671-f06b7682c847"] && [teamID isEqualToString:@"KH5MPTCV98"]) accountType = WA1_noti_ipa();
//        else if ([teamID isEqualToString:@"FC4F38T32K"]) accountType = WA2_ipa();
//        else if ([teamID isEqualToString:@"2EPK7SEG45"]) accountType = WA3_ipa();
//        else if ([teamID isEqualToString:@"EAST223S7M"]) accountType = WA4_ipa();
//        else if ([teamID isEqualToString:@"6SH9WE2ENU"]) accountType = WA5_ipa();
//        else if ([teamID isEqualToString:@"3QZW2N7S46"]) accountType = WA6_ipa();
        else if (![teamID2 isEqualToString:@"dd7dc237-6c96-4b70-b671-f06b7682c847"] && [teamID isEqualToString:@"KH5MPTCV98"]) accountType = WA1_noti_ipa();
    } else {
        accountType = @"wrong";
    }
#if TARGET_IPHONE_SIMULATOR
    return @"ipa";
#else
    return accountType;
#endif
}

+ (NSString *)accountType {
    NSString *provisioningPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:provisioningPath]) {
#if TARGET_IPHONE_SIMULATOR
        return @"ipa";
#else
        return @"isn't existe";
#endif
    }
    NSDictionary *profile = [WATweakHelper getMobileProvisionbyPath:provisioningPath];
    NSString *teamID = [profile[@"TeamIdentifier"] objectAtIndex:0];
    NSString *teamID2 = profile[@"UUID"];
    NSString *accountType;
    if (teamID.length > 0) {
        if ([teamID2 isEqualToString:@"dd7dc237-6c96-4b70-b671-f06b7682c847"] &&[teamID isEqualToString:@"KH5MPTCV98"]) accountType = @"ipa";
        else if ([teamID isEqualToString:@"FC4F38T32K"]) accountType = @"ipa2";
        else if ([teamID isEqualToString:@"2EPK7SEG45"]) accountType = @"ipa3";
        else if ([teamID isEqualToString:@"EAST223S7M"]) accountType = @"ipa4";
        else if ([teamID isEqualToString:@"6SH9WE2ENU"]) accountType = @"ipa5";
        else if ([teamID isEqualToString:@"3QZW2N7S46"]) accountType = @"ipa6";
        else if (![teamID2 isEqualToString:@"dd7dc237-6c96-4b70-b671-f06b7682c847"] && [teamID isEqualToString:@"KH5MPTCV98"]) accountType = @"ipa7";
    } else {
        accountType = @"wrong";
    }
#if TARGET_IPHONE_SIMULATOR
    return @"simulator";
#else
    return accountType;
#endif
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA1_ipa() {
    char s_New[] = {0x6a, 0x45, 0x6f, 0x73, 0x7a, 0x6a, 0x35, 0x6b, 0x78, 0x77, 0x39, 0x75, 0x7a, 0x7d, 0x7a, 0x78, 0x7d, 0x77, 0xffffff86, 0x42, 0xffffff8c, 0x77, 0x7c, 0xffffff86, 0xffffff81, 0x7b, 0xffffff89, 0x7f, 0xffffff82, 0xffffff90, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA2_ipa() {
    char s_New[] = {0x6a, 0x45, 0x6f, 0x73, 0x7a, 0x6a, 0x35, 0x6b, 0x78, 0x77, 0x39, 0x75, 0x7a, 0x7d, 0x7a, 0x78, 0x7d, 0x77, 0xffffff86, 0x42, 0xffffff8c, 0x77, 0x7c, 0xffffff86, 0xffffff81, 0x7b, 0xffffff89, 0x7f, 0xffffff82, 0xffffff90, 0xffffff80, 0xffffff88, 0xffffff8e, 0xffffff87, 0xffffff87, 0x55, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA3_ipa() {
    char s_New[] = {0x6a, 0x45, 0x6f, 0x73, 0x7a, 0x6a, 0x35, 0x6b, 0x78, 0x77, 0x39, 0x75, 0x7a, 0x7d, 0x7a, 0x78, 0x7d, 0x77, 0xffffff86, 0x42, 0xffffff8c, 0x77, 0x7c, 0xffffff86, 0xffffff81, 0x7b, 0xffffff89, 0x7f, 0xffffff82, 0xffffff90, 0xffffff80, 0xffffff8e, 0x52, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA4_ipa() {
    char s_New[] = {0x6a, 0x45, 0x6f, 0x73, 0x7a, 0x6a, 0x35, 0x6b, 0x78, 0x77, 0x39, 0x75, 0x7a, 0x7d, 0x7a, 0x78, 0x7d, 0x77, 0xffffff86, 0x42, 0xffffff8c, 0x77, 0x7c, 0xffffff86, 0xffffff81, 0x7b, 0xffffff89, 0x7f, 0xffffff82, 0xffffff90, 0xffffff88, 0xffffff8d, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA5_ipa() {
    char s_New[] = {0x64, 0x71, 0x70, 0x32, 0x6e, 0x73, 0x76, 0x73, 0x71, 0x76, 0x70, 0x7f, 0x3b, 0xffffff85, 0x70, 0x75, 0x7f, 0x7a, 0x74, 0xffffff82, 0x78, 0x7b, 0xffffff89, 0xffffff81, 0xffffff89, 0x7b, 0x50, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA6_ipa() {
    char s_New[] = {0x64, 0x71, 0x70, 0x32, 0x6e, 0x73, 0x76, 0x73, 0x71, 0x76, 0x70, 0x7f, 0x3b, 0xffffff85, 0x70, 0x75, 0x7f, 0x7a, 0x74, 0xffffff82, 0x78, 0x7b, 0xffffff89, 0xffffff81, 0xffffff89, 0x7b, 0x51, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

+ (NSString *)accountType_whatsapp_icloud {
    NSString *provisioningPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:provisioningPath]) {
#if TARGET_IPHONE_SIMULATOR
        return @"ipa";
#else
        return @"isn't existe";
#endif
    }
    NSDictionary *profile = [WATweakHelper getMobileProvisionbyPath:provisioningPath];
    NSString *teamID = [profile[@"TeamIdentifier"] objectAtIndex:0];
    NSString *teamID2 = profile[@"UUID"];
    NSString *accountType;
    if (teamID.length > 0) {
        if ([teamID2 isEqualToString:@"dd7dc237-6c96-4b70-b671-f06b7682c847"] && [teamID isEqualToString:@"KH5MPTCV98"]) accountType = WA1_ipa();
        else if ([teamID isEqualToString:@"FC4F38T32K"]) accountType = WA2_ipa();
        else if ([teamID isEqualToString:@"2EPK7SEG45"]) accountType = WA3_ipa();
        else if ([teamID isEqualToString:@"EAST223S7M"]) accountType = WA4_ipa();
        else if ([teamID isEqualToString:@"6SH9WE2ENU"]) accountType = WA5_ipa();
        else if ([teamID isEqualToString:@"3QZW2N7S46"]) accountType = WA6_ipa();
        else if (![teamID2 isEqualToString:@"dd7dc237-6c96-4b70-b671-f06b7682c847"] && [teamID isEqualToString:@"KH5MPTCV98"]) accountType = WA1_ipa();
    } else {
        accountType = @"wrong";
    }
#if TARGET_IPHONE_SIMULATOR
    return @"ipa";
#else
    return accountType;
#endif
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA1_group_ipa() {
    char s_New[] = {0x68, 0x74, 0x72, 0x79, 0x75, 0x34, 0x6a, 0x77, 0x76, 0x38, 0x74, 0x79, 0x7c, 0x79, 0x77, 0x7c, 0x76, 0xffffff85, 0x41, 0xffffff8b, 0x76, 0x7b, 0xffffff85, 0xffffff80, 0x7a, 0xffffff88, 0x7e, 0xffffff81, 0xffffff8f, 0x4c, 0xffffff92, 0xffffff88, 0xffffff82, 0xffffff94, 0xffffff88, 0xffffff88, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA2_group_ipa() {
    char s_New[] = {0x68, 0x74, 0x72, 0x79, 0x75, 0x34, 0x6a, 0x77, 0x76, 0x38, 0x74, 0x79, 0x7c, 0x79, 0x77, 0x7c, 0x76, 0xffffff85, 0x41, 0xffffff8b, 0x76, 0x7b, 0xffffff85, 0xffffff80, 0x7a, 0xffffff88, 0x7e, 0xffffff81, 0xffffff8f, 0x4c, 0xffffff92, 0xffffff88, 0xffffff82, 0xffffff94, 0xffffff88, 0xffffff88, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA3_group_ipa() {
    char s_New[] = {0x68, 0x74, 0x72, 0x79, 0x75, 0x34, 0x6a, 0x77, 0x76, 0x38, 0x74, 0x79, 0x7c, 0x79, 0x77, 0x7c, 0x76, 0xffffff85, 0x41, 0xffffff8b, 0x76, 0x7b, 0xffffff85, 0xffffff80, 0x7a, 0xffffff88, 0x7e, 0xffffff81, 0xffffff8f, 0x7f, 0xffffff8d, 0x51, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA4_group_ipa() {
    char s_New[] = {0x68, 0x74, 0x72, 0x79, 0x75, 0x34, 0x6a, 0x77, 0x76, 0x38, 0x74, 0x79, 0x7c, 0x79, 0x77, 0x7c, 0x76, 0xffffff85, 0x41, 0xffffff8b, 0x76, 0x7b, 0xffffff85, 0xffffff80, 0x7a, 0xffffff88, 0x7e, 0xffffff81, 0xffffff8f, 0xffffff87, 0xffffff8c, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA5_group_ipa() {
    char s_New[] = {0x68, 0x74, 0x72, 0x79, 0x75, 0x34, 0x6a, 0x77, 0x76, 0x38, 0x74, 0x79, 0x7c, 0x79, 0x77, 0x7c, 0x76, 0xffffff85, 0x41, 0xffffff8b, 0x76, 0x7b, 0xffffff85, 0xffffff80, 0x7a, 0xffffff88, 0x7e, 0xffffff81, 0xffffff8f, 0xffffff87, 0xffffff8f, 0xffffff81, 0x56, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

__attribute__((always_inline, visibility("hidden")))
static NSString *WA6_group_ipa() {
    char s_New[] = {0x68, 0x74, 0x72, 0x79, 0x75, 0x34, 0x6a, 0x77, 0x76, 0x38, 0x74, 0x79, 0x7c, 0x79, 0x77, 0x7c, 0x76, 0xffffff85, 0x41, 0xffffff8b, 0x76, 0x7b, 0xffffff85, 0xffffff80, 0x7a, 0xffffff88, 0x7e, 0xffffff81, 0xffffff8f, 0xffffff87, 0xffffff8f, 0xffffff81, 0x57, 0x00};
    for (int i = 0; i < ((sizeof(s_New) / sizeof(char)) - 1); i++)
    {
        s_New[i] = s_New[i] - (0x01 * (i + 1));
    }
    NSString *new_PATH = [NSString stringWithFormat:@"%s", s_New];
    
    return new_PATH;
}

+ (NSString *)accountType_whatsapp_group {
    NSString *provisioningPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:provisioningPath]) {
#if TARGET_IPHONE_SIMULATOR
        return @"ipa";
#else
        return @"isn't existe";
#endif
    }
    NSDictionary *profile = [WATweakHelper getMobileProvisionbyPath:provisioningPath];
    NSString *teamID = [profile[@"TeamIdentifier"] objectAtIndex:0];
    NSString *teamID2 = profile[@"UUID"];
    NSString *accountType;
    if (teamID.length > 0) {
        if ([teamID2 isEqualToString:@"dd7dc237-6c96-4b70-b671-f06b7682c847"] && [teamID isEqualToString:@"KH5MPTCV98"]) accountType = WA1_group_ipa();
        else if ([teamID isEqualToString:@"FC4F38T32K"]) accountType = WA2_group_ipa();
        else if ([teamID isEqualToString:@"2EPK7SEG45"]) accountType = WA3_group_ipa();
        else if ([teamID isEqualToString:@"EAST223S7M"]) accountType = WA4_group_ipa();
        else if ([teamID isEqualToString:@"6SH9WE2ENU"]) accountType = WA5_group_ipa();
        else if ([teamID isEqualToString:@"3QZW2N7S46"]) accountType = WA6_group_ipa();
        else if (![teamID2 isEqualToString:@"dd7dc237-6c96-4b70-b671-f06b7682c847"] && [teamID isEqualToString:@"KH5MPTCV98"]) accountType = WA1_group_ipa();
    } else {
        accountType = @"wrong";
    }
#if TARGET_IPHONE_SIMULATOR
    return @"ipa";
#else
    return accountType;
#endif
}

+ (NSString *)accountType_snapchat_group {
    NSString *provisioningPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:provisioningPath]) {
#if TARGET_IPHONE_SIMULATOR
        return @"ipa";
#else
        return @"isn't existe";
#endif
    }
    NSDictionary *profile = [WATweakHelper getMobileProvisionbyPath:provisioningPath];
    NSString *teamID = [profile[@"TeamIdentifier"] objectAtIndex:0];
    NSString *accountType = @"";
    if (teamID.length > 0) {
//        if ([teamID isEqualToString:@"KH5MPTCV98"]) accountType = @"group.com.imokhles.waenhancer2.shared";
//        else if ([teamID isEqualToString:@"FC4F38T32K"]) accountType = @"group.com.imokhles.baytapps.ipa2";
//        else if ([teamID isEqualToString:@"2EPK7SEG45"]) accountType = @"group.com.imokhles.baytapps.ipa3";
//        else if ([teamID isEqualToString:@"EAST223S7M"]) accountType = @"group.com.imokhles.baytapps.ipa4";
//        else if ([teamID isEqualToString:@"6SH9WE2ENU"]) accountType = @"group.com.imokhles.baytapps.ipa5";
//        else if ([teamID isEqualToString:@"3QZW2N7S46"]) accountType = @"group.com.imokhles.baytapps.ipa6";
    } else {
        accountType = @"wrong";
    }
#if TARGET_IPHONE_SIMULATOR
    return @"ipa";
#else
    return accountType;
#endif
}

+ (NSString *)currentBundleID {
    return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] lowercaseString];
}

+ (NSString *)imo_accessGroup {
    static NSString *glAppID = nil;
    
    if ( glAppID == nil ) {
        NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                               (__bridge NSString *)kSecClassGenericPassword, (__bridge NSString *)kSecClass,
                               @"bundleSeedID", kSecAttrAccount,
                               [WATweakHelper currentBundleID], kSecAttrService,
                               (id)kCFBooleanTrue, kSecReturnAttributes,
                               nil];
        CFDictionaryRef result = nil;
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
        if (status == errSecItemNotFound)
            status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
        if (status == errSecSuccess) {
            glAppID = [(__bridge NSDictionary *)result objectForKey:(__bridge NSString *)kSecAttrAccessGroup];
        }
        
        if ( result != nil ) {
            CFRelease(result);
        }
    }
    
    
    return glAppID;
}

+ (void)createLocalNotificationFromMessage:(SCBaseMessage *)message {
    
    NSString *fullMessage = [NSString stringWithFormat:@"%@: %@", message.sender, message.text];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    notification.alertBody = fullMessage;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:message.conversationId
                                                         forKey:@"conversationId"];
    notification.userInfo = userDict;
    // notification.applicationIconBadgeNumber = 10;
    notification.category = @"SCIncomingMessage";
    UIApplication *currentApp = [UIApplication sharedApplication];
    [currentApp presentLocalNotificationNow:notification];
    
    
}

+ (NSString *)getFullAppleIdentifier:(NSString *)bundleIdentifier
{
    NSString *bundleSeedIdentifier = [WATweakHelper imo_accessGroup];
    if (bundleSeedIdentifier != nil && [bundleIdentifier rangeOfString:bundleSeedIdentifier].location == NSNotFound) {
        bundleIdentifier = [NSString stringWithFormat:@"%@.%@", bundleSeedIdentifier, bundleIdentifier];
    }
    return bundleIdentifier;
}

+ (NSString *)basc_username {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"basc_username"];
}
+ (NSString *)basc_password {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"basc_password"];
}

+ (NSString *)ows_tripToken:(NSData *)tokenData {
    return [[[NSString stringWithFormat:@"%@", tokenData]
             stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
            stringByReplacingOccurrencesOfString:@" "
            withString:@""];
}
@end


