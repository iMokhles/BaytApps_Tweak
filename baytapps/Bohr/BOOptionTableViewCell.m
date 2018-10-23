//
//  BOOptionTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 21/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOOptionTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

// #import "../WAForIpad.h"


@implementation BOOptionTableViewCell

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	self.setting.value = @(self.indexPath.row);
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WAELoadApplicationUI" object:nil];
	// [[objc_getClass("WATheme") defaultTheme] reloadFonts];
}

- (void)settingValueDidChange {
	NSInteger optionIndex = [self.setting.value integerValue];
	self.accessoryType = (optionIndex == self.indexPath.row) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
