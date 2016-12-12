//
//  MailViewController.m
//  AppBox
//
//  Created by Vineet Choudhary on 12/12/16.
//  Copyright © 2016 Developer Insider. All rights reserved.
//

#import "MailViewController.h"

@interface MailViewController ()

@end

@implementation MailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Load Request
    [webView.mainFrame loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - WebFrameLoadDelegate
- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame{
    [buttonReload setEnabled:false];
    [progressIndicator startAnimation:self];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame{
    [buttonReload setEnabled:true];
    [progressIndicator stopAnimation:self];
}

- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame{
    [[AppDelegate appDelegate] addSessionLog:[NSString stringWithFormat:@"URL = %@\nMailView Title = %@",sender.mainFrameURL, title]];
    if (title.length == 0){
        return;
    }
    if ([title isEqualToString:@"AppBox Gmail API"]){
        [self.delegate mailViewLoadedWithWebView:sender];
        
    }else if ([title isEqualToString:@"MailSent"]){
        [self.delegate mailSentWithWebView:sender];
        [self dismissViewController:self];
        
    }else if ([title isEqualToString:@"InvalidPerameter"]){
        [self.delegate invalidPerametersWithWebView:sender];
        [Common showAlertWithTitle:@"AppBox Error" andMessage:@"Invalid Perameter in Email Request!!"];
        
    }else if ([title isEqualToString:@"LoginSuccess"]){
        [self.delegate loginSuccessWithWebView:sender];
        [self dismissController:self];
    }
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame{
    [[AppDelegate appDelegate] addSessionLog:[NSString stringWithFormat:@"Localized Description\n%@ \n\nReason\n%@",error.localizedDescription,error.localizedFailureReason]];
    [Common showAlertWithTitle:@"AppBox Mail Error" andMessage:error.localizedDescription];
}

- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request{
    [[sender mainFrame] loadRequest:request];
    return sender;
}

#pragma mark - Actions
- (IBAction)reloadButtonTapped:(NSButton *)sender {
    [[AppDelegate appDelegate] addSessionLog:@"User Reloaded Current Request!!!"];
    [webView reload:self];
}

- (IBAction)cancelButtonTapped:(NSButton *)sender {
    [[AppDelegate appDelegate] addSessionLog:@"User Canceled Current Request!!!"];
    [webView stopLoading:self];
    [self dismissController:self];
}
@end
