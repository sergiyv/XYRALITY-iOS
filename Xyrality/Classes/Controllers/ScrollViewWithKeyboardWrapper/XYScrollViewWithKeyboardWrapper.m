//
//  XYScrollViewWithKeyboardWrapper.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYScrollViewWithKeyboardWrapper.h"
#import "UIView+FindFirstResponder.h"

@interface XYScrollViewWithKeyboardWrapper()

// XYB
@property (nonatomic, weak) IBOutlet UIScrollView     *scrollView;
@property (nonatomic, weak) IBOutlet UIViewController *controllerWithScroll;

@end

@implementation XYScrollViewWithKeyboardWrapper

- (void)awakeFromNib {
    
    if (self.bottomIndent == 0) {
        
        self.bottomIndent = 10.;
    }
}

- (void)startObserving {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)stopObserving {

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - Private methods

- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGPoint scrollViewBottomPoint =
        [self.controllerWithScroll.view convertPoint:CGPointMake(0, self.scrollView.frame.origin.y +
                                                                    self.scrollView.frame.size.height)
                                            fromView:self.scrollView];
    CGFloat scrollViewBottomDelta =
        self.controllerWithScroll.view.bounds.size.height - scrollViewBottomPoint.y;
    
    const CGRect kKeyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Shrink scrollable part of the scroll view (from the bottom)
    UIEdgeInsets insets = UIEdgeInsetsMake(0.f, 0.f, kKeyboardFrame.size.height - scrollViewBottomDelta, 0.f);
    
    // Scroll the content to the first responder
    CGPoint contentOffset = self.scrollView.contentOffset;
    __block UIView *firstResponder = [self.scrollView findFirstResponder];
    if (firstResponder) {
        
        CGFloat firstResponderY = firstResponder.frame.origin.y;
        
        UIView *view = firstResponder;
        while ((view = view.superview) != self.scrollView) {
            
            firstResponderY += view.frame.origin.y;
        }
        
        CGFloat firstResponderBottomDelta =
            self.scrollView.frame.size.height
        -   (firstResponderY + firstResponder.bounds.size.height);
        
        CGFloat firstResponderTotalBottomDelta =
            scrollViewBottomDelta + firstResponderBottomDelta;
        if (firstResponderTotalBottomDelta - self.bottomIndent < kKeyboardFrame.size.height) {
            
            CGFloat additionalBottomOffset =
                kKeyboardFrame.size.height - (firstResponderTotalBottomDelta - self.bottomIndent);
            contentOffset.y += additionalBottomOffset;
        }
        
        self.scrollView.contentSize = self.scrollView.frame.size;
        
        [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                         animations:^{
                             
                             self.scrollView.contentInset = insets;
                             self.scrollView.scrollIndicatorInsets = insets;
                             self.scrollView.contentOffset = contentOffset;
                         }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.scrollView.contentSize = CGSizeZero;
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.scrollView.contentOffset = CGPointZero;
}

@end
