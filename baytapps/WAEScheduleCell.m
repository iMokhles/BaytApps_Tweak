//
//  WAEScheduleCell.m
//  WAEnhancer9
//
//  Created by iMokhles on 18/05/16.
//
//

#import "WAEScheduleCell.h"
#import "FlexibleFrame.h"
#import "WAEnhancer9.h"
#import "NSDate+TimeAgo.h"

#define FLEXIBLE_FRAME(x,y,w,h) [FlexibleFrame frameFromIphone5Frame:CGRectMake(x, y, w, h)]
#define FLEXIBLE_NUM(num) [FlexibleFrame flexibleFloat:num]

@implementation WAEScheduleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WAProfilePictureManager *profilePictureManager = [objc_getClass("WASharedAppData") profilePictureManager];
        UIImage *userImage = [profilePictureManager profilePictureThumbnailForJID:self.dataDic[@"toUserJID"]];
        NSDate *scheduleDate = self.dataDic[@"messageDate"];
        _headImageView = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 34, 34)];
            imageView.image = userImage;
            imageView.layer.cornerRadius = 17;
            imageView.clipsToBounds = YES;
            [self.contentView addSubview:imageView];
            imageView;
        });
        
        _userNameLabel = ({
            UILabel * label = [self createLabelWithText:[self nameFromJID:self.dataDic[@"toUserJID"]] font:14 subView:self.contentView];
            label.frame = CGRectMake(50, 0, 150, 30);
            label.textColor = [UIColor blackColor];
            label;
        });
        
        _statusLabel = ({
            UILabel * label = [self createLabelWithText:[NSString stringWithFormat:@"%@  : %@", self.dataDic[@"messageText"], [scheduleDate timeAgoSimple]] font:12 subView:self.contentView];
            label.frame = CGRectMake(50, 25, 150, 17);
            label.textColor = [UIColor grayColor];
            label;
        });
        
    }
    return self;
}

- (NSString *)nameFromJID:(NSString *)jid {
    WAContactsStorage *contactStorage = [objc_getClass("WASharedAppData") contactsStorage];
    WAContact *contact = [contactStorage bestContactForJID:jid];
    return contact.fullName;
}

#pragma mark -- create label
- (UILabel *)createLabelWithText:(NSString *)text font:(CGFloat)font subView:(UIView *)subView
{
    UILabel * label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    label.font = [UIFont systemFontOfSize:font];
    [subView addSubview:label];
    return label;
}

#pragma mark -- create button
- (UIButton *)createButtonWithTitle:(NSString *)title font:(CGFloat)font subView:(UIView *)subView
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitle:title forState:UIControlStateNormal];
    [subView addSubview:button];
    return button;
}

#pragma mark -- create view
- (UIView *)createViewWithBackColor:(UIColor *)color subView:(UIView *)subView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = color;
    [subView addSubview:view];
    return view;
}

@end
