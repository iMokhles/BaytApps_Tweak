//
//  WAEnhancer9.h
//  WAEnhancer9
//
//  Created by iMokhles on 11/05/16.
//
//

#ifndef WAEnhancer9_h
#define WAEnhancer9_h
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
#import <CoreData/CoreData.h>
#import <DropboxSDK/DropboxSDK.h>
#import "RMDateSelectionViewController.h"
#import "UIImage+Additions.h"

// private API
@interface UIWindow ()
+ (UIWindow *)keyWindow;
- (UIView *)contentView;
@end

@interface WAEnhancer : NSObject

@end

@interface WAViewController : UIViewController
- (_Bool)wa_is3DTouchAvailable;
- (_Bool)wa_isBeingPreviewed;
- (void)visibleConnectionStatusDidChange;
@end


@interface NSData (Additions)
+ (id)wa_randomDataOfLength:(unsigned long long)arg1;
- (id)wa_URLEncodedString;
- (id)wa_SHA256String;
- (id)wa_MD5String;
- (id)aesDecodeWithKey:(id)arg1;
- (id)aesEncodeWithKey:(id)arg1;
- (id)aesDecodeWithPassphrase:(id)arg1;
- (id)aesEncodeWithPassphrase:(id)arg1;
- (id)aesCryptoWithPassphrase:(id)arg1 encode:(_Bool)arg2;
- (id)aesCryptoWithKey:(id)arg1 encode:(_Bool)arg2 options:(unsigned int)arg3;
- (id)wa_stringValue;
- (id)wa_stringDump;
- (id)wa_base64DecodedData;
- (id)wa_URLSafeBase64DecodedData;
- (id)wa_base64EncodedString;
- (id)wa_URLSafeBase64EncodedString;
- (id)wa_UTF8StringValue;
- (id)wa_HEXStringValue;
- (id)wa_SHA256Digest;
- (id)wa_MD5Digest;
- (_Bool)wa_constantTimeIsEqualToData:(id)arg1;
@end


#pragma mark - WhatsApp headers

@class NSArray, PeopleMultiPickerNavigationController;

@protocol PeopleMultiPickerNavigationControllerDelegate
- (void)peopleMultiPickerNavigationControllerDidCancel:(PeopleMultiPickerNavigationController *)arg1;
- (void)peopleMultiPickerNavigationController:(PeopleMultiPickerNavigationController *)arg1 didSelectContacts:(NSArray *)arg2;
@end

@interface PeopleMultiPickerNavigationController : UINavigationController
@property(retain, nonatomic) NSArray *selectedContacts; // @synthesize selectedContacts=_selectedContacts;
@property(nonatomic) long long tag; // @synthesize tag=_tag;
@property(nonatomic) long long selectionLimit; // @synthesize selectionLimit=_selectionLimit;
@property(nonatomic) unsigned long long pickerMode; // @synthesize pickerMode=_pickerMode;
- (void)peopleViewControllerDidCancel:(id)arg1;
- (void)peopleViewController:(id)arg1 didSelectContacts:(id)arg2;
- (void)groupViewControllerDidCancel:(id)arg1;
- (void)groupViewController:(id)arg1 didSelectGroupWithID:(id)arg2;
- (void)viewDidLoad;
- (void)loadPeopleViewController:(int)arg1;
- (void)loadGroupViewController;
- (id)initWithDelegate:(id)arg1;

// Remaining properties
@property(nonatomic, strong) id <PeopleMultiPickerNavigationControllerDelegate> delegate; // @dynamic delegate;

@end

@interface WADataFormatters : NSObject
{
}

+ (id)backupSizeStringFromLongLong:(long long)arg1;
+ (id)sizeStringFromLongLong:(long long)arg1;
+ (id)localizedStringWithFormat:(id)arg1 number:(id)arg2;
+ (id)dayOfTheWeekFromDate:(id)arg1;
+ (id)messageTimestampStringFromDate:(id)arg1;
+ (id)messageDateStringFromDate:(id)arg1;
+ (id)dateTimeStringFromDate:(id)arg1;
+ (id)chatTimestampFromDate:(id)arg1;
+ (id)lastActiveStringFromDate:(id)arg1;
+ (id)lastSeenStringFromDate:(id)arg1;
+ (id)fullWeekdayFormatter;
+ (id)dateFormatterMediumStyleNoYear;
+ (id)sharedCalendar;
+ (id)shortWeekdayFormatter;
+ (id)messageTimestampFormatter;
+ (id)dateTimeFormatterLongStyleNoYear;
+ (id)dateTimeFormatterLongStyle;
+ (id)dateTimeFormatter;
+ (id)timeFormatter;
+ (id)dateFormatterMediumStyle;
+ (id)dateFormatterShortStyle;
+ (id)numberFormatter;
+ (void)currentLocaleDidChange:(id)arg1;
+ (void)initialize;

@end

@interface WATheme : NSObject
+ (id)colorPalette;
+ (id)defaultTheme;
- (void)reloadFonts;
- (UIFont *)bubbleMessageFont;
- (void)contentSizeCategoryDidChange:(id)arg1;
- (void)reloadDynamicTypeFontSize;
- (void)setFontSize:(double)arg1;
- (long long)fontIndexForSize:(long long)arg1;
- (long long)fontSizeForIndex:(long long)arg1;
- (id)fontNameForIndex:(long long)arg1;
- (long long)numberOfFonts;
- (long long)defaultFontSize;
- (long long)fontSize;
- (id)fontName;
@end

@interface NSDate (TimeShift)
+ (double)serverTimeShift;
+ (id)wa_serverDate;
@property(readonly, nonatomic) double wa_elapsedTimeInterval;
- (double)wa_timeIntervalSinceServerNow;
- (id)wa_dateByRemovingShiftCorrection;
- (id)wa_dateByIncludingShiftCorrection;
@end

@interface NSString (Additions)
+ (id)wa_stringWithData:(id)arg1 encodingHint:(unsigned long long)arg2 actualEncoding:(unsigned long long *)arg3;
+ (id)digraphs;
- (id)wa_componentsOfURLStringForIndexing;
- (id)wa_htmlUnescapedString;
- (_Bool)wa_isIPAddress;
- (id)wa_decodedStringFromBase64;
- (_Bool)wa_hasVideoFileExtension;
- (id)wa_whatsAppIDFromJID;
- (id)wa_jidFromIdOrJID;
- (id)wa_jidFromWhatsAppID;
- (id)localPhoneNumberFormattedUsingCountryCode:(id)arg1;
- (id)unformattedPhoneNumber;
- (id)unformattedPhoneNumberFromJID;
- (id)formattedPhoneNumberFromJID;
- (id)formattedPhoneNumber;
- (id)phoneNumberForVoiceOver;
- (id)wa_splitIntoPartsWithMaxParts:(unsigned long long)arg1 maxCharactersPerPart:(unsigned long long)arg2 overflowed:(_Bool *)arg3;
- (unsigned long long)wa_indexOfClosestWordBoundaryBeforeIndex:(unsigned long long)arg1;
- (unsigned long long)wa_indexOfComposedCharacterContainingIndex:(unsigned long long)arg1;
- (id)wa_redactedURLString;
- (id)wa_redactedString;
- (id)wa_stringByReplacingGreaterThanSignWithImageUsingColor:(id)arg1 andFont:(id)arg2;
- (id)wa_substringWithComposedCharacterSequenceLength:(unsigned long long)arg1;
- (unsigned long long)wa_lengthInCharacters;
- (id)wa_bestStringLanguage;
- (_Bool)isRTLText;
- (_Bool)isEmptyOrWhitespace;
- (id)wa_suffixWithMaximumLength:(unsigned long long)arg1;
- (id)wa_trimmedStringByNormalizingNewlines;
- (id)wa_trimmedString;
- (id)wa_stringByRemovingEmoji;
- (id)wa_stringByStandardizingEmoji;
- (id)mimeType;
- (id)tokens;
- (id)upperBoundSearchString;
- (id)normalizedString;
- (id)wa_URLEncodedString;
@end


@interface WABlockBasedAlertView : UIAlertView
{
    NSMutableDictionary *_actionMap;
    _Bool _shouldLog;
}

+ (void)showErrorMessage:(id)arg1;
+ (void)showErrorInAlertView:(id)arg1;
+ (id)alertViewWithTitle:(id)arg1 message:(id)arg2;
@property(readonly, nonatomic) _Bool shouldLog; // @synthesize shouldLog=_shouldLog;
- (void)show;
- (void)cancelAlertViewWithAnimation:(_Bool)arg1;
- (void)addCancelButtonWithTitle:(id)arg1 handler:(id)arg2;
- (void)addButtonWithTitle:(id)arg1 handler:(id)arg2;
- (void)alertView:(id)arg1 clickedButtonAtIndex:(long long)arg2;
- (void)didPresentAlertView:(id)arg1;
- (void)applicationDidEnterBackground:(id)arg1;
- (void)dealloc;
- (id)initWithTitle:(id)arg1 message:(id)arg2 shouldLogContent:(_Bool)arg3;
- (id)initWithTitle:(id)arg1 message:(id)arg2;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithCoder:(id)arg1;

@end

@interface WAServerProperties : NSObject
{
}


+ (id)tosValue;
+ (_Bool)isEndToEndIdentityVerificationEnabled;
+ (_Bool)isEndToEndUsesRegularPush;
+ (_Bool)isEndToEndEncAudioEnabled;
+ (_Bool)isEndToEndEncImagesEnabled;
+ (_Bool)isEndToEndEncBroadcastEnabled;
+ (_Bool)isEndToEndEncGroupsEnabled;
+ (int)encPlaintextReenableThreshold;
+ (_Bool)isEncMspesSet;
+ (long long)videoMaxEdge;
+ (struct CGSize)maxLandscapeVideoFrameSizeForInAppVideoRecording;
+ (_Bool)isWebClientEnabled;
+ (_Bool)isWhatsAppIDEnabledForVOIP:(id)arg1;
+ (_Bool)isPTTOpusRecordingEnabled;
+ (_Bool)isVOIPEnabled;
+ (long long)maxListSize;
+ (unsigned long long)placeSource;
+ (_Bool)isLocationSharingEnabled;
+ (_Bool)isReadReceiptsEnabledForDate:(id)arg1;
+ (_Bool)isAudioSharingEnabled;
+ (double)imageQuality;
+ (long long)imageMaxEdge;
+ (long long)imageMaxKBytes;
+ (_Bool)isDocumentSharingEnabled;
+ (id)supportedDocumentTypes;
+ (long long)maxDocumentSize;
+ (long long)maxGroupSubjectLength;
+ (long long)maxGroupParticipants;
+ (id)maxVideoDuration;
+ (unsigned long long)maxMediaSize;
+ (_Bool)shouldQueryVersion:(id)arg1;
+ (void)setProperties:(id)arg1 version:(id)arg2;
+ (void)resetToDefaults;
+ (void)reloadServerPropertiesFromPreferences;
+ (id)prefBundleKey;
+ (void)initialize;

@end

@interface WASharedAppData : NSObject
{
}

+ (void)sendDataToServer:(id)arg1;
+ (void)handleClientConnection:(int)arg1;
+ (_Bool)startIPCServer;
+ (id)IPCSocketPath;
+ (void)unlockConnection;
+ (void)lockConnection;
+ (_Bool)tryConnectionLock;
+ (void)unmigrateData;
+ (void)migrateUserPreferences;
+ (void)migrateData;
+ (_Bool)isDataInAppGroup;
+ (void)showAlertText:(id)arg1 fromViewController:(id)arg2;
+ (void)setPhoneNumber:(id)arg1;
+ (id)phoneNumber;
+ (void)setCountryCode:(id)arg1;
+ (id)countryCode;
+ (void)removePasswordFile;
+ (_Bool)setPassword:(id)arg1;
+ (id)password;
+ (id)passwordFilePathInMainContainer;
+ (id)passwordFilePathInAppGroup;
+ (id)passwordFilePath;
+ (id)normalizedNumberFromJID:(id)arg1;
+ (id)normalizedNumber;
+ (void)setUserJID:(id)arg1;
+ (id)userJID;
+ (void)showCriticallyLowStorageAlert;
+ (void)showLocalNotificationForJailbrokenPhoneAndTerminate;
+ (void)setStatusBarStyle:(long long)arg1 animated:(_Bool)arg2;
+ (void)setStatusBarHidden:(_Bool)arg1 withAnimation:(long long)arg2;
+ (void)endIgnoringInteractionEventsInExtension;
+ (void)beginIgnoringInteractionEventsInExtension;
+ (void)endIgnoringInteractionEvents;
+ (void)beginIgnoringInteractionEvents;
+ (void)endBackgroundTask:(unsigned long long)arg1;
+ (unsigned long long)beginBackgroundTaskWithName:(id)arg1 expirationHandler:(id)arg2;
+ (void)internalEndBackgroundTask:(unsigned long long)arg1;
+ (unsigned long long)internalBeginBackgroundTaskWithExpirationHandler:(id)arg1;
+ (void)prepareToSuspend;
+ (void)setDidResumeHandler:(id)arg1;
+ (void)setWillSuspendHandler:(id)arg1;
+ (void)resetSuspendingIfNeeded;
+ (void)checkApplicationBackgroundState;
+ (void)setUpMainBackgroundTaskIfNeeded;
+ (void)applicationWillEnterForeground:(id)arg1;
+ (void)applicationDidEnterBackground:(id)arg1;
+ (id)sharedApplication;
+ (_Bool)isRestoreInProgress;
+ (_Bool)isBackupInProgress;
+ (id)launchTime;
+ (double)backgroundTimeRemaining;
+ (long long)applicationState;
+ (_Bool)isVOIPCallActive;
+ (_Bool)hasVOIPCallStarted;
+ (_Bool)isWebClientAvailable;
+ (_Bool)isUserAvailable;
+ (id)URLSessionManager;
+ (void *)sharedAddressBook;
+ (id)profilePictureManager;
+ (id)xmppConnection;
+ (id)notificationsConfig;
+ (id)contactsStorage;
+ (id)chatStorage;
+ (id)axolotlDatabaseURLInMainContainer;
+ (id)axolotlDatabaseURLInAppGroup;
+ (id)axolotlDatabaseURL;
+ (id)sharedLogsDirectoryURL;
+ (id)profilePicturesStorageDirectoryInMainContainer;
+ (id)profilePicturesStorageDirectoryInAppGroup;
+ (id)contactsDatabaseURLInMainContainer;
+ (id)contactsDatabaseURLInAppGroup;
+ (id)contactsDatabaseURL;
+ (id)chatSearchDatabaseURLInMainContainer;
+ (id)chatSearchDatabaseURLInAppGroup;
+ (id)chatSearchDatabaseURL;
+ (id)chatDatabaseURLInMainContainer;
+ (id)chatDatabaseURLInAppGroup;
+ (id)chatDatabaseURL;
+ (id)sharedItemOutboxesURL;
+ (id)userDefaults;
+ (id)appGroupURL;
+ (void)registerExtensionContainerView:(id)arg1;
+ (_Bool)isRunningAsExtension;
+ (_Bool)isChatDatabaseAccessible;
+ (void)prepareConnectionLock;
+ (void)registerConnectionConditionals;
+ (void)prepareBackgroundTaskManagement;
+ (_Bool)prepareAppContainer;
+ (_Bool)internalPrepare;
+ (_Bool)prepare;

@end

@interface UITabBarButtonLabel : UILabel
@end

@interface UITabBarButton : UIControl {
    UIView *_info;
}
@property(getter=_isSelected,setter=_setSelected:) bool _selected;
@property(getter=_unselectedTintColor,setter=_setUnselectedTintColor:,retain) UIColor * unselectedTintColor;
@end

@interface WATabBarController : UITabBarController
@end

@interface WAChatCellData : NSObject
- (id)message;
-(NSArray *)messages;
-(BOOL)isFromMe;
-(NSArray *)textMessages;
@end

@interface WAMessageCell : UITableViewCell {
    UIImageView *_imageViewBubble;
    UIImageView *_imageViewCheckmark;
}
@property(readonly, nonatomic) UIView *bubbleView; // @synthesize bubbleView=_bubbleView;
@property(readonly, nonatomic) WAChatCellData *cellData; // @synthesize cellData=_cellData;
@property(retain, nonatomic) UIImageView *bubbleImageView; // @synthesize bubbleImageView=_bubbleImageView;
@end

@interface WAMessageTextView : UIView {
    NSArray *_textMessages;
}
- (void)handleLongPress;
- (void)handleSingleTap;
- (void)unhighlightAllTextBlocks;
- (void)highlightTextBlock:(id)arg1;
@end

@interface WATextMessageCell : WAMessageCell {
    WAMessageTextView *_messageTextView;
}
@end

@interface TextMessage : NSObject
@property(nonatomic) BOOL textStoragePrepared; // @synthesize textStoragePrepared=_textStoragePrepared;
@property(retain, nonatomic) UIColor *highlightBoxColor; // @synthesize highlightBoxColor=_highlightBoxColor;
@property(nonatomic) BOOL underlineLinks; // @synthesize underlineLinks=_underlineLinks;
@property(copy, nonatomic) NSArray *highlightedTerms; // @synthesize highlightedTerms=_highlightedTerms;
@property(retain, nonatomic) NSArray *textBlocks; // @synthesize textBlocks=_textBlocks;
@property(retain, nonatomic) UIColor *shadowColor; // @synthesize shadowColor=_shadowColor;
@property(retain, nonatomic) UIColor *urlBackgroundColor; // @synthesize urlBackgroundColor=_urlBackgroundColor;
@property(retain, nonatomic) UIColor *highlightedUrlColor; // @synthesize highlightedUrlColor=_highlightedUrlColor;
@property(retain, nonatomic) UIColor *urlColor; // @synthesize urlColor=_urlColor;
@property(retain, nonatomic) UIColor *textColor; // @synthesize textColor=_textColor;
@property(retain, nonatomic) UIFont *font; // @synthesize font=_font;
@property(retain, nonatomic) NSString *originalText; // @synthesize originalText=_originalText;
@property(retain, nonatomic) NSString *text; // @synthesize text=_text;
@property(nonatomic) BOOL dataDetectionEnabled; // @synthesize dataDetectionEnabled=_dataDetectionEnabled;
@end

@interface _TextMessage_TextKit : TextMessage
- (void)setFont:(id)arg1;
@end

@class WAChatSession;

@interface WAMessage : NSObject
@property (nonatomic,copy,readonly) NSString * xmppThumbnailPath; 
@property (nonatomic,copy,readonly) NSString * mediaPath;
@property(retain, nonatomic) WAChatSession *chatSession; // @dynamic chatSession;
@property(retain, nonatomic) NSSet *childMessages; // @dynamic childMessages;
@property(retain, nonatomic) NSNumber *childMessagesDeliveredCount; // @dynamic childMessagesDeliveredCount;
@property(retain, nonatomic) NSNumber *childMessagesPlayedCount; // @dynamic childMessagesPlayedCount;
@property(retain, nonatomic) NSNumber *childMessagesReadCount; // @dynamic childMessagesReadCount;
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(retain, nonatomic) NSNumber *docID; // @dynamic docID;
@property(retain, nonatomic) NSNumber *encRetryCount; // @dynamic encRetryCount;
@property(retain, nonatomic) NSNumber *filteredRecipientCount; // @dynamic filteredRecipientCount;
@property(retain, nonatomic) NSNumber *flags; // @dynamic flags;
@property(retain, nonatomic) NSString *fromJID; // @dynamic fromJID;
@property(retain, nonatomic) NSNumber *groupEventType; // @dynamic groupEventType;
// @property(retain, nonatomic) WAGroupMember *groupMember; // @dynamic groupMember;
@property(readonly) unsigned long long hash;
@property(retain, nonatomic) NSNumber *isFromMe; // @dynamic isFromMe;
// @property(retain, nonatomic) WAMediaItem *mediaItem; // @dynamic mediaItem;
@property(retain, nonatomic) NSString *mediaSectionID; // @dynamic mediaSectionID;
@property(retain, nonatomic) NSDate *messageDate; // @dynamic messageDate;
@property(retain, nonatomic) NSNumber *messageErrorStatus; // @dynamic messageErrorStatus;
// @property(retain, nonatomic) WAMessageInfo *messageInfo; // @dynamic messageInfo;
@property(retain, nonatomic) NSNumber *messageType; // @dynamic messageType;
@property(retain, nonatomic) WAMessage *parentMessage; // @dynamic parentMessage;
@property(retain, nonatomic) NSString *pushName; // @dynamic pushName;
@property(retain, nonatomic) NSDate *sentDate; // @dynamic sentDate;
@property(retain, nonatomic) NSNumber *sort; // @dynamic sort;
@property(retain, nonatomic) NSString *stanzaID; // @dynamic stanzaID;
@property(retain, nonatomic) NSString *text; // @dynamic text;
@property(retain, nonatomic) NSString *toJID; // @dynamic toJID;
@end

@interface WAStatus : NSObject
@property(retain, nonatomic) NSString *text; // @dynamic text;
// Remaining properties
@property(retain, nonatomic) NSNumber *callability; // @dynamic callability;
@property(retain, nonatomic) NSDate *date; // @dynamic date;
@property(retain, nonatomic) NSNumber *encryptionCapable; // @dynamic encryptionCapable;
@property(retain, nonatomic) NSNumber *encryptionV2Capable; // @dynamic encryptionV2Capable;
// @property(retain, nonatomic) WAPhone *phone; // @dynamic phone;
@property(retain, nonatomic) NSDate *pictureDate; // @dynamic pictureDate;
@property(retain, nonatomic) NSString *pictureID; // @dynamic pictureID;
@property(retain, nonatomic) NSString *picturePath; // @dynamic picturePath;
@property(retain, nonatomic) NSString *whatsAppID; // @dynamic whatsAppID;
@end

@class WAGroupInfo;

@interface WAChatSession : NSObject
@property (getter=isContactBlocked,nonatomic,readonly) BOOL contactBlocked;
// Remaining properties
@property(readonly, nonatomic, getter=isGroupChat) _Bool groupChat;
@property(readonly, nonatomic, getter=isIndividualChat) _Bool individualChat;
@property(retain, nonatomic) WAGroupInfo *groupInfo; // @dynamic groupInfo;
@property(readonly, nonatomic, getter=isBroadcastListJIDValid) _Bool broadcastListJIDValid;
@property(retain, nonatomic) NSNumber *archived; // @dynamic archived;
@property(retain, nonatomic) NSNumber *contactABID; // @dynamic contactABID;
@property(retain, nonatomic) NSString *eTag; // @dynamic eTag;
@property(retain, nonatomic) NSNumber *flags; // @dynamic flags;
// @property(retain, nonatomic) WAGroupInfo *groupInfo; // @dynamic groupInfo;
@property(retain, nonatomic) NSSet *groupMembers; // @dynamic groupMembers;
@property(retain, nonatomic) NSNumber *hidden; // @dynamic hidden;
@property(retain, nonatomic) WAMessage *lastMessage; // @dynamic lastMessage;
@property(retain, nonatomic) NSDate *lastMessageDate; // @dynamic lastMessageDate;
@property(retain, nonatomic) NSString *lastMessageText; // @dynamic lastMessageText;
@property(retain, nonatomic) NSDate *locationSharingEndDate; // @dynamic locationSharingEndDate;
@property(retain, nonatomic) NSNumber *messageCounter; // @dynamic messageCounter;
@property(retain, nonatomic) NSString *partnerName; // @dynamic partnerName;
@property(retain, nonatomic) NSNumber *removed; // @dynamic removed;
@property(retain, nonatomic) NSString *savedInput; // @dynamic savedInput;
@property(retain, nonatomic) NSNumber *sessionType; // @dynamic sessionType;
@property(retain, nonatomic) NSNumber *unreadCount; // @dynamic unreadCount;
@property(retain, nonatomic) NSString *contactJID; // @dynamic contactJID;
@end

@interface WAGroupInfo : NSObject

@property(retain, nonatomic) WAChatSession *chatSession; // @dynamic chatSession;
@property(retain, nonatomic) NSDate *creationDate; // @dynamic creationDate;
@property(copy, nonatomic) NSString *creatorJID; // @dynamic creatorJID;
@property(copy, nonatomic) NSString *pictureID; // @dynamic pictureID;
@property(copy, nonatomic) NSString *picturePath; // @dynamic picturePath;
@property(copy, nonatomic) NSString *sourceJID; // @dynamic sourceJID;
@property(copy, nonatomic) NSString *subjectOwnerJID; // @dynamic subjectOwnerJID;
@property(retain, nonatomic) NSDate *subjectTimestamp; // @dynamic subjectTimestamp;

@end

@interface WALabel : UILabel
- (id)originalAttributedText;
- (id)originalText;
- (void)setFont:(id)arg1;
- (void)setAttributedText:(id)arg1;
- (void)setText:(id)arg1;
@end

@interface WAAutoscrollingLabel : UILabel
@end

@interface WAConversationHeaderView : UIView {
    WALabel *_titleLabel;
    WAAutoscrollingLabel *_captionLabel;
    UILabel *_activityLabel;
}
@property(retain, nonatomic) UIImage *profilePicture;
@property (nonatomic,retain) WALabel * titleLabel;
@property (nonatomic,retain) UILabel * activityLabel;
@property (nonatomic,retain) WAAutoscrollingLabel * captionLabel;
@property(copy, nonatomic) NSString *activityText; // @synthesize activityText=_activityText;
@property(copy, nonatomic) NSString *captionTextForVoiceOver; // @synthesize captionTextForVoiceOver=_captionTextForVoiceOver;
@property(copy, nonatomic) NSString *caption; // @synthesize caption=_caption;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
- (void)setCaption:(id)arg1 animated:(_Bool)arg2 autoscroll:(_Bool)arg3 scrollCompletion:(id)arg4;
- (void)setProfilePicture:(UIImage *)arg1 animated:(_Bool)arg2;
@end

@interface KeychainWrapper : NSObject
+(id)keychainValueWithIdentifier:(id)arg1 ;
+(void)setKeychainValue:(id)arg1 forIdentifier:(id)arg2 ;
+(void)deleteKeychainValueWithIdentifier:(id)arg1 ;
+(id)keychainItemMatching:(id)arg1 withAccessibilityControl:(BOOL)arg2 ;
+(BOOL)updateKeychainValue:(id)arg1 forIdentifier:(id)arg2 ;
+(BOOL)createKeychainValue:(id)arg1 forIdentifier:(id)arg2 ;
+(id)searchDictionary:(id)arg1 withAccessibilityControl:(BOOL)arg2 ;
@end

@interface _WAConversationHeaderViewModern : WAConversationHeaderView
@property(retain, nonatomic) UIButton *callButton; // @synthesize callButton=_callButton;
@end

@interface WAChatMessagesController : NSObject
- (id)allSelectedMessages;
- (id)allSelectedCellDataObjects;
@end

@interface WADocumentAttachment : NSObject
- (id)initWithFileURL:(id)arg1 transferFileOwnership:(_Bool)arg2;
- (id)init;
@end

@interface WAActionSheetPresenter : NSObject
{
    _Bool _presentsInWindow;
    _Bool _showsCancelButton;
    id _completionHandler;
}

@property(nonatomic) _Bool showsCancelButton; // @synthesize showsCancelButton=_showsCancelButton;
@property(nonatomic) _Bool presentsInWindow; // @synthesize presentsInWindow=_presentsInWindow;
@property(copy, nonatomic) id completionHandler; // @synthesize completionHandler=_completionHandler;
- (void)addCancelButton;
- (void)addButtonWithTitle:(id)arg1 handler:(id)arg2;
- (void)addDestructiveButtonWithTitle:(id)arg1 handler:(id)arg2;
- (void)didDismissByCancelling:(_Bool)arg1;
- (void)dismissByCancellingWithAnimation:(_Bool)arg1;
- (void)presentFromViewController:(id)arg1;
- (id)initWithTitle:(id)arg1;
- (void)applicationWillResetUserInterface:(id)arg1;
- (void)applicationDidEnterBackground:(id)arg1;
- (id)init;

@end

@class WAGimmick, WAGimmickPickerView;

@protocol WAGMEnViewControllerDelegate;

@protocol WAGimmickPickerViewDelegate <NSObject>
- (void)gimmickPickerView:(WAGimmickPickerView *)arg1 didSelectGimmick:(WAGimmick *)arg2;
@end

@protocol WAGimmickDelegate <NSObject>
- (NSURL *)remoteContentURLForGimmick:(WAGimmick *)arg1;
- (void)gimmickDidRequestSave:(WAGimmick *)arg1;
- (void)downloadContentForGimmick:(WAGimmick *)arg1;
@end

@class WASinglePhotoPickerController;
@protocol WASinglePhotoPickerControllerDelegate <NSObject>
- (void)singlePhotoPickerController:(WASinglePhotoPickerController *)arg1 didFinishWithImage:(UIImage *)arg2;
- (void)singlePhotoPickerControllerDidCancel:(WASinglePhotoPickerController *)arg1;
@end

@interface WASinglePhotoPickerController : NSObject {
    id <WASinglePhotoPickerControllerDelegate> _delegate;
}
@property(nonatomic) __weak id <WASinglePhotoPickerControllerDelegate> delegate;
- (id)initWithDelegate:(id<WASinglePhotoPickerControllerDelegate>) delegate;
- (void)presentFromViewController:(id)arg1;
@end

@interface WAGimmick : NSObject
{
    unsigned long long _contentDownloadStatus;
    id <WAGimmickDelegate> _delegate;
}

+ (id)preferredFormat;
@property(nonatomic) __weak id <WAGimmickDelegate> delegate; // @synthesize delegate=_delegate;
@property(readonly, nonatomic) unsigned long long contentDownloadStatus; // @synthesize contentDownloadStatus=_contentDownloadStatus;
- (void)downloadContentWithVersionDidFail:(short)arg1;
- (void)downloadContentWithVersionDidFinish:(short)arg1;
- (void)downloadContentIfNeeded;
- (void)updateLastUsedDate;
@property(nonatomic) _Bool collected; // @dynamic collected;
- (void)save;
- (void)setContentDownloadStatus:(unsigned long long)arg1;
@property(readonly, nonatomic) _Bool needsRedownloadContent;
@property(readonly, copy, nonatomic) NSString *externalID;
@property(readonly, nonatomic) NSURL *remoteContentURL;
@property(readonly, nonatomic) NSURL *localContentURL;
@property(readonly, nonatomic, getter=isContentAvailableLocally) _Bool contentAvailableLocally;
- (void)awakeFromFetch;
- (void)awakeFromInsert;

// Remaining properties
@property(retain, nonatomic) NSString *assetID; // @dynamic assetID;
@property(nonatomic) short bottomInset; // @dynamic bottomInset;
@property(retain, nonatomic) NSString *collectionID; // @dynamic collectionID;
@property(nonatomic) short currentVersion; // @dynamic currentVersion;
@property(nonatomic) short displayHeight; // @dynamic displayHeight;
@property(nonatomic) short displayWidth; // @dynamic displayWidth;
@property(retain, nonatomic) NSString *format; // @dynamic format;
@property(nonatomic) short frameCount; // @dynamic frameCount;
@property(nonatomic) short frameRate; // @dynamic frameRate;
@property(retain, nonatomic) NSDate *lastUsedDate; // @dynamic lastUsedDate;
@property(nonatomic) short leftInset; // @dynamic leftInset;
@property(nonatomic) short permission; // @dynamic permission;
@property(nonatomic) short rightInset; // @dynamic rightInset;
@property(nonatomic) short targetVersion; // @dynamic targetVersion;
@property(nonatomic) short topInset; // @dynamic topInset;
@property(nonatomic) short type; // @dynamic type;

@end

@interface WAGimmickPickerView : UIView
@property(nonatomic) unsigned long long mode; // @synthesize mode=_mode;
@property(nonatomic) __weak id <WAGimmickPickerViewDelegate> delegate; // @synthesize delegate=_delegate;
- (void)showCollectedItems:(id)arg1;
- (void)showFeaturedItems:(id)arg1;
- (void)layoutSubviews;
- (void)didMoveToWindow;
- (id)newModeButtonWithTitle:(id)arg1;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)init;
@end



@class WAGMEnViewController;

@class WAForwardPickerViewController, WAContactInfo;
@protocol WAForwardPickerViewControllerDelegate <NSObject>
- (NSString *)confirmationButtonTitleForForwardPicker:(WAForwardPickerViewController *)arg1;
- (NSString *)forwardPicker:(WAForwardPickerViewController *)arg1 confirmationTextForContactInfo:(WAContactInfo *)arg2;
- (_Bool)forwardPicker:(WAForwardPickerViewController *)arg1 shouldProceedWithContactInfo:(WAContactInfo *)arg2;
- (void)forwardPickerDidCancel:(WAForwardPickerViewController *)arg1;
- (void)forwardPicker:(WAForwardPickerViewController *)arg1 didSelectContacts:(NSArray *)arg2;
@end


@interface WAForwardPickerViewController : WAViewController
+ (id)controller;
@property(nonatomic) __weak id <WAForwardPickerViewControllerDelegate> delegate; // @synthesize delegate=_delegate;
@property(nonatomic) _Bool requiresConfirmation;
@property(nonatomic) _Bool allowsMultipleSelection;
@property(nonatomic) long long contentType;
@property(nonatomic) _Bool useSearchController;
@property(retain, nonatomic) UITableView *tableView;
@end

@protocol WAGMEnViewControllerDelegate <NSObject>
- (void)gimmickPickerViewController:(WAGMEnViewController *)pickerVC didSelectGimmick:(WAGimmick *)gimmick;
@end

@interface WAGMEnViewController : UIViewController <WAGimmickPickerViewDelegate>
@property (nonatomic, assign) id <WAGMEnViewControllerDelegate> delegate;
@end

@interface WAChatSessionViewController : WAViewController <PeopleMultiPickerNavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, UIPopoverControllerDelegate, WAGMEnViewControllerDelegate, WAForwardPickerViewControllerDelegate>

- (void)chatBarManager:(id)arg1 didSelectGimmick:(id)arg2;
@property(retain, nonatomic) WAChatMessagesController *messagesController; // @synthesize
@property(retain, nonatomic) WAConversationHeaderView *headerView; // @synthesize headerView=_headerView;
@property(readonly, nonatomic) WAChatSession *chatSession;
@property(retain, nonatomic) UIBarButtonItem *barButtonDeleteAll; // @synthesize barButtonDeleteAll=_barButtonDeleteAll;
@property(retain, nonatomic) UIBarButtonItem *barButtonDoneEditing; // @synthesize barButtonDoneEditing=_barButtonDoneEditing;
@property(retain, nonatomic) UIBarButtonItem *barButtonEditModeTitle; // @synthesize barButtonEditModeTitle=_barButtonEditModeTitle;
@property(retain, nonatomic) UIBarButtonItem *barButtonDelete; // @synthesize barButtonDelete=_barButtonDelete;
@property(retain, nonatomic) UIBarButtonItem *barButtonShare; // @synthesize barButtonShare=_barButtonShare;
@property(retain, nonatomic) UIBarButtonItem *barButtonForward; // @synthesize barButtonForward=_barButtonForward;
@property(retain, nonatomic) NSString *jid; // @synthesize jid=_jid;
- (void)sendAudioTrack:(id)arg1;
- (void)sendImage:(id)arg1 caption:(id)arg2;
- (void)messageCell:(id)arg1 didSelectTextBlock:(id)arg2;
- (void)sendAudioAtURL:(id)arg1 durationSeconds:(int)arg2 streamingHash:(id)arg3;
- (void)unblockContact;
- (void)blockContact;
- (void)sendDocumentAttachment:(id)arg1;
-(void)reloadMessageController;
-(void)scrollToBottom;

- (void)forwardMessages:(id)arg1 toContacts:(id)arg2; // new
//- (void)forwardMessages:(id)arg1 toContactInfo:(id)arg2;
- (id)allSelectedMessages;
- (void)reloadAfterFontSizeDidChange;

- (void)presentShareLocationController;
- (void)presentShareDocumentController;
- (void)showVideoOnlyLibrary;
- (void)showPhotoOnlyLibrary;
- (void)showPhotoLibrary;
- (void)showCameraFromActionSheet;
- (void)showVCardPersonPicker;

// new
- (void)_presentForCurrentInterface:(UIViewController *)viewController;
@end

@interface CallManager : NSObject
+ (id)sharedManager;
- (void)attemptOutgoingCellularVoiceCallWithPhoneURL:(id)arg1;
- (void)attemptOutgoingVoiceCallWithJID:(id)arg1 bypassEligibilityCheck:(_Bool)arg2 callUISource:(int)arg3;
- (void)attemptOutgoingVoiceCallWithJID:(id)arg1 bypassEligibilityCheck:(BOOL)arg2 callUISource:(int)arg3 withVideo:(BOOL)arg4 ;// new beta
@end

@interface WAListsViewController : UIViewController {
    NSFetchedResultsController *_fetchedResultsController;
    UIView *_emptyListView;
    UITableView *_tableView;
    BOOL _chatStorageAvailable;
    WAChatSession *_activeList;
}
- (void)createNewList:(id)arg1;
- (void)deleteExistingList:(id)arg1;
@end

@interface XMPPIQStanza : NSObject
{
}

+ (unsigned long long)typeForString:(id)arg1;
+ (id)stringForType:(unsigned long long)arg1;
+ (id)stringsForTypes;
- (id)log;
@property(retain, nonatomic) NSString *xmlns;
- (_Bool)matchXMLNS:(id)arg1;
@property(nonatomic) unsigned long long type;
@property(readonly, nonatomic) NSData *password;
@property(readonly, nonatomic) NSDate *lastActivity;
- (_Bool)isLocation;
- (_Bool)hasPassword;
- (_Bool)hasPing;
- (id)initWithFromJID:(id)arg1 toJID:(id)arg2 type:(unsigned long long)arg3;

@end

@interface XMPPClient : NSObject
@property(retain) NSString *jid; // @synthesize jid=_jid;
@property(retain) NSDate *lastSeenTimestamp; // @synthesize lastSeenTimestamp=_lastSeenTimestamp;
@property(retain) NSString *groupJIDForChatState; // @synthesize groupJIDForChatState=_groupJIDForChatState;
@property(retain) NSDate *incomingChatStateTimestamp; // @synthesize incomingChatStateTimestamp=_incomingChatStateTimestamp;
@property(retain) NSDate *outgoingChatStateTimestamp; // @synthesize outgoingChatStateTimestamp=_outgoingChatStateTimestamp;
@property unsigned long long presence; // @synthesize presence=_presence;
@property unsigned long long lastReceivedChatState;
@property unsigned long long lastSentChatState;
- (void)reset;
- (id)initWithJID:(id)arg1;
@end

@interface XMPPConnection : NSObject
@property(getter=isConnected) BOOL connected; // @synthesize connected=_connected;
- (void)close;
- (id)lastSeenTimestampForJID:(id)arg1;
- (void)removeClientDataForJID:(id)arg1;
- (_Bool)isOnline:(id)arg1;
- (id)addClientDataForJID:(id)arg1;
- (XMPPClient *)clientDataForJID:(id)arg1;
- (unsigned long long)chatStateForContactWithJID:(id)arg1;
- (void)test;
- (void)runWhenConnected:(BOOL)arg1;
@end

@interface WATableRow : NSObject
{
    _Bool _editable;
    _Bool _disabled;
    id _editHandler;
    id _handler;
    UITableViewCell *_cell;
}

@property(nonatomic) _Bool disabled; // @synthesize disabled=_disabled;
@property(nonatomic, getter=isEditable) _Bool editable; // @synthesize editable=_editable;
@property(retain, nonatomic) UITableViewCell *cell; // @synthesize cell=_cell;
@property(copy, nonatomic) id handler; // @synthesize handler=_handler;

@end

@interface WATableSection : NSObject
{
    NSMutableArray *_rows;
    NSString *_headerText;
    NSString *_footerText;
}

@property(retain, nonatomic) NSString *footerText; // @synthesize footerText=_footerText;
@property(retain, nonatomic) NSString *headerText; // @synthesize headerText=_headerText;
@property(retain, nonatomic) NSArray *rows; // @synthesize rows=_rows;
- (void)deleteRow:(id)arg1;
- (id)addTableRowWithCellStyle:(long long)arg1;
- (id)addDefaultTableRow;
- (void)addRow:(id)arg1;
- (id)init;

@end

@interface WAStaticTableViewController : UITableViewController
{
    NSMutableArray *_sections;
}

@property(retain, nonatomic) NSArray *sections; // @synthesize sections=_sections;
- (void)deselectActiveCell;
- (void)wa_fontSizeDidChange;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 willSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 titleForFooterInSection:(int)arg2;
- (id)tableView:(id)arg1 titleForHeaderInSection:(int)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (int)tableView:(id)arg1 numberOfRowsInSection:(int)arg2;
- (int)numberOfSectionsInTableView:(id)arg1;
- (id)rowAtIndexPath:(id)arg1;
- (id)addSection;
- (void)setupTableView;
- (void)viewDidLoad;
- (id)initWithStyle:(int)arg1;

@end

@interface WAStaticTableViewController (WAEnhancer9)
- (WATableSection *)addSectionAtTop;
@end

@interface WASettingsViewController : WAStaticTableViewController
@end


@interface WAContactInfo : NSObject
- (id)initWithChatSession:(id)arg1;
- (id)initWithContact:(id)arg1;
- (id)initWithWAContactObjectID:(id)arg1;
@property(copy, nonatomic) NSString *highlightedName; // @synthesize highlightedName=_highlightedName;
@property(copy, nonatomic) NSString *jid; // @synthesize jid=_jid;
@property(copy, nonatomic) NSString *firstName; // @synthesize firstName=_firstName;
@property(copy, nonatomic) NSString *fullName; // @synthesize fullName=_fullName;
@property(copy, nonatomic) NSString *detailText;
@property(copy, nonatomic) NSString *statusText;
@property(copy, nonatomic) NSString *displayNameShort;
@property(copy, nonatomic) NSString *displayNameMedium;
@property(copy, nonatomic) NSString *displayNameLong;
@end


@interface ChatManager : NSObject
+ (id)sharedManager;
- (void)reloadFavorites;
- (id)localizedChatActivityStringForJID:(id)arg1;
- (id)localizedChatActivityStringForContactWithJID:(id)arg1;
- (id)localizedChatActivityStringForGroupWithJID:(id)arg1;
@end

@interface WATableViewController : UITableViewController
@end

//@interface WADocumentAttachment : NSObject
//- (id)initWithFileURL:(id)arg1 transferFileOwnership:(_Bool)arg2;
//- (id)init;
//@end

@class WAPhotoMoveAndScaleViewController;

@protocol WAPhotoMoveAndScaleViewControllerDelegate <NSObject>
- (void)photoMoveAndScaleViewController:(WAPhotoMoveAndScaleViewController *)arg1 didFinishWithImage:(UIImage *)arg2;
@end

@interface WAPhotoMoveAndScaleViewController : UIViewController {
    id <WAPhotoMoveAndScaleViewControllerDelegate> _delegate;
}
@property(nonatomic) double maximumWidth; // @synthesize maximumWidth=_maximumWidth;
@property(nonatomic) double minimumWidth; // @synthesize minimumWidth=_minimumWidth;
@property(nonatomic) unsigned long long mode; // @synthesize mode=_mode;
@property(retain, nonatomic) UIImage *originalImage; // @synthesize originalImage=_originalImage;
@property(nonatomic) __weak id <WAPhotoMoveAndScaleViewControllerDelegate> delegate;
- (id)initWithDelegate:(id<WAPhotoMoveAndScaleViewControllerDelegate>) delegate;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;
@end

@interface WAChatStorage : NSObject
- (id)allChatSessions;
- (void)sendDocumentAttachment:(id)arg1 inChatSession:(id)arg2 completion:(id)arg3;
- (id)existingChatSessionsForJIDs:(id)arg1 prefetchingLastMessage:(_Bool)arg2;
- (id)newOrExistingChatSessionForJID:(id)arg1; // new beta
-(id)existingChatSessionForJID:(id)jid; // old
-(id)chatSessionForJID:(id)jid;
- (void)sendMessageWithText:(id)arg1 metadata:(id)arg2 inChatSession:(id)arg3; // new beta
-(id)sendMessageWithText:(id)arg1 metadata:(id)arg2 replyingToMessage:(id)arg3 inChatSession:(id)arg4; // new
- (void)sendMessageWithText:(id)arg1 inChatSession:(id)arg2;
- (void)sendMessageWithImage:(id)arg1 caption:(id)arg2 inChatSession:(id)arg3 completion:(id)arg4;
-(void)sendMessage:(id)message notify:(BOOL)notify;
- (void)retrySendingMessage:(id)arg1;
- (void)forwardMessages:(id)arg1 toChatSession:(id)arg2;
@end

//@class WAMessage;
//@interface WAChatSession : NSObject
//@property(retain, nonatomic) NSSet *messages; // @dynamic messages;
//@property(retain, nonatomic) NSNumber *unreadCount; // @dynamic unreadCount;
//@property(retain, nonatomic) NSString *partnerName; // @dynamic partnerName;
//@property(retain, nonatomic) NSString *lastMessageText; // @dynamic lastMessageText;
//@property(retain, nonatomic) WAMessage *lastMessage; // @dynamic lastMessage;
//@end

//@interface WAMessage : NSObject
//@property(retain, nonatomic) NSString *text; // @dynamic text;
//@property(retain, nonatomic) NSString *toJID; // @dynamic toJID;
//@property(retain, nonatomic) NSString *fromJID; // @dynamic fromJID;
//@property(retain, nonatomic) NSString *pushName; // @dynamic pushName;
//@property(retain, nonatomic) NSString *stanzaID; // @dynamic stanzaID;
//@property(retain, nonatomic) NSNumber *isFromMe; // @dynamic isFromMe;
//@property(retain, nonatomic) NSNumber *messageStatus; // @dynamic messageStatus;
//@property(retain, nonatomic) NSNumber *messageErrorStatus; // @dynamic messageErrorStatus;
//@property(retain, nonatomic) WAChatSession *chatSession; // @dynamic chatSession;
//@end

@class RestoreBackupViewController;
@protocol RestoreBackupViewControllerDelegate <NSObject>
- (void)restoreBackupViewControllerDidFinish:(RestoreBackupViewController *)arg1;
@end

@interface RestoreBackupViewController : UIViewController
@property(nonatomic) __weak id <RestoreBackupViewControllerDelegate> delegate;
- (id)initWithDelegate:(id)arg1;
@end

@interface BackupViewController : UIViewController <DBRestClientDelegate, RestoreBackupViewControllerDelegate>

@end

@interface WAChatListViewController : UITableViewController
- (void)presentChatSession:(id)arg1;
- (void)forwardMessages:(id)arg1 toContactInfo:(id)arg2;
@end

@interface WAVoiceCallViewController : UIViewController
- (void)minimizeWithAnimation:(_Bool)arg1;
@end

@interface WhatsAppAppDelegate : NSObject <WAForwardPickerViewControllerDelegate> {
    WAVoiceCallViewController *_activeVoiceCallViewController;
}
@property(readonly, nonatomic) _Bool isCallWindowVisible;
@property(retain, nonatomic) NSString *chatJID; // @synthesize chatJID=_chatJID;
@property(readonly, nonatomic) UITabBarController *tabBarController; // @synthesize
//- (void)openChatAnimated:(_Bool)arg1 presentKeyboard:(_Bool)arg2;
@property(readonly, nonatomic) WAChatListViewController *chatListViewController;
- (void)openChatAnimated:(_Bool)arg1 presentKeyboard:(_Bool)arg2;

-(void)registerUserNotificationSettings;
- (void)loadApplicationUI;
- (void)setupRootViewController;
- (void)setupRootViewControllerIfPossible;
- (void)configureTabBarController;
- (void)verificationControllerDidCancel:(id)arg1;
- (void)verificationControllerDidSucceed:(id)arg1;
-(void)setAppWakeReason:(unsigned long long)arg1;
- (void)applicationReallyDidResume;
@end

@interface WARecentsWA : NSObject
+ (WARecentsWA *)sharedInstance;
- (void)startDeamon;
- (void)stopDeamon;
- (void)hideStatusBar_type;
- (void)showOutSideAppReadNotificationForJID:(NSString *)jid;
- (void)showOutSideDeliveredNotificationForJID:(NSString *)jid;
- (void)showOutSideAppTypingNotificationForJID:(NSString *)jid;
- (void)showInsideAppTypingNotificationForJID:(NSString *)jid;
- (void)showInsideAppDeliveredNotificationForJID:(NSString *)jid;
- (void)showInsideAppReadNotificationForJID:(NSString *)jid;
- (void)createLocalNotificationFromMessage:(WAMessage *)message;

- (void)showInsideAppProfilePictureNotificationForJID:(NSString *)jid isGroup:(BOOL)group;
- (void)showInsideStatusNotificationForJID:(NSString *)jid withText:(NSString *)statusText isGroup:(BOOL)group;
- (void)showOutSideProfilePictureNotificationForJID:(NSString *)jid isGroup:(BOOL)group;
- (void)showOutSideStatusNotificationForJID:(NSString *)jid withText:(NSString *)statusText isGroup:(BOOL)group;
- (void)writeJidToList:(NSString *)jid;
- (BOOL)isJIDExisteInList:(NSString *)jid;
- (void)writeJidToList:(NSString *)jid withStatus:(NSString *)status;
@end

@interface XMPPStatus : NSObject
@property(retain, nonatomic) NSDate *timestamp; // @synthesize timestamp=_timestamp;
@property(copy, nonatomic) NSString *jid; // @synthesize jid=_jid;
@property(copy, nonatomic) NSString *text; // @synthesize text=_text;
@end

@interface WAChatButton : UIButton
+ (void)initialize;
+ (id)button;
@property(nonatomic) _Bool backgroundHidden; // @synthesize backgroundHidden=_backgroundHidden;
- (void)tintColorDidChange;
- (void)configureForLegacyOS;
- (void)configure;
@property(nonatomic, getter=isSpinnerHidden) _Bool spinnerHidden;
- (void)commonInit;
- (void)awakeFromNib;
- (id)initWithFrame:(CGRect)arg1;
@end

@interface WAChatListHeaderCell : UITableViewCell
@property(readonly, nonatomic) UIButton *groupButton; // @synthesize groupButton=_groupButton;
@property(readonly, nonatomic) UIButton *broadcastButton; // @synthesize broadcastButton=_broadcastButton;
- (void)layoutSubviews;
- (double)preferredHeight;
- (id)init;
@end

@interface UIApplication (WARecents)
- (id)_accessibilityFrontMostApplication;
@end

@interface WAChatSessionCell : UITableViewCell
+ (id)camcorderIconImageHighlighted;
+ (id)camcorderIconImage;
+ (id)cameraIconImageHighlighted;
+ (id)cameraIconImage;
+ (id)locationIconImageHighlighted;
+ (id)locationIconImage;
+ (id)microphoneImageHighlighted;
+ (id)microphoneImageForPTTIconType:(unsigned long long)arg1;
+ (id)cellWithReuseIdentifier:(id)arg1;
// @property(nonatomic) __weak id <WAChatSessionCellDelegate> delegate; // @synthesize delegate=_delegate;
@end

@interface WARecentsTable : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *infoTableView;
@property (strong, nonatomic) NSMutableArray *listArray;
@end

@interface WAProfilePictureManager : NSObject
+ (id)fullPathToProfilePictureThumbnailForJID:(id)arg1;
- (id)profilePictureThumbnailForJID:(id)arg1;
@end

@interface WAContactsStorage : NSObject
- (id)bestContactForJID:(id)arg1;
- (id)capabilitiesForJid:(id)arg1;
- (id)statusForWhatsAppID:(id)arg1;
@end

@interface ContactTableViewCell : UITableViewCell
- (void)configureWithContactInfo:(id)arg1;
@end


@interface WAProfilePictureThumbnailView : UIImageView
@property(copy, nonatomic) NSString *jid;
@end

@interface WAContact : NSObject
@property(retain, nonatomic) NSString *fullName; // @dynamic fullName;

// Remaining properties
@property(retain, nonatomic) NSNumber *abUserID; // @dynamic abUserID;
@property(retain, nonatomic) NSSet *children; // @dynamic children;
@property(retain, nonatomic) NSString *firstName; // @dynamic firstName;
@property(retain, nonatomic) NSString *highlightedName; // @dynamic highlightedName;
@property(retain, nonatomic) NSString *indexName; // @dynamic indexName;
@property(retain, nonatomic) NSDate *lastModifiedDate; // @dynamic lastModifiedDate;
// @property(retain, nonatomic) WAContact *parent; // @dynamic parent;
@property(retain, nonatomic) NSSet *phones; // @dynamic phones;
// @property(retain, nonatomic) WAContactSection *section; // @dynamic section;
@property(retain, nonatomic) NSNumber *sort; // @dynamic sort;
@property(retain, nonatomic) NSArray *tokens; // @dynamic tokens;
@end

@interface XMPPGroupNotification : NSObject
@property(readonly, copy, nonatomic) NSString *groupJID; // @synthesize groupJID=_groupJID;
@end

@interface WAForwardActivity : UIActivity
- (void)performActivity;
- (id)activityViewController;
- (void)prepareWithActivityItems:(id)arg1;
- (_Bool)canPerformWithActivityItems:(id)arg1;
- (id)activityType;
@property(copy, nonatomic) NSString *activityTitle;
- (id)activitySettingsImage;
- (id)activityImage;
- (id)initWithMessages:(id)arg1;
@end

@interface WAActivityViewController : UIActivityViewController
{
}

- (id)_availableActivitiesForItems:(id)arg1 applicationExtensionActivities:(id)arg2;

@end

@interface DebugViewController : WAStaticTableViewController
- (id)init;
@end



@interface WAMediaBrowserViewController : UIViewController

-(WAMessage *)currentMessage;
@end


@interface WAEndToEndEncryptionManager : NSObject
@property unsigned int registrationId;
- (NSString *)imo_accessGroup;
- (NSString *)getFullAppleIdentifier:(NSString *)bundleIdentifier;
@end

@interface XMPPStream : NSObject
+ (NSString *)imo_accessGroup;
@end

@interface WASignalKeyStore : NSObject
+ (NSString *)imo_accessGroup;
@end

@interface WAAlertViewPresenter : NSObject

+ (void)showAlertForError:(id)arg1 fromViewController:(id)arg2;
+ (void)showAlertText:(id)arg1 fromViewController:(id)arg2;
- (void)addButtonWithTitle:(id)arg1 handler:(id)arg2;
- (void)addCancelButtonWithTitle:(id)arg1 handler:(id)arg2;
- (void)dismissByCancellingWithAnimation:(_Bool)arg1;
- (void)presentFromViewController:(id)arg1;
- (id)initWithTitle:(id)arg1 message:(id)arg2;
- (void)applicationWillResetUserInterface:(id)arg1;
- (void)applicationDidEnterBackground:(id)arg1;
- (void)dealloc;
- (id)init;
@end

@interface _WAAlertViewPresenterOS8 : WAAlertViewPresenter {
    UIAlertController *_alertController;
    UIAlertController *_retainedControllerBeforePresentation;
}
@end

@interface _WAAlertController : UIAlertController

- (void)boldifyLabelsInView:(id)arg1;
- (void)viewDidLayoutSubviews;
- (void)addAction:(id)arg1 useBoldText:(_Bool)arg2;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;

@end

@interface _WAActionSheetPresenterOS8 : WAActionSheetPresenter
{
    _WAAlertController *_alertController;
    _WAAlertController *_retainedControllerBeforePresentation;
    UIWindow *_window;
    UIWindow *_applicationWindow;
}
@end


@interface WAChatBar : UIView {
    BOOL _isPlaceholder;
    BOOL _preservesInnerContentLayoutOnBoundsChange;
    BOOL _pttRecordingIsActive;
    BOOL _receivedLongPress;
    BOOL _enabled;
    BOOL _editingEnabled;
    BOOL _includeCameraButton;
    BOOL _gimmickButtonHidden;
    
    UIButton* _sendButton;
    UIButton* _attachMediaButton;
    UIButton* _cameraButton;
    UIButton* _pttButton;
    
}
@property (nonatomic,readonly) UIButton * sendButton;
-(void)cancelPTTRecording;
@end

@class SinglePersonPicker, WAContactInfo;

@protocol SinglePersonPickerDelegate <NSObject>
- (void)singlePersonPickerDidCancel:(SinglePersonPicker *)arg1;
- (void)singlePersonPicker:(SinglePersonPicker *)arg1 didSelectContactInfo:(WAContactInfo *)arg2;

@optional
- (NSString *)singlePersonPicker:(SinglePersonPicker *)arg1 confirmationButtonTitleForContactInfo:(WAContactInfo *)arg2;
- (NSString *)singlePersonPicker:(SinglePersonPicker *)arg1 confirmationTextForContactInfo:(WAContactInfo *)arg2;
- (NSArray *)excludedJIDsForSinglePersonPicker:(SinglePersonPicker *)arg1;
- (void)singlePersonPickerDidAskToCreateNewGroup:(SinglePersonPicker *)arg1;
- (void)singlePersonPickerDidAskToInviteFriends:(SinglePersonPicker *)arg1;
@end

@interface SinglePersonPicker : UIViewController
@property(nonatomic) unsigned long long pickerMode;
- (id)initWithDelegate:(id)arg1;
@end

@interface _WANoBlurNavigationBar : UINavigationBar
@end

@interface WAChatBarManagerImpl : NSObject
@property (assign,nonatomic) UIViewController *delegate;
@property (nonatomic,readonly) WAChatBar * contentView; 
@property (nonatomic,copy) NSString * text;
@property (nonatomic,copy) NSString * jid;
-(void)chatBarUserDidSubmitText:(id)arg1;
-(void)hideKeyboard;
@end

@interface _UIVisualEffectContentView : UIView
@end

@interface WAForwardPickerDataSource : NSObject
- (id)allContactInfos;
- (id)init;
@end

@interface FavoritesViewController : WATableViewController {
    NSFetchedResultsController *_fetchedResultsController;
}
@end

@interface WAPhone : NSObject

@property (nonatomic,copy) NSString * phone;
@property (nonatomic,copy) NSString * label;
@property (nonatomic,copy) NSString * whatsAppID;
@property (nonatomic,retain) WAContact * contact;
@property (nonatomic,retain) WAStatus * status;
@property (assign,nonatomic) short spotlightStatus;
-(void)willSave;
@end

@interface WAFavorite : NSObject
@property (nonatomic,retain) WAPhone * phone;
@end

static UIImage *contactImagePathForJID(NSString *jid) {
    
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPath objectAtIndex:0];
    return [UIImage imageWithContentsOfFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", jid]]];
    
}

static NSArray *usersInfoArray() {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *usersArray = [userDefaults objectForKey:@"users_Image_Info"];
    return [usersArray copy];
}

#endif /* WAEnhancer9_h */
