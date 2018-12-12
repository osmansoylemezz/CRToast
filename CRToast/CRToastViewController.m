//
//  CRToast
//  Copyright (c) 2014-2015 Collin Ruffenach. All rights reserved.
//

#import "CRToastViewController.h"
#import "CRToast.h"
#import "CRToastLayoutHelpers.h"

#pragma mark - CRToastContainerView
@interface CRToastContainerView : UIView
@end

@implementation CRToastContainerView
@end

#pragma mark - CRToastViewController

@implementation CRToastViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _autorotate = YES;
    }
    return self;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark UIViewController

- (BOOL)shouldAutorotate {
    return _autorotate;
}

- (BOOL)prefersStatusBarHidden {
    return [UIApplication sharedApplication].statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

- (void)loadView {
    self.view = [[CRToastContainerView alloc] init];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        // what ever you want to prepare
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self handleInterfaceOrientation];
    }];
}

- (void)handleInterfaceOrientation {
    if (self.toastView) {
        CGSize notificationSize = CRNotificationViewSizeForOrientation(self.notification.notificationType, self.notification.preferredHeight, [[UIApplication sharedApplication] statusBarOrientation]);
        self.toastView.frame = CGRectMake(0, 0, notificationSize.width, notificationSize.height);
    }
}

@end
