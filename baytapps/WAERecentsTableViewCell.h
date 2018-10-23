//
//  WAERecentsTableViewCell.h
//  WAForIpad
//
//  Created by iMokhles on 20/02/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAERecentsTableViewCell : UITableViewCell
// selection option
@property (nonatomic, assign) BOOL enableSelection;

// value options
@property (nonatomic, assign) BOOL enableValue;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) NSString *valueString;
@end
