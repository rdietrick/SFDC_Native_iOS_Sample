//
//  AccountViewController.h
//  ForceDemoApp
//
//  Created by Robert Dietrick on 2/6/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"


@interface AccountViewController : UIViewController <SFRestDelegate> {
    
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *revenueField;
    __weak IBOutlet UITextField *phoneField;
    __weak IBOutlet UITextField *websiteField;
}

@property (nonatomic, strong) NSString *acctName;
@property (nonatomic, strong) NSNumber *acctRevenue;
@property (nonatomic, strong) NSString *acctPhone;
@property (nonatomic, strong) NSString *acctWebsite;
@property (nonatomic, strong) NSString *acctId;

@property (nonatomic, weak) UITextField *phoneField;

- (id) initWithName:(NSString *)name
          sobjectId:(NSString *)sobjectId
            revenue:(NSNumber *)revenue
              phone:(NSString *)phone
            website:(NSString *)website;

- (IBAction)updateTouchUpInside:(id)sender;

- (void)updateWithObjectType:(NSString *)objectType
                    objectId:(NSString *)objectId
                        name:(NSString *)name
                     revenue:(NSNumber *)revenue
                       phone:(NSString *)phone
                     website:(NSString *)website;

-(void)returnToRootController;

- (void)hideKeyboard;

@end
