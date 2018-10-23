//
//  KKColorsHeaderView.h
//  KKColorListPickerExample
//
//  Created by Kirill Kunst on 31.12.13.
//  Copyright (c) 2013 Kirill Kunst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKColorsHeaderView;

@protocol KKColorsHeaderViewDelegate <NSObject>

@required
- (void)didClickCloseButton:(KKColorsHeaderView *)view;

@end

@interface KKColorsHeaderView : UICollectionReusableView

@property (nonatomic, strong) id<KKColorsHeaderViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)actionClose:(UIButton *)sender;

@end
