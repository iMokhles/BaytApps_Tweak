//
//  WAEScheduleViewController.m
//  WAEnhancer9
//
//  Created by iMokhles on 18/05/16.
//
//

#import "WAEScheduleViewController.h"
#import "WAEScheduleCell.h"
#import "WAEnhancer9.h"
#import "FlexibleFrame.h"
#import "WAEnhancer9.h"
#import "NSDate+TimeAgo.h"
#import "WAEnhancer9Helper.h"
#import "NSTimer+Blocks.h"

static const NSUInteger UIViewAutoresizingFlexibleBoth(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
@interface WAEScheduleViewController () {
    UITableView *scheduleTable;
    NSMutableDictionary *schedulesDicts;
}

@end

@implementation WAEScheduleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTable];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *trashBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeAllschedules:)];
    [self.navigationItem setRightBarButtonItems:@[trashBtn]];
    
    self.title = @"Scheduled Messages";
    
    scheduleTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [scheduleTable setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    scheduleTable.delegate = self;
    scheduleTable.dataSource = self;
    [self.view addSubview:scheduleTable];
    
//    [scheduleTable registerClass:[WAEScheduleCell class] forCellReuseIdentifier:@"WAEScheduleCell"];
    
    [self reloadSchedules];
    
}

- (void)reloadSchedules {
    schedulesDicts = [[NSUserDefaults standardUserDefaults] objectForKey:@"schedulesDicts"];
    NSLog(@"%@", schedulesDicts);
    [self updateTable];
}

- (void)updateTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0 animations:^{
            [scheduleTable reloadData];
        } completion:^(BOOL finished) {
            //Do something after that...
            
        }];
    });
}

- (void)removeAllschedules:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"schedulesDicts"];
    [userDefaults synchronize];
    [self reloadSchedules];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - TableViewDelegate/TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [schedulesDicts count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *schedArray = [schedulesDicts objectForKey:[[schedulesDicts allKeys] objectAtIndex:section]];
    return [schedArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self nameFromJID:[[schedulesDicts allKeys] objectAtIndex:section]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    WAEScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WAEScheduleCell"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WAEScheduleCell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WAEScheduleCell"];
    }
    
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2.0;
    cell.imageView.clipsToBounds = YES;
//    cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 40,40);
    
    NSMutableArray *currentArray = [schedulesDicts valueForKey:[[schedulesDicts allKeys] objectAtIndex:indexPath.section]];
    NSDictionary *scheduleDict = [currentArray objectAtIndex:indexPath.row];
    
    WAProfilePictureManager *profilePictureManager = [objc_getClass("WASharedAppData") profilePictureManager];
    UIImage *userImage = [profilePictureManager profilePictureThumbnailForJID:scheduleDict[@"toUserJID"]];
    NSDate *scheduleDateString = scheduleDict[@"messageDate"];
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    // Time format for the string value
//    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss +0000"];
//    NSDate *scheduleDate = [dateFormatter dateFromString:scheduleDateString];
    NSString *userName = scheduleDict[@"chatName"];
    
    // cell.dataDic = scheduleDict;
    cell.textLabel.text = userName;
    cell.imageView.image = [WAEnhancer9Helper makeImage:userImage toThumbnailOfSize:CGSizeMake(50, 50)];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", scheduleDict[@"messageText"]];
    UILabel *label = [UILabel new];
//    [NSTimer scheduledTimerWithTimeInterval:1 block:^{
        label.text = [scheduleDateString timeAgoSimple];
//    } repeats:YES];
    
    [label sizeToFit];
    cell.accessoryView = label;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 40,40);
    
}
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)es forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *currentArray = [[schedulesDicts valueForKey:[[schedulesDicts allKeys] objectAtIndex:indexPath.section]] mutableCopy];
    NSDictionary *scheduleDict = [currentArray objectAtIndex:indexPath.row];
    NSDictionary *scheduleInfo  = scheduleDict;
    NSMutableDictionary *projectsInfoMTBDictNEW = nil;
    
    if (es == UITableViewCellEditingStyleDelete) {
        NSMutableArray *applyChangesArray = currentArray;
        projectsInfoMTBDictNEW = [[NSMutableDictionary alloc] initWithDictionary:schedulesDicts];
        
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *eventArray = [app scheduledLocalNotifications];
        NSLog(@"****** %@", eventArray);
        for (int i=0; i<[eventArray count]; i++)
        {
            UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
            NSDictionary *userInfoCurrent = oneEvent.userInfo;
            NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"scheduleID"]];
            if ([uid isEqualToString:[scheduleInfo objectForKey:@"scheduleID"]])
            {
                //Cancelling local notification
                [app cancelLocalNotification:oneEvent];
                break;
            }
        }
        if (applyChangesArray.count == 0) {
            [applyChangesArray removeObjectAtIndex:indexPath.row];
            [projectsInfoMTBDictNEW removeObjectForKey:[scheduleInfo objectForKey:@"toUserJID"]];
            [projectsInfoMTBDictNEW setObject:applyChangesArray forKey:[scheduleInfo objectForKey:@"toUserJID"]];
            [[NSUserDefaults standardUserDefaults] setObject:projectsInfoMTBDictNEW forKey:@"schedulesDicts"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else if (applyChangesArray.count == 1) {
            [applyChangesArray removeObjectAtIndex:indexPath.row];
            [projectsInfoMTBDictNEW removeObjectForKey:[scheduleInfo objectForKey:@"toUserJID"]];
            [[NSUserDefaults standardUserDefaults] setObject:projectsInfoMTBDictNEW forKey:@"schedulesDicts"];
            [[NSUserDefaults standardUserDefaults] synchronize];
//            [scheduleTable deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        } else if (applyChangesArray.count > 1) {
            [applyChangesArray removeObjectAtIndex:indexPath.row];
            [projectsInfoMTBDictNEW setObject:applyChangesArray forKey:[scheduleInfo objectForKey:@"toUserJID"]];
            [[NSUserDefaults standardUserDefaults] setObject:projectsInfoMTBDictNEW forKey:@"schedulesDicts"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self reloadSchedules];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)nameFromJID:(NSString *)jid {
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    return contact.fullName;
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
