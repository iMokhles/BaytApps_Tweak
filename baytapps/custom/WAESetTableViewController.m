//
//  WAESetTableViewController.m

#import "WAESetTableViewController.h"
#import "FontSizeOptionsTableViewController.h"
#import "FontStyleOptionsTableViewController.h"
#import "../ColorPicker/KKColorListPicker.h"
#import "../Bohr/BOSetting.h"
//#import "../WAEnhancer9Helper.h"
#import "../ColorPicker/UIColor+CustomColors.h"
#import "TransNSString.h"
#import "WAESavedUsersViewController.h"

// WAThemeFontSizeDidChange
// WAThemeTintColorDidChange

@interface WAESetTableViewController ()

@end
@implementation WAESetTableViewController

- (void)setup {
	
	self.title = @"إضافات واتس اب";
    
    NSString *mediaFilesString = [NSString translateToAR:@"إرسال وسائط كا ملفات" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"Send Media As Files" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
    
    NSString *lastSeenString = [NSString translateToAR:@"إخفاء الظهور" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"Enable Hide Lastseen" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
    
    NSString *readMarkString = [NSString translateToAR:@"إخفاء تقرير القراءة" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"Enable Hide Read Mark" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil];
    
    [self addHeaderWithTitle:@"WAE9" andSubtitle:@""];
	
    
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"" handler:^(BOTableViewSection *section) {
        [section addCell:[BOSwitchTableViewCell cellWithTitle:[NSString translateToAR:@"تفعيل الاعدادات المتقدمة" toCA:nil toCS:nil toDA:nil toDE:nil toEL:nil toEN:@"Enable Advanced Options" toEN_AU:nil toEN_GB:nil toES:nil toES_MX:nil toFI:nil toFR:nil toFR_CA:nil toHE:nil toHI:nil toHR:nil toHU:nil toID:nil toIT:nil toJA:nil toKO:nil toMS:nil toNL:nil toNO:nil toPL:nil toPT:nil toPT_PT:nil toRO:nil toRU:nil toSK:nil toSV:nil toTH:nil toTR:nil toUK:nil toVI:nil toZH_CN:nil toZH_HK:nil toZH_TW:nil] key:@"advanced_options_bool" handler:nil]];
//
        [section addCell:[BOSwitchTableViewCell cellWithTitle:mediaFilesString key:@"mediaFiles_enabled" handler:^(BOChoiceTableViewCell * cell) {
            cell.visibilityKey = @"advanced_options_bool";
            cell.visibilityBlock = ^BOOL(id settingValue) {
                return [settingValue boolValue];
            };
        }]];
        
        [section addCell:[BOSwitchTableViewCell cellWithTitle:lastSeenString key:@"lastseen_enabled" handler:^(BOChoiceTableViewCell * cell) {
            cell.visibilityKey = @"advanced_options_bool";
            cell.visibilityBlock = ^BOOL(id settingValue) {
                return [settingValue boolValue];
            };
        }]];
        //
        [section addCell:[BOSwitchTableViewCell cellWithTitle:readMarkString key:@"readmark_enabled" handler:^(BOChoiceTableViewCell * cell) {
            cell.visibilityKey = @"advanced_options_bool";
            cell.visibilityBlock = ^BOOL(id settingValue) {
                return [settingValue boolValue];
            };
        }]];
        
    }]];
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		[alertController dismissViewControllerAnimated:YES completion:nil];
	}]];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)showInputErrorAlert:(BOTextFieldInputError)error {
	NSString *message;
	
	switch (error) {
		case BOTextFieldInputTooShortError:
			message = @"The text is too short";
			break;
			
		case BOTextFieldInputNotNumericError:
			message = @"Please input a valid number";
			break;
		
		default:
			break;
	}
	
	if (message) {
		[self presentAlertControllerWithTitle:@"Error" message:message];
	}
}

- (void)showTappedButtonAlert {
	[self presentAlertControllerWithTitle:@"Button tapped!" message:nil];
}

@end
