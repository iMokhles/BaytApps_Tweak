//
//  PTPDecoder.h
//  profileToPlist
//
//  Created by iMokhles on 13/05/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTPDecoder : NSObject
+(NSDictionary*) getMobileProvisionbyPath:(NSString *)path;
@end
