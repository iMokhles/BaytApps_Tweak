//
//  FontStyleOptionsTableViewController.m
//  Bohr
//
//  Created by iMokhles on 27/10/15.
//
//

#import "FontStyleOptionsTableViewController.h"
#import "../ColorPicker/UIColor+CustomColors.h"

@implementation FontStyleOptionsTableViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorFromHexString:[[NSUserDefaults standardUserDefaults] objectForKey:@"prefs_bg_color"]];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

- (void)setup {
    
    self.title = @"Choice options";
    
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:nil handler:^(BOTableViewSection *section) {
        
        NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
        NSArray *fontNames;
        NSInteger indFamily, indFont;
        for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
        {
            fontNames = [[NSArray alloc] initWithArray:
                         [UIFont fontNamesForFamilyName:
                          [familyNames objectAtIndex:indFamily]]];
            for (indFont=0; indFont<[fontNames count]; ++indFont)
            {
                [section addCell:[BOOptionTableViewCell cellWithTitle:[NSString stringWithFormat:@"%@", [fontNames objectAtIndex:indFont]] key:@"text_style" handler:^(BOOptionTableViewCell *cell) {
                    cell.textLabel.font = [UIFont fontWithName:[fontNames objectAtIndex:indFont] size:17];
                }]];
            }
        }
    }]];
}
@end
