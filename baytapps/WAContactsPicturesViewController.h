//
//  WAContactsPicturesViewController.h
//  WAContactPicture
//
//  Created by iMokhles on 26/04/16.
//
//

#import <UIKit/UIKit.h>
#import "WAEnhancer9.h"


#pragma mark - Statics
static UINavigationController *singlePickerNavigationController(id target) {
    SinglePersonPicker *contPicker = [[objc_getClass("SinglePersonPicker") alloc] initWithDelegate:target];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:contPicker];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    return navigationController;
}

@interface WAContactsPicturesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SinglePersonPickerDelegate, WASinglePhotoPickerControllerDelegate>

@end
