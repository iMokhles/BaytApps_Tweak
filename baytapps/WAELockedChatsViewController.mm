//
//  WAESavedUsersViewController.m
//  WAForIpad
//
//  Created by iMokhles on 16/04/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import "WAELockedChatsViewController.h"
#import "WAERecentsTableViewCell.h"
#import "NSDate+TimeAgo.h"
#import "WAEnhancer9Helper.h"
#import "TransNSString.h"
#import "WAEPassCheckViewController.h"
#import "WAEPassSetupViewController.h"
#import "SOPLockViewSetupController.h"
#import "SOPLockViewController.h"

static const NSUInteger UIViewAutoresizingFlexibleBoth(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
@interface WAELockedChatsViewController () <PeopleMultiPickerNavigationControllerDelegate> {
    UITableView *tblOptions;
}
@end

@implementation WAELockedChatsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BOOL isOpened = [[[NSUserDefaults standardUserDefaults] objectForKey:@"islockPageOpened"] boolValue];
    NSString *currentPass = [[NSUserDefaults standardUserDefaults] objectForKey:@"gestureNewPassword"];
    
    SOPLockViewController *lockScreen = [[SOPLockViewController alloc] init];
    [lockScreen setPassCodeBlock:^(NSString *passcode) {
        if ([passcode isEqualToString:currentPass]) {
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"islockPageOpened"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }];
        } else {
            return;
        }
    }];
    
    if (currentPass && !isOpened) {
        [self presentViewController:lockScreen animated:NO completion:nil];
    } else if (!currentPass) {
        WABlockBasedAlertView *alertView = [objc_getClass("WABlockBasedAlertView") alertViewWithTitle:@"Password Warning" message:[NSString translateToAR:@"لم تقم بوضع كلمة مرور لغلق المحادثات! هل تود وضعها الان ؟" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"You didn't set your password yet! would you like to do it now ?" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil]];
        
        [alertView addButtonWithTitle:[NSString translateToAR:@"نعم" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"Yes" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil] handler:^{
            
            SOPLockViewSetupController *lockScreen = [[SOPLockViewSetupController alloc] init];
            [self presentViewController:lockScreen animated:NO completion:nil];
            
        }];
        
        [alertView addCancelButtonWithTitle:@"Cancel" handler:^{
            
        }];
        
        [alertView show];
    }
    [self updateTable];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *trashBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeAllUsers:)];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUsers:)];
    
    [self.navigationItem setRightBarButtonItems:@[trashBtn, addBtn]];
    
    self.title = @"Saved Users";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    listArray = [userDefaults objectForKey:@"locked_users_JIDs"];
    NSArray *sorted = [listArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 intValue] < [obj2 intValue]) return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
    listArray = [sorted mutableCopy];
    tblOptions = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [tblOptions setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    tblOptions.delegate = self;
    tblOptions.dataSource = self;
    [self.view addSubview:tblOptions];
    
    [tblOptions registerClass:[WAERecentsTableViewCell class] forCellReuseIdentifier:@"WAERecentsTableViewCell"];
    
    [self updateTable];
}

- (void)updateTable {
    // dispatch_sync(dispatch_get_main_queue(), ^{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    listArray = [userDefaults objectForKey:@"locked_users_JIDs"];
    NSArray *sorted = [listArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 intValue] < [obj2 intValue]) return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
    listArray = [sorted mutableCopy];
    [tblOptions reloadData];
    [tblOptions layoutIfNeeded];
    // });
}

- (void)removeAllUsers:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"locked_users_JIDs"];
    [userDefaults synchronize];
    [self updateTable];
}

- (void)addUsers:(id)sender {
    PeopleMultiPickerNavigationController *peoplePicker = [[objc_getClass("PeopleMultiPickerNavigationController") alloc] initWithDelegate:self];
    [peoplePicker setPickerMode:2];
    [peoplePicker setSelectionLimit:256];
    [self presentViewController:peoplePicker animated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - People Picker Delegate 

- (void)peopleMultiPickerNavigationControllerDidCancel:(PeopleMultiPickerNavigationController *)arg1 {
    [arg1 dismissViewControllerAnimated:YES completion:nil];
}
- (void)peopleMultiPickerNavigationController:(PeopleMultiPickerNavigationController *)arg1 didSelectContacts:(NSArray *)arg2 {
    
    [arg1 dismissViewControllerAnimated:YES completion:^{
        dispatch_group_t    group = dispatch_group_create();
        for (WAContactInfo *info in arg2) {
            dispatch_group_enter(group);
            if ([group isEqual:arg2.lastObject]) {
                [self updateTable];
                dispatch_group_leave(group);
            }
            NSString *userJID = info.jid;
            NSString *userStatus = [self detailFromJID:userJID];
            [WAEnhancer9Helper writeChatJidToList:userJID withStatus:userStatus];
        }
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [self updateTable];
        });
        [self updateTable];
    }];
}

#pragma mark - UITableView delegate functions

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WAERecentsTableViewCell *cell = [[WAERecentsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WAERecentsTableViewCell"];
    cell.enableSelection = NO;
    NSString *jidArray = [listArray objectAtIndex:indexPath.row];
    NSArray *userArray = [jidArray componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
    NSString *jid = [userArray objectAtIndex:0];
    NSString *status = [userArray objectAtIndex:1];
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
        newListArray = [sorted mutableCopy];
        [userDefaults setObject:newListArray forKey:@"locked_users_JIDs"];
        [userDefaults synchronize];
        [self updateTable];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
