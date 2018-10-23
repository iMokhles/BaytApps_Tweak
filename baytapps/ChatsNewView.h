//
//  ViewController.h
//  MultiSelectTable
//
//  Created by Ray Tam on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static UIViewController *mainViewController() {
    UIWindow *mainImoWindow = [[UIApplication sharedApplication] windows][0];
    UIViewController *selfRootViewController = mainImoWindow.rootViewController;
    return selfRootViewController;
}

@interface ChatsNewView : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
}

@end
