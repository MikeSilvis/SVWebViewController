//
//  SVModalWebViewController.m
//
//  Created by Oliver Letterer on 13.08.11.
//  Copyright 2011 Home. All rights reserved.
//
//  https://github.com/samvermette/SVWebViewController

#import "SVModalWebViewController.h"
#import "SVWebViewController.h"
#import "FAKFontAwesome.h"

@interface SVModalWebViewController ()

@property (nonatomic, strong) SVWebViewController *webViewController;

@end

@interface SVWebViewController (DoneButton)

- (void)doneButtonTapped:(id)sender;

@end


@implementation SVModalWebViewController

#pragma mark - Initialization

- (UIScrollView *)scrollView {
  return self.webViewController.scrollView;
}

- (instancetype)initWithAddress:(NSString*)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL *)URL {
    return [self initWithURLRequest:[NSURLRequest requestWithURL:URL]];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)request {
    self.webViewController = [[SVWebViewController alloc] initWithURLRequest:request];
    if (self = [super initWithRootViewController:self.webViewController]) {
        self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                           style:UIBarButtonItemStylePlain
                                                          target:self.webViewController
                                                          action:@selector(doneButtonTapped:)];

        CGFloat iconSize = 25;
        UIColor *iconColor = [UIColor whiteColor];
        FAKFontAwesome *closeIcon = [FAKFontAwesome timesIconWithSize:iconSize];
        [closeIcon addAttribute:NSForegroundColorAttributeName value:iconColor];
        [self.doneButton setImage:[closeIcon imageWithSize:CGSizeMake(iconSize, iconSize)]];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            self.webViewController.navigationItem.leftBarButtonItem = self.doneButton;
        else
            self.webViewController.navigationItem.rightBarButtonItem = self.doneButton;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];

    self.webViewController.title = self.title;
    self.navigationBar.tintColor = self.barsTintColor;
}

@end
