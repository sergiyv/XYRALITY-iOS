//
//  XYLoginViewController.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYLoginViewController.h"
#import "XYScrollViewWithKeyboardWrapper.h"
#import "XYDeviceInfo.h"
#import "XYServerApiManager.h"
#import "UIView+FindFirstResponder.h"
#import "NSString+Trimming.h"
#import <SVProgressHUD/SVProgressHUD.h>

static NSString* const kXYParamLogin      = @"login"     ;
static NSString* const kXYParamPassword   = @"password"  ;
static NSString* const kXYParamDeviceType = @"deviceType";
static NSString* const kXYParamDeviceId   = @"deviceId"  ;

static NSString* const kXYMainViewControllerSegue = @"XYMainViewControllerSegue";

@interface XYLoginViewController ()

//XYB
@property (nonatomic, weak  ) IBOutlet UITextField                     *emailField;
@property (nonatomic, weak  ) IBOutlet UITextField                     *passwordField;
@property (nonatomic, weak  ) IBOutlet UIButton                        *actionButton;
@property (nonatomic, weak  ) IBOutlet XYScrollViewWithKeyboardWrapper *scrollViewWithKeyboardWrapper;

@end

@implementation XYLoginViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    
    DLog(@"%s", __FUNCTION__);
    
    [super viewDidLoad];
    
//    self.emailField.text    = @"test@gmail.com";
//    self.passwordField.text = @"1234567";
    
    [self setupActionButton];
}

- (void)viewDidAppear:(BOOL)animated {
    
    DLog(@"%s", __FUNCTION__);
    
    [super viewDidAppear:animated];
    
    [self.scrollViewWithKeyboardWrapper startObserving];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    DLog(@"%s", __FUNCTION__);
    
    [self.scrollViewWithKeyboardWrapper stopObserving];
    
    [super viewWillDisappear:animated];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)onViewTap:(id)sender {
    
    UIView *firstResponder = [self.view findFirstResponder];
    if (firstResponder) {
        
        [firstResponder resignFirstResponder];
    }
}

- (IBAction)onActionButtonTap:(id)sender {
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading...", @"")];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    [params setObject:[self.emailField.text    trim] forKey:kXYParamLogin     ];
    [params setObject:[self.passwordField.text trim] forKey:kXYParamPassword  ];
    [params setObject:[XYDeviceInfo deviceType     ] forKey:kXYParamDeviceType];
    [params setObject:[XYDeviceInfo deviceId       ] forKey:kXYParamDeviceId  ];
    
    @weakify(self);
    
    [[[XYServerApiManager sharedInstance] apiWorldsWithParams:params] subscribeNext:^(id x) {
        
        DLog(@"%@", x);
        
        [SVProgressHUD dismiss];
        
        @strongify(self);
        
        [self performSegueWithIdentifier:kXYMainViewControllerSegue sender:self];
    } error:^(NSError *error) {
        
        DLog(@"%@", error);
        
        [SVProgressHUD dismiss];
        
        @strongify(self);
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                    message:NSLocalizedString(error.localizedDescription, nil)
                                   delegate:self
                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                          otherButtonTitles:nil
          ] show
         ];
    }];
}

#pragma mark - Bindings

- (void)setupActionButton {
    
    self.actionButton.exclusiveTouch = YES;
    
    NSArray *textFieldSignals = @[self.emailField.rac_textSignal, self.passwordField.rac_textSignal];
    
    // Observe filling data fields
    RAC(self.actionButton, enabled) =
        [RACSignal combineLatest:textFieldSignals
                          reduce: ^id (NSString *email, NSString *password) {
                            
                              return @([self canPerformActionWithEmail:email password:password]);
                          }
         ];
}

- (BOOL)canPerformActionWithEmail:(NSString *)email password:(NSString *)password {
    
    return [email trim].length > 0 && [password trim].length > 0;
}

@end
