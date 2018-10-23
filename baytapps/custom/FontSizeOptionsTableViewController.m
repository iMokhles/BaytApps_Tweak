//
//  OptionsTableViewController.m
//  Bohr
//
//  Created by David Román Aguirre on 28/08/15.
//
//

#import "FontSizeOptionsTableViewController.h"
#import "../ColorPicker/UIColor+CustomColors.h"

@implementation FontSizeOptionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(manualSize)];
    [button setTintColor:[UIColor blackColor]];
    [self.navigationItem setRightBarButtonItem:button];
    
}

- (void)manualSize {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Font Size"
                                          message:@"Write your font size between 5 and 160"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.delegate = self;
         textField.keyboardType = UIKeyboardTypeNumberPad;
         textField.placeholder = NSLocalizedString(@"Text Size", @"Size");
     }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   UITextField *sizeField = alertController.textFields.firstObject;
                                   int numberSize = [sizeField.text intValue];
                                   if (numberSize > 160 || numberSize < 5) {
                                       UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"Error" message:@"Size shouldn't be more than 160 or less than 5" preferredStyle:UIAlertControllerStyleAlert];
                                       [alertController2 addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                           [alertController2 dismissViewControllerAnimated:YES completion:nil];
                                       }]];
                                       [self presentViewController:alertController2 animated:YES completion:nil];
                                   } else {
                                       [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:numberSize-5] forKey:@"text_size"];
                                   }
                                   
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 3;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorFromHexString:[[NSUserDefaults standardUserDefaults] objectForKey:@"prefs_bg_color"]];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

- (void)setup {
	
	self.title = @"Choice options";
	
	[self addSection:[BOTableViewSection sectionWithHeaderTitle:nil handler:^(BOTableViewSection *section) {
        
        for (NSInteger i = 0; i < 160+1; i++) {
            [section addCell:[BOOptionTableViewCell cellWithTitle:[NSString stringWithFormat:@"Size %li", (long)i] key:@"text_size" handler:^(BOOptionTableViewCell *cell) {
            }]];
        }
	}]];
}

@end
