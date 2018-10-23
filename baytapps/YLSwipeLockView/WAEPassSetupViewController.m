//
//  WAEPassSetupViewController.m
//  WAEnhancer9
//
//  Created by iMokhles on 11/05/16.
//
//

#import "WAEPassSetupViewController.h"
#import "WAEnhancer9.h"

@interface WAEPassSetupViewController ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong) NSString *passwordString;
@property (nonatomic, weak) UIButton *resetButton;
@end

@implementation WAEPassSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:35/255.0 green:39/255.0 blue:54/255.0 alpha:1];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"set your gesture password";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(40, 60, self.view.bounds.size.width - 80, 20);
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [self customizeLockView];
    
    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 60, 40, 20)];
    [resetButton setTitle:@"reset" forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    self.resetButton = resetButton;
    self.resetButton.hidden = YES;
    
}

- (void)customizeLockView {
    
    CGFloat viewWidth = self.view.bounds.size.width - 40;
    CGFloat viewHeight = viewWidth;
    
    YLSwipeLockView *lockView = [[YLSwipeLockView alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height - viewHeight - 40 - 100, viewWidth, viewHeight)];
    [self.view addSubview:lockView];
    self.lockView = lockView;
    self.lockView.delegate = self;
    
}

-(YLSwipeLockViewState)swipeView:(YLSwipeLockView *)swipeView didEndSwipeWithPassword:(NSString *)password {
    if (self.passwordString == nil) {
        self.passwordString = password;
        self.titleLabel.text = @"confirm your gesture password again";
        return YLSwipeLockViewStateNormal;
    } else if ([self.passwordString isEqualToString:password]){
        self.titleLabel.text = @"set succeed";
        self.passwordString = nil;
        
        [objc_getClass("KeychainWrapper") setKeychainValue:password forIdentifier:@"gesturePassword"];
        
        self.didSelectPasscodeBlock(self, password);
        return YLSwipeLockViewStateSelected;
    }else{
        self.titleLabel.text = @"different from last time";
        self.resetButton.hidden = NO;
        return YLSwipeLockViewStateWarning;
    }
}


-(void)dismiss{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)reset
{
    self.passwordString = nil;
    self.titleLabel.text = @"set your gesture password";
    self.resetButton.hidden = YES;
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
