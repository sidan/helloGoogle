//
//  URLRequest.h
//  webview app
//
//  Created by sidan on 2013-08-06.
//  Copyright (c) 2013 Rafael Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LOURLRequestDelegate.h"

@interface LOURLRequest : NSObject <NSURLConnectionDataDelegate> {
    
    NSString *methodName;
    NSString *urlResquest;
    NSData *urlDataResponse;
    NSDictionary *urlResponse;
    NSDictionary *tempDic;
    
    NSMutableData *httpReturn;
    id <URLRequestDelegate> delegate;
    
    NSString *urlToPerformRequest;
}

@property (retain) id delegate;

+ (NSDictionary *) parserJSON: (NSData *) data;
- (void) doGet:(NSString *)url;


@end
