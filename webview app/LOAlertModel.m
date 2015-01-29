//
//  LOAlertModel.m
//  webview app
//
//  Created by sidan on 2014-08-19.
//  Copyright (c) 2014 Rafael Rodrigues. All rights reserved.
//

#import "LOAlertModel.h"

@implementation LOAlertModel

- (void) alertStatus:(NSString *)msg :(NSString *)title{
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:msg
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil, nil];
    
    [alertView show];
    [alertView setDelegate:nil];
}

-(BOOL) verifyConnection {
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable){
        [self alertStatus:@"Verifique sua conexão 3G/WiFi" :@"Por favor,"];
        return false;
    }
    else
        return true;    
}

@end
