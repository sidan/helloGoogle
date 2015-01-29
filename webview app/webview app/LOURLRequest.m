//
//  URLRequest.m
//  webview app
//
//  Created by sidan on 2013-08-06.
//  Copyright (c) 2013 Rafael Rodrigues. All rights reserved.
//

#import "LOURLRequest.h"
#import "LOURLRequestDelegate.h"

@implementation LOURLRequest

@synthesize delegate;

+ (NSDictionary *) parserJSON: (NSData *) data{
    if (!data || [data length] == 0) {
        NSLog(@"No data found");
        return nil;
    }
    NSDictionary *arrayParseFromDataResponse = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: nil];
    return arrayParseFromDataResponse;
}

- (void) doGet:(NSString *)url {
    //create the NSMutableData to receive the return
    httpReturn = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - http

//data received from Server
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [httpReturn setLength:0];
}

//data received, so let's add it to NSData
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [httpReturn appendData:data];
}

//error occured
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (delegate) {
        //tells the delegate it end up into an error
        [delegate requestEndWithError:error];
    }
}

//request finished
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    if (delegate) {
        //tells the delegate it end up into a data response
        [delegate requestEndWithData:httpReturn];
    }
}

@end
