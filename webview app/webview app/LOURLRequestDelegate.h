//
//  URLRequestDelegate.h
//  webview app
//
//  Created by sidan on 2015-01-17.
//  Copyright (c) 2015 Rafael Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URLRequestDelegate <NSObject>
@required

//request finish with success
- (void) requestEndWithData:(NSData *) data;

//request finish with error
- (void) requestEndWithError:(NSError *) error;

@end