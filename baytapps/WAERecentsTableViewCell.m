//
//  WAERecentsTableViewCell.m
//  WAForIpad
//
//  Created by iMokhles on 20/02/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import "WAERecentsTableViewCell.h"

@implementation WAERecentsTableViewCell

@synthesize valueLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // ignore the style argument, use our own to override
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // If you need any further customization
        valueLabel = [UILabel new];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CALayer *cellImageLayer = self.imageView.layer;
    [cellImageLayer setCornerRadius:self.imageView.frame.size.width / 2.0];
    [cellImageLayer setMasksToBounds:YES];
    
    [valueLabel setTextColor:[UIColor whiteColor]];
    [valueLabel setText:self.valueString];
    [valueLabel sizeToFit];
    self.accessoryView = valueLabel;
    
    if (self.enableSelection) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
