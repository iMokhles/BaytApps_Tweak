//
//  WAEPassSetupViewController.h
//  WAEnhancer9
//
//  Created by iMokhles on 11/05/16.
//
//

#import <UIKit/UIKit.h>
#import "YLSwipeLockView.h"

@interface WAEPassSetupViewController : UIViewController <YLSwipeLockViewDelegate>
@property (nonatomic, strong) YLSwipeLockView *lockView;
@property (nonatomic, copy) void (^didSelectPasscodeBlock)(WAEPassSetupViewController *vc, NSString *passcode);
@end
