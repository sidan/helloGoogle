//
//  LOWebViewController.m
//  webview app
//
//  Created by sidan on 2014-08-18.
//  Copyright (c) 2014 Rafael Rodrigues. All rights reserved.
//

#import "LOWebViewController.h"
#import "LOViewController.h"
#import "LOAlertModel.h"
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface LOWebViewController ()

@end

@implementation LOWebViewController

@synthesize webContainer,webViewIndicator;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    webContainer.scrollView.bounces = NO;
    NSURL *theOracle = [NSURL URLWithString:@"https://www.google.com"];
    [self.webContainer loadRequest:[NSURLRequest requestWithURL:theOracle]];
    [self.webContainer setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
