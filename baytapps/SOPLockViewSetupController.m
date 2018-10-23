#import "SOPLockViewSetupController.h"
#import "UIAlertView+Blocks.h"
#import "WATweakHelper.h"

@interface SOPLockViewSetupController ()
@end

@implementation SOPLockViewSetupController
@synthesize lockView;
@synthesize passCodeBlock;

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self customizeLockView];
}

- (void)viewDidLoad {

   [super viewDidLoad];
   [self.view setBackgroundColor:[UIColor blackColor]];
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}


- (void)customizeLockView {
	lockView = [[KKGestureLockView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    lockView.normalGestureNodeImage = [UIImage imageWithContentsOfFile:[WATweakHelper pathForTweakFileWithName:@"BlueCheckUnselected" extension:@"png"]];//[UIImage ckImageNamed:@"BlueCheckUnselected"];
    lockView.selectedGestureNodeImage = [UIImage imageWithContentsOfFile:[WATweakHelper pathForTweakFileWithName:@"AudioButtonHint" extension:@"png"]];//[UIImage ckImageNamed:@"AudioButtonHint"];
    lockView.lineColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    lockView.lineWidth = 5;
    lockView.delegate = self;
    [lockView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    lockView.contentInsets = UIEdgeInsetsMake(150, 20, 150, 20);

	[self.view addSubview:lockView];
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode{
    NSLog(@"%@",passcode);
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    NSLog(@"%@",passcode);

    [self dismissViewControllerAnimated:YES completion:^{
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:passcode forKey:@"gestureNewPassword"];
        if (passCodeBlock != nil) {
			passCodeBlock(passcode);
		}
        [UIAlertView showWithTitle:@"SMSOptions Pro"
                                           message:@"Passcode set Successfully"
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@[@"OK"]
                                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                
                                          }];
    }];
}

@end
