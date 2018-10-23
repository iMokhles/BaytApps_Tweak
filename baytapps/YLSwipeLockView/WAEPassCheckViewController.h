//
//  WAEPassSetupViewController.h
//  WAEnhancer9
//
//  Created by iMokhles on 11/05/16.
//
//

#import <UIKit/UIKit.h>
#import "YLSwipeLockView.h"

@interface WAEPassCheckViewController : UIViewController <YLSwipeLockViewDelegate>
@property (nonatomic, strong) YLSwipeLockView *lockView;
@property (nonatomic, copy) void (^didSelectPasscodeBlock)(WAEPassCheckViewController *vc, NSString *passcode, BOOL isOK);
@end
