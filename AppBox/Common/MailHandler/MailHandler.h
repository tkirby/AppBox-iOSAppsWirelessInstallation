//
//  MailHandler.h
//  AppBox
//
//  Created by Vineet Choudhary on 30/12/16.
//  Copyright © 2016 Developer Insider. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MailHandler : NSObject

+ (BOOL) isValidEmail:(NSString *)checkString;

@end
