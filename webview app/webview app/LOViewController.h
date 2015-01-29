//
//  LOViewController.h
//  webview app
//
//  Created by sidan on 2014-08-18.
//  Copyright (c) 2014 Rafael Rodrigues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LOAppDelegate.h"
#import "LOURLRequestDelegate.h"

@interface LOViewController : UIViewController <URLRequestDelegate> {
    
    id conferenceDelegate;
    
}

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passTextField;
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *pass;
@property (strong, nonatomic) NSString *token;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) NSString *requestResponse;
@property (nonatomic,strong) NSDictionary *dataReceivedFromRequest;

- (IBAction)login:(id)sender;
- (void) saveCookies;

@end
