//
//  AccountViewController.m
//  ForceDemoApp
//
//  Created by Robert Dietrick on 2/6/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import "AccountViewController.h"
#import "SFRestAPI.h"

@interface AccountViewController ()
@end

@implementation AccountViewController


@synthesize acctName;
@synthesize acctRevenue;
@synthesize acctPhone;
@synthesize acctWebsite;
@synthesize acctId;
@synthesize phoneField;

- (id) initWithName:(NSString *)name
          sobjectId:(NSString *)sobjectId
              revenue:(NSNumber *)revenue
              phone:(NSString *)phone
            website:(NSString *)website {
    self = [super init];
    if (self) {
        self.acctName = name;
        self.acctId = sobjectId;
        self.acctRevenue = revenue;
        self.acctPhone = phone;
        self.acctWebsite = website;
    }
    return self;
}

- (IBAction)updateTouchUpInside:(id)sender {
    NSLog(@"Setting name=%@, phone number = %@", nameField.text, phoneField.text);
    [self updateWithObjectType:@"Account" objectId:self.acctId name:nameField.text revenue:[NSNumber numberWithFloat:[revenueField.text floatValue]] phone:phoneField.text website:websiteField.text];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Account Details";
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [nameField setText:self.acctName];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    [revenueField setText:[numberFormatter stringFromNumber:self.acctRevenue]];
    
    [phoneField setText:self.acctPhone];
    [websiteField setText:self.acctWebsite];
}

- (void)updateWithObjectType:(NSString *)objectType
                    objectId:(NSString *)objectId
                        name:(NSString *)name
                     revenue:(NSNumber *)revenue
                       phone:(NSString *)phone
                     website:(NSString *)website {
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            name, @"Name",
                            revenue, @"AnnualRevenue",
                            phone, @"Phone",
                            website, @"Website", nil];
    SFRestRequest *req = [[SFRestAPI sharedInstance] requestForUpdateWithObjectType:@"Account" objectId:self.acctId fields:fields];
    [[SFRestAPI sharedInstance] send:req delegate:self];
    
}

-(void) returnToRootController {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)hideKeyboard {
    [nameField resignFirstResponder];
    [revenueField resignFirstResponder];
    [phoneField resignFirstResponder];
    [websiteField resignFirstResponder];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hideKeyboard];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}

#pragma mark - SFRestAPIDelegate
- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    NSLog(@"1 record updated");
    [self performSelectorOnMainThread:@selector(returnToRootController) withObject:nil waitUntilDone:NO];
}
- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"request:didFailLoadWithError: %@", error);
    //add your failed error handling here
}
- (void)requestDidCancelLoad:(SFRestRequest *)request {
    NSLog(@"requestDidCancelLoad: %@", request);
    //add your failed error handling here
}
- (void)requestDidTimeout:(SFRestRequest *)request {
    NSLog(@"requestDidTimeout: %@", request);
    //add your failed error handling here
}


@end
