//
//  WAContactsPicturesViewController.m
//  WAContactPicture
//
//  Created by iMokhles on 26/04/16.
//
//

#import "WAContactsPicturesViewController.h"
#import "UIAlertView+Blocks.h"


static const NSUInteger UIViewAutoresizingFlexibleBoth(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
static NSString *const cell_ID = @"ContactsPictureTableViewCell";

@interface WAContactsPicturesViewController () {
    NSMutableArray *usersArray;
    UITableView *usersTableView;
    NSString *userJID;
    
}

@end

@implementation WAContactsPicturesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTable];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateTable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *trashBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeAllChanges:)];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUsers:)];
    
    [self.navigationItem setRightBarButtonItems:@[trashBtn, addBtn]];
    
    self.title = @"Contacts Pictures";
    
    usersArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"users_Image_Info"];
    if (usersArray.count == 0) {
        usersArray = [[NSMutableArray alloc] init];
    }
    
    usersTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [usersTableView setAutoresizingMask:UIViewAutoresizingFlexibleBoth];
    usersTableView.delegate = self;
    usersTableView.dataSource = self;
    [self.view addSubview:usersTableView];
    
    [usersTableView registerClass:objc_getClass("ContactTableViewCell") forCellReuseIdentifier:cell_ID];
    
    [self updateTable];
}

- (void)addUsers:(id)sender {
    
    [self presentViewController:singlePickerNavigationController(self) animated:YES completion:nil];
}

// update table
- (void)updateTable {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    usersArray = [userDefaults objectForKey:@"users_Image_Info"];
    [usersTableView reloadData];
    [usersTableView layoutIfNeeded];
}

// remove all
- (void)removeAllChanges:(UIBarButtonItem *)sender {
    
    [UIAlertView showWithTitle:@"WAContactPicture" message:@"are you sure to remove all changes ?" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"YES"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        if ([title isEqualToString:@"Cancel"]) {
            //
        } else {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:nil forKey:@"users_Image_Info"];
            [userDefaults synchronize];
            [self updateTable];
        }
    }];
}

// Orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - UITableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return usersArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactTableViewCell *cell = [[objc_getClass("ContactTableViewCell") alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_ID];
    
    NSString *userJID_cell = [usersArray objectAtIndex:indexPath.row];
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:userJID_cell];
    WAContactInfo *contactInfoCell = [[objc_getClass("WAContactInfo") alloc] initWithContact:contact];
    [cell configureWithContactInfo:contactInfoCell];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

#pragma mark - SinglePersonPicker Delegate

- (void)singlePersonPickerDidCancel:(SinglePersonPicker *)arg1 {
    [arg1.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)singlePersonPicker:(SinglePersonPicker *)arg1 didSelectContactInfo:(WAContactInfo *)arg2 {
//    WAContactInfo *contactInfo = arg2;//[contactInfo configureWithContactInfo:arg2];
    userJID = arg2.jid;
    
    NSMutableArray *usersInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"users_Image_Info"];
    NSMutableArray *newUserInfo = nil;
    NSArray *arrayCheck = [usersInfo copy];
    if (!usersInfo) {
        usersInfo = [[NSMutableArray alloc] init];
        [[usersInfo mutableCopy] addObject:userJID];
        [[NSUserDefaults standardUserDefaults] setObject:usersInfo forKey:@"users_Image_Info"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        newUserInfo = [[NSMutableArray alloc] initWithArray:[usersArray mutableCopy]];
        if ([arrayCheck containsObject:userJID]) {
            
        } else {
            [newUserInfo addObject:userJID];
            [[NSUserDefaults standardUserDefaults] setObject:newUserInfo forKey:@"users_Image_Info"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    [arg1.navigationController dismissViewControllerAnimated:YES completion:^{
        
        WASinglePhotoPickerController *singlePhotoPicker = [[objc_getClass("WASinglePhotoPickerController") alloc] init];
        [singlePhotoPicker setDelegate:self];
        [singlePhotoPicker presentFromViewController:self];
        
        [self updateTable];
    }];
}

- (void)singlePhotoPickerController:(WASinglePhotoPickerController *)arg1 didFinishWithImage:(UIImage *)arg2 {
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPath objectAtIndex:0];
    NSString *writePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", userJID]];
    NSData *imageData = UIImagePNGRepresentation(arg2);
    if (![imageData writeToFile:writePath atomically:YES]) {
        NSLog(@"image save failed to path %@", writePath);
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            [self updateTable];
        }];
        
    }
}
- (void)singlePhotoPickerControllerDidCancel:(WASinglePhotoPickerController *)arg1 {
    [self dismissViewControllerAnimated:YES completion:^{
        [self updateTable];
    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)es forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (es == UITableViewCellEditingStyleDelete) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *newListArray = [[NSMutableArray alloc] initWithArray:[usersArray mutableCopy]];
        NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [searchPath objectAtIndex:0];
        NSString *writePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [newListArray objectAtIndex:indexPath.row]]];
        [[NSFileManager defaultManager] removeItemAtPath:writePath error:nil];
        [newListArray removeObjectAtIndex:indexPath.row];
        [userDefaults setObject:newListArray forKey:@"users_Image_Info"];
        [userDefaults synchronize];
        [self updateTable];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
