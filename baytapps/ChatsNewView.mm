//
//  ViewController.m
//  MultiSelectTable
//
//  Created by Ray Tam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChatsNewView.h"
#include <objc/runtime.h>
#import "iMoMacros.h"

static const NSUInteger UIViewAutoresizingFlexibleBoth(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

@interface WAChatSession : NSObject
@property(readonly, nonatomic, getter=isGroupChat) _Bool groupChat;
@property(readonly, nonatomic, getter=isBroadcastListJIDValid) _Bool broadcastListJIDValid;
@property(readonly, nonatomic, getter=isBroadcastList) _Bool broadcastList;
@property(retain, nonatomic) NSNumber *archived; // @dynamic archived;
@property(retain, nonatomic) NSNumber *contactABID; // @dynamic contactABID;
@property(retain, nonatomic) NSString *eTag; // @dynamic eTag;
@property(retain, nonatomic) NSNumber *flags; // @dynamic flags;
// @property(retain, nonatomic) WAGroupInfo *groupInfo; // @dynamic groupInfo;
@property(retain, nonatomic) NSSet *groupMembers; // @dynamic groupMembers;
@property(retain, nonatomic) NSNumber *hidden; // @dynamic hidden;
// @property(retain, nonatomic) WAMessage *lastMessage; // @dynamic lastMessage;
@property(retain, nonatomic) NSDate *lastMessageDate; // @dynamic lastMessageDate;
@property(retain, nonatomic) NSString *lastMessageText; // @dynamic lastMessageText;
@property(retain, nonatomic) NSDate *locationSharingEndDate; // @dynamic locationSharingEndDate;
@property(retain, nonatomic) NSNumber *messageCounter; // @dynamic messageCounter;
@property(retain, nonatomic) NSSet *messages; // @dynamic messages;
@property(retain, nonatomic) NSString *partnerName; // @dynamic partnerName;
// @property(retain, nonatomic) WAChatProperties *properties; // @dynamic properties;
@property(retain, nonatomic) NSNumber *removed; // @dynamic removed;
@property(retain, nonatomic) NSString *savedInput; // @dynamic savedInput;
@property(retain, nonatomic) NSNumber *sessionType; // @dynamic sessionType;
@property(retain, nonatomic) NSNumber *unreadCount; // @dynamic unreadCount;
@end

@interface WAChatStorage : NSObject
- (id)allChatSessions;
- (id)existingChatSessionsForJIDs:(id)arg1 prefetchingLastMessage:(_Bool)arg2;
- (id)newOrExistingChatSessionForJID:(id)arg1; // new beta
-(id)existingChatSessionForJID:(id)jid; // old
-(id)chatSessionForJID:(id)jid;
- (void)sendMessageWithText:(id)arg1 metadata:(id)arg2 inChatSession:(id)arg3; // new beta
- (void)sendMessageWithText:(id)arg1 inChatSession:(id)arg2;
- (void)sendMessageWithImage:(id)arg1 caption:(id)arg2 inChatSession:(id)arg3 completion:(id)arg4;
-(void)sendMessage:(id)message notify:(BOOL)notify;
- (void)retrySendingMessage:(id)arg1;
- (id)allChatSessionsWithPrefetchedRelationships:(id)arg1 includeBroadcastLists:(_Bool)arg2; // new
- (void)forwardMessages:(id)arg1 toChatSession:(id)arg2;
@end

// @interface WAChatSession : NSObject
// @property(retain, nonatomic) NSSet *messages; // @dynamic messages;
// @property(retain, nonatomic) NSNumber *unreadCount; // @dynamic unreadCount;
// @property(retain, nonatomic) NSString *partnerName; // @dynamic partnerName;
// @property(retain, nonatomic) NSString *lastMessageText; // @dynamic lastMessageText;
// @property(retain, nonatomic) WAMessage *lastMessage; // @dynamic lastMessage;
// @end

@interface WASharedAppData : NSObject
+ (id)contactsStorage;
+ (id)chatStorage;
+ (id)chatDatabaseURLInAppGroup;
@end

@interface FMResultSet : NSObject
- (id)resultDictionary;
- (_Bool)next;
@end

@interface FMDatabase : NSObject
+ (id)databaseWithPath:(id)arg1;
- (_Bool)close;
- (id)executeQuery:(id)arg1;
- (_Bool)open;
@end

@interface WABlockBasedAlertView : UIAlertView
+ (void)showErrorMessage:(id)arg1;
+ (id)alertViewWithTitle:(id)arg1 message:(id)arg2;
- (void)show;
- (void)cancelAlertViewWithAnimation:(_Bool)arg1;
- (void)addCancelButtonWithTitle:(id)arg1 handler:(id)arg2;
- (void)addButtonWithTitle:(id)arg1 handler:(id)arg2;
@end

// @interface WABlockBasedAlertView : UIAlertView
// + (void)showErrorMessage:(id)arg1;
// + (id)alertViewWithTitle:(id)arg1 message:(id)arg2;
// - (void)show;
// - (void)cancelAlertViewWithAnimation:(_Bool)arg1;
// - (void)addCancelButtonWithTitle:(id)arg1 handler:(id)arg2;
// - (void)addButtonWithTitle:(id)arg1 handler:(id)arg2;
// @end

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
@end
@interface WABubbleView : UIView
@property(retain, nonatomic) NSString *pushName; // @synthesize pushName=_pushName;
@property(retain, nonatomic) NSString *fromName; // @synthesize fromName=_fromName;
- (void)handleDoubleTap;
- (void)handleSingleTap;
- (void)stopSpeakingMessage:(id)arg1;
- (void)speakMessage:(id)arg1;
- (void)replyMessageSender:(id)arg1;
- (void)addMessageSenderToContacts:(id)arg1;
- (void)forwardMessage:(id)arg1;
- (void)messageDetails:(id)arg1;
- (void)deleteMessage:(id)arg1;
- (void)copyMessage:(id)arg1;
@end

@interface WAMessageTextView : UIView {
    NSArray *_textMessages;
}
@end

@interface WATextMessageCell : UITableViewCell {
    WAMessageTextView *_messageTextView;
}
@end

@interface WATextBubbleView : WABubbleView
@property(retain, nonatomic) NSArray *messages; // @synthesize messages=_messages;
@end

@interface ChatViewController : UIViewController
@property(nonatomic) _Bool groupChat; // @synthesize groupChat=_groupChat;
@end

@interface WAMessage : NSObject
@property(retain, nonatomic) NSNumber *isFromMe; // @dynamic isFromMe;
// @property(retain, nonatomic) WAMediaItem *mediaItem; // @dynamic mediaItem;
@property(retain, nonatomic) NSString *mediaSectionID; // @dynamic mediaSectionID;
@property(retain, nonatomic) NSDate *messageDate; // @dynamic messageDate;
@property(retain, nonatomic) NSNumber *messageErrorStatus; // @dynamic messageErrorStatus;
// @property(retain, nonatomic) WAMessageInfo *messageInfo; // @dynamic messageInfo;
@property(retain, nonatomic) NSNumber *messageType; // @dynamic messageType;
// @property(retain, nonatomic) WAMessage *parentMessage; // @dynamic parentMessage;
@property(retain, nonatomic) NSString *pushName; // @dynamic pushName;
@property(retain, nonatomic) NSDate *sentDate; // @dynamic sentDate;
@property(retain, nonatomic) NSNumber *sort; // @dynamic sort;
@property(retain, nonatomic) NSString *stanzaID; // @dynamic stanzaID;
@property(retain, nonatomic) NSString *text; // @dynamic text;
@property(retain, nonatomic) NSString *toJID; // @dynamic toJID;
@end

@interface WAChatCellData : NSObject
@property(readonly, nonatomic) NSArray *messages; // @synthesize messages=_messages;
@end

@interface WAMessageCell : UITableViewCell
@property(readonly, nonatomic) WAChatCellData *cellData; // @synthesize cellData=_cellData;
@end

extern WAMessage *waofaMessage;

@interface ChatsNewView () {
    NSMutableArray *arOptions;
    NSMutableArray *arSelectedRows;
    WAChatStorage *chatStorage;
}

@end

@implementation ChatsNewView

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    chatStorage = [objc_getClass("WASharedAppData") chatStorage];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"WAOneForAll";
    // if (iMoAppVersionLessThanOrEqualTo(@"2.12.5")) {
    NSURL *dataBasePath = [objc_getClass("WASharedAppData") chatDatabaseURLInAppGroup];
    NSMutableArray *allMessages = [[NSMutableArray alloc] init];
    FMDatabase *database = [objc_getClass("FMDatabase") databaseWithPath:dataBasePath.absoluteString];
    [database open];
    FMResultSet *resultsWithNameLocation = [database executeQuery:@"SELECT * FROM ZWACHATSESSION"];
    while([resultsWithNameLocation next]) {
        /* taking results from database to a string "eleData" */
        [allMessages addObject:[resultsWithNameLocation resultDictionary]];
    }
    [database close];

    arOptions = allMessages;
    // } else if (iMoAppVersionGreaterThanOrEqualTo(@"2.12.5")) {
    //     arOptions = [chatStorage allChatSessionsWithPrefetchedRelationships:nil includeBroadcastLists:YES];
    // }
    
    // [[NSMutableArray alloc] init];
    // for(int i = 1; i <= 20; i++) {
    //     [arOptions addObject:[NSString stringWithFormat:@"Option %i", i]];
    // }
    arSelectedRows = [[NSMutableArray alloc] init];
    
    UITableView *tblOptions = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    [tblOptions setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    tblOptions.delegate = self;
    tblOptions.dataSource = self;
    [self.view addSubview:tblOptions];

    UIBarButtonItem * editPassButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action: @selector(btnAlertTapped:)];

    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    CGRect frame = CGRectMake(0, tblOptions.frame.size.height, [[UIScreen mainScreen] bounds].size.width, 44);
    toolbar.frame = frame;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:editPassButton];
    [toolbar setItems:items animated:NO];
    [self.view addSubview:toolbar];

    UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithTitle:@"X" style:UIBarButtonItemStylePlain target:self action:@selector(closeVC:)];
    self.navigationItem.rightBarButtonItem = close;

    [tblOptions reloadData];
}

- (void)closeVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

-(void)btnAlertTapped:(id)sender {
    WABlockBasedAlertView *alertView = [objc_getClass("WABlockBasedAlertView") alertViewWithTitle:@"WAOneForAll" message:[NSString stringWithFormat:@"are you sure to Forward this message to \n%@", [[self getSelections] componentsJoinedByString:@", "]]];
    [alertView addButtonWithTitle:@"YES/Send" handler:^{
        [self dismissViewControllerAnimated:YES completion:^{
            for (NSString *jidString in [self getSelectionsJIDS]) {
                NSString *message = [[NSUserDefaults standardUserDefaults] stringForKey:@"waOneForAllMessage"];
                WAChatSession *chat = [chatStorage newOrExistingChatSessionForJID:jidString];
                if (!chat) {
                    chat = [chatStorage newOrExistingChatSessionForJID:jidString];
                }
                if (iMoAppVersionGreaterThanOrEqualTo(@"2.16")) {
                    [chatStorage forwardMessages:@[waofaMessage] toChatSession:chat];
                } else if (iMoAppVersionGreaterThanOrEqualTo(@"2.12.5")) {
                    [chatStorage sendMessageWithText:message metadata:nil inChatSession:chat];
                } else {
                    [chatStorage sendMessageWithText:message inChatSession:chat];
                }
            }
        }];
    }];
    [alertView addCancelButtonWithTitle:@"Cancel" handler:^{
        
    }];

    [alertView show];
}

-(NSArray *)getSelectionsJIDS {
    NSMutableArray *selections = [[NSMutableArray alloc] init];
    
    for(NSIndexPath *indexPath in arSelectedRows) {
        [selections addObject:[[arOptions objectAtIndex:indexPath.row] objectForKey: @"ZCONTACTJID"]];
    }
    
    return selections;
}

-(NSArray *)getSelections {
    NSMutableArray *selections = [[NSMutableArray alloc] init];
    
    for(NSIndexPath *indexPath in arSelectedRows) {
        [selections addObject:[[arOptions objectAtIndex:indexPath.row] objectForKey: @"ZPARTNERNAME"]];
    }
    
    return selections;
}

#pragma mark - UITableView delegate functions

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arOptions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdent = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];

    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
    }

    // NSString *userJID = chatSession[@"ZCONTACTJID"];
    // NSString *userName = chatSession[@"ZPARTNERNAME"];
    cell.textLabel.text = [[arOptions objectAtIndex:indexPath.row] objectForKey: @"ZPARTNERNAME"];
    cell.detailTextLabel.text = [[arOptions objectAtIndex:indexPath.row] objectForKey: @"ZCONTACTJID"];
    if ([cell.detailTextLabel.text hasSuffix:@"@g.us"]) {
        // group
        cell.imageView.image = [UIImage imageNamed:@"GroupChatRound.png"];
    } else {
        // user
        cell.imageView.image = [UIImage imageNamed:@"PersonalChatRound.png"];
    }

    if([arSelectedRows containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [arSelectedRows addObject:indexPath];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [arSelectedRows removeObject:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
