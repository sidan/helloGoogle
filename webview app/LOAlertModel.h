//
//  LOAlertModel.h
//  webview app
//
//  Created by sidan on 2014-08-19.
//  Copyright (c) 2014 Rafael Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface LOAlertModel : NSObject

- (void) alertStatus:(NSString *)msg :(NSString *)title;
- (BOOL) verifyConnection;

@end
