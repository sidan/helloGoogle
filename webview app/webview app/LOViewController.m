//
//  LOViewController.m
//  webview app
//
//  Created by sidan on 2014-08-18.
//  Copyright (c) 2014 Rafael Rodrigues. All rights reserved.
//

#import "LOViewController.h"
#import "LOAppDelegate.h"
#import "LOWebViewController.h"
#import "LOAlertModel.h"
#import "LOURLRequest.h"

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface LOViewController ()

@end

@implementation LOViewController

@synthesize usernameTextField,passTextField,user,pass,token,indicator,btnLogin;

- (void)viewDidLoad
{
    
    [self customBorder:usernameTextField:passTextField];
    LOAlertModel *alertView = [[LOAlertModel alloc]init];
    
    ((alertView.verifyConnection))?
    ((([self verifyCookies] == 1))?
     ([self httpRequestWithToken]):
     ([super viewDidLoad])):
    ([super viewDidLoad]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - botão login pressionado

- (IBAction)login:(id)sender {
    
    //get data typed
    user = [usernameTextField text];
    pass = [passTextField text];
    
/*
 * COMMENTED FOR TESTING ONLY
 *
    LOAlertModel *alertView = [[LOAlertModel alloc]init];
    
    if ([usernameTextField.text isEqualToString:@"" ] ||
        [passTextField.text isEqualToString:@""]) {
        
        [self emptyFields];
        
    } else if (alertView.verifyConnection){
        
        [self httpRequestWithCredentials];
        
    }
*/
    if ([user isEqualToString:@"sidan"] &&
        [pass isEqualToString:@"nadis"]) {
        [self loadMainView];
    } else {
        [self invalidData];
    }
    
}

#pragma mark - instancia a view principal

- (void) loadMainView {
    
    if (IPAD)
    {
        // The device is an iPad running iOS 3.2 or later.
        UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil] instantiateViewControllerWithIdentifier:@"MainScreen"];
        
        [controller setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }else {
        
        UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"MainScreen"];
        
        [controller setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

#pragma mark - HTTPRequest WITH token and WITHOUT token

//performs login with data typed
- (void) httpRequestWithCredentials {
    
    //treat UI
    [self loading];
    [self disableUI];
    
    //compose request
    LOURLRequest *request = [[LOURLRequest alloc]init];
    NSString * url = [NSString stringWithFormat:@"https://www.URLGOESHERE.com/api/v1/auth_user.json"];
    
    //trigger request to the delegate method
    [request setDelegate:self];
    [request doGet:url];
    
}

//performs login with saved token after first login
- (void) httpRequestWithToken {
    
    //treat UI
    [self loading];
    [self disableUI];
    
    //compose request
    LOURLRequest *request = [[LOURLRequest alloc]init];
    NSString * url = [NSString stringWithFormat:@"https://www.URLGOESHERE.com=%@",token];
    
    //trigger request to the delegate method
    [request setDelegate:self];
    [request doGet:url];
    
}

#pragma mark - URLRequestDelegate

- (void) requestEndWithData:(NSData *)data {
    //stop animation
    [indicator stopAnimating];
    
    //parser data
    if (data && [data length] > 0) {
        _dataReceivedFromRequest = [LOURLRequest parserJSON:data];
    }
    
    //if data is ok
    if (_dataReceivedFromRequest && [_dataReceivedFromRequest count] > 0) {
        _requestResponse = [_dataReceivedFromRequest objectForKey:@"RESULT"];
        if ([_requestResponse isEqualToString:@"OK"]){
            [self loadMainView];
        }else{
            [self invalidData];
        }
    }
}

- (void) requestEndWithError:(NSError *)error {
    NSLog(@"Request error: %@", [error description]);
    LOAlertModel *alert = [[LOAlertModel alloc]init];
    [alert alertStatus:@"Please try again later." :@"Server temporarily unavailable."];
    [indicator stopAnimating];
}

#pragma mark - tratamentos de UI: validação de campos e mensagens de alerta

-(void) invalidData {
    
    LOAlertModel *alertView = [[LOAlertModel alloc]init];
    [alertView alertStatus:@"Try again" :@"Email/Pass Invalid"];
}

-(void) emptyFields {
    
    LOAlertModel *alertView = [[LOAlertModel alloc]init];
    [alertView alertStatus:@"Both fields required" :@"Invalid Data"];
    
}

- (void) msgErro {
    
    LOAlertModel *alertView = [[LOAlertModel alloc]init];
    [alertView alertStatus:@"Try again" :@"Please,"];
    
}

- (IBAction)backgroundTap:(id)sender {
    
    [usernameTextField resignFirstResponder];
    [passTextField resignFirstResponder];
    
}

- (void) loading {
    
    indicator.hidden = NO;
    [indicator startAnimating];
    
}

-(void) disableUI {
    
    usernameTextField.userInteractionEnabled = NO;
    passTextField.userInteractionEnabled = NO;
    btnLogin.userInteractionEnabled = NO;
    
}

-(void) enableUI {
    
    usernameTextField.userInteractionEnabled = YES;
    passTextField.userInteractionEnabled = YES;
    btnLogin.userInteractionEnabled = YES;
    
}

-(void) customBorder: (UITextField *) username : (UITextField *)password{
    
    for (int i=1; i<=2; i++) {
        UITextField *myTextField = (UITextField *)[self.view viewWithTag:i];
        myTextField.borderStyle = UITextBorderStyleLine;
        myTextField.layer.borderWidth = 1;
        myTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 10)];
        [myTextField setLeftViewMode:UITextFieldViewModeAlways];
        [myTextField setLeftView:spacerView];
    }
    
}

#pragma mark - creating and verifying cookies using NSUserDefaults

//save cookies on device
- (void) saveCookies {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"token"];
    [defaults synchronize];
    
}

//verifica se existe token salvo no dispositivo
- (int) verifyCookies {
    
    int tok;
    //ao abrir o aplicativo, verifica se existe token salvo no objeto NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    token = [defaults stringForKey:@"token"];
    NSLog(@"Token on load: %@",token);
    
    (token == nil)?(tok=0):(tok=1);
    
    return tok;
}


@end
