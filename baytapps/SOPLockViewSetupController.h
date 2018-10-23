#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "PassPadView/KKGestureLockView.h"

@interface UIImage (ChatKitAdditions)
+(id)ckImageNamed:(id)named;
+ (id)ckImageWithData:(id)arg1;
@end

typedef void(^SOPLockViewSetupControllerDelegateBlock)(NSString *passcode);

@interface SOPLockViewSetupController : UIViewController <KKGestureLockViewDelegate>
@property (nonatomic, strong) KKGestureLockView *lockView;
@property (copy, nonatomic, nullable) SOPLockViewSetupControllerDelegateBlock passCodeBlock;
@end
