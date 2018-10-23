//
//  ViewController.m
//  MultiSelectTable
//
//  Created by Ray Tam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WARecentsList.h"
#import "WAERecentsTableViewCell.h"
#import "NSDate+TimeAgo.h"

// static const NSUInteger UIViewAutoresizingFlexibleBoth(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

static const NSUInteger UIViewAutoresizingFlexibleBoth(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

@interface WAChatSession : NSObject
@property (nonatomic,copy) NSString * contactJID;
@property(retain, nonatomic) NSSet *messages; // @dynamic messages;
@property(retain, nonatomic) NSNumber *unreadCount; // @dynamic unreadCount;
@property(retain, nonatomic) NSString *partnerName; // @dynamic partnerName;
@property(retain, nonatomic) NSString *lastMessageText; // @dynamic lastMessageText;
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
@end

@interface WASharedAppData : NSObject
+ (id)contactsStorage;
+ (id)profilePictureManager;
+ (id)chatStorage;
+ (id)userJID;
+ (id)notificationCenter; // old
+ (id)chatSearchDatabaseURLInAppGroup;
@end

@interface WAProfilePictureManager : NSObject
+ (id)fullPathToProfilePictureThumbnailForJID:(id)arg1;
@end

@interface WAContactInfo : NSObject
- (id)initWithChatSession:(id)arg1;
- (id)initWithContact:(id)arg1;
- (id)initWithWAContactObjectID:(id)arg1;
@property(copy, nonatomic) NSString *statusText; // @synthesize statusText=_statusText;
@property(copy, nonatomic) NSString *highlightedName; // @synthesize highlightedName=_highlightedName;
@property(copy, nonatomic) NSString *jid; // @synthesize jid=_jid;
@property(copy, nonatomic) NSString *firstName; // @synthesize firstName=_firstName;
@property(copy, nonatomic) NSString *fullName; // @synthesize fullName=_fullName;
@end

@interface WAContactsStorage : NSObject
- (id)bestContactForJID:(id)arg1;
- (id)statusForWhatsAppID:(id)arg1;
@end

@interface NSString (Additions)
- (id)wa_whatsAppIDFromJID;
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

@interface WARecentsList () {
    UITableView *tblOptions;
}

@end

@implementation WARecentsList

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable:) name:@"WARecentsUpdateTableNotifications" object:nil];
    [self updateTable:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateTable:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    UIBarButtonItem *trashBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeAllRecents:)];
    [self.navigationItem setRightBarButtonItem:trashBtn];
    
    self.title = @"Recents";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    listArray = [userDefaults objectForKey:@"userJIDs"];
    NSArray *sorted = [listArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([obj1 intValue] < [obj2 intValue]) return NSOrderedAscending;
            else return NSOrderedDescending;
    }];
    listArray = sorted;
    tblOptions = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [tblOptions setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    tblOptions.delegate = self;
    tblOptions.dataSource = self;
    [self.view addSubview:tblOptions];
    
    [tblOptions registerClass:[WAERecentsTableViewCell class] forCellReuseIdentifier:@"WAERecentsTableViewCell"];
    
    [self updateTable:nil];
}

- (void)updateTable:(NSNotification *)noti {
    // dispatch_sync(dispatch_get_main_queue(), ^{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    listArray = [userDefaults objectForKey:@"userJIDs"];
    NSArray *sorted = [listArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([obj1 intValue] < [obj2 intValue]) return NSOrderedAscending;
            else return NSOrderedDescending;
    }];
    listArray = sorted;
    [tblOptions reloadData];
    [tblOptions layoutIfNeeded];
    // });
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)removeAllRecents:(UIBarButtonItem *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"userJIDs"];
    [userDefaults synchronize];
    [self updateTable:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - UITableView delegate functions

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdent = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    WAERecentsTableViewCell *cell = [[WAERecentsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WAERecentsTableViewCell"];;
    cell.enableSelection = YES;
    NSString *jidArray = [listArray objectAtIndex:indexPath.row];
    // NSString *jidArray = jidDict[@"uniqueNameStatus"];
    NSArray *myArray = [jidArray componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    NSString *jid = [myArray objectAtIndex:0];
    NSRange r1 = [jidArray rangeOfString:@"/"];
    NSRange r2 = [jidArray rangeOfString:@"*"];
    NSRange rSub = NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length);
    NSString *status = [jidArray substringWithRange:rSub];
    
    NSArray *statusDateArray = [jidArray componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"*"]];
    NSString *statusDateString = [statusDateArray objectAtIndex:1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm a"];
    NSDate *date = [formatter dateFromString:statusDateString];
    
    cell.valueString = [date timeAgoSimple];
    cell.textLabel.text = [self nameFromJID:jid];
    cell.detailTextLabel.text = status; //[self detailFromJID:jid];
    UIImage *profImage = [self imageFromJID:jid];
    if ([cell.detailTextLabel.text hasSuffix:@"@g.us"]) {
        // group
        if (profImage) {
            cell.imageView.image = profImage;
        } else {
            cell.imageView.image = [UIImage imageNamed:@"GroupChatRound.png"];
        }
    } else {
        // user
        if (profImage) {
            cell.imageView.image = profImage;
        } else {
            cell.imageView.image = [UIImage imageNamed:@"PersonalChatRound.png"];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)es forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (es == UITableViewCellEditingStyleDelete) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSMutableArray *newListArray = [[NSMutableArray alloc] initWithArray:listArray];
        [newListArray removeObjectAtIndex:indexPath.row];
        NSArray *sorted = [newListArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                if ([obj1 intValue] < [obj2 intValue]) return NSOrderedAscending;
                else return NSOrderedDescending;
        }];
        newListArray = sorted;
        [userDefaults setObject:newListArray forKey:@"userJIDs"];
        [userDefaults synchronize];
        [self updateTable:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

- (UIImage *)imageFromJID:(NSString *)jid {
    UIImage *profileImage = [UIImage imageWithContentsOfFile:[objc_getClass("WAProfilePictureManager") fullPathToProfilePictureThumbnailForJID:jid]];
    return profileImage;
}
- (WAContactInfo *)contactInfoForJID:(NSString *)jid {
    // WAChatStorage *storage = [%c(WASharedAppData) chatStorage];
    WAChatStorage *storage = [objc_getClass("WASharedAppData") chatStorage];
    WAChatSession *chatSess = [storage newOrExistingChatSessionForJID:jid];
    WAContactInfo *contactInfo = [[objc_getClass("WAContactInfo") alloc] initWithChatSession:chatSess];
    return contactInfo;
}
- (NSString *)nameFromJID:(NSString *)jid {
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    return contact.fullName;
}
- (NSString *)detailFromJID:(NSString *)jid {
    WAContactsStorage *storage = [objc_getClass("WASharedAppData") contactsStorage];
    NSString *waID = [jid wa_whatsAppIDFromJID];
    WAStatus *userStatus = [storage statusForWhatsAppID:waID];
    return userStatus.text;
}

@end
