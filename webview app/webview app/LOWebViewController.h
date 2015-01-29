//
//  LOWebViewController.h
//  webview app
//
//  Created by sidan on 2014-08-18.
//  Copyright (c) 2014 Rafael Rodrigues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webContainer;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *webViewIndicator;

@end
