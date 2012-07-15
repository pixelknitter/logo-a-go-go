//
//  ParentViewController.h
//  logo-a-go-go
//
//  Created by Eddie Freeman on 7/14/12.
//  Copyright (c) 2012 NinjaSudo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFPhotoEditorController.h"
#import "SceneCaptureViewController.h"

@interface ParentViewController : AFPhotoEditorController <UIGestureRecognizerDelegate,
                                                            SceneCaptureDelegate>

@property (nonatomic, strong) SceneCaptureViewController *sceneCaptureController;

@property (nonatomic, strong) IBOutlet UIView *stampMenu;
@property (nonatomic, strong) IBOutlet UIScrollView *stampScrollView;
@property (nonatomic, weak) IBOutlet UIImageView *stampArrow;
@property (nonatomic, weak) UIImage *activeStampImage;
@property (nonatomic, strong) NSMutableArray *stampImages;
@property (nonatomic) BOOL unfolded;

#pragma mark -
#pragma mark - Gesture Delegate
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *swipeLeftRecognizer;

- (IBAction)handleTapFrom:(UITapGestureRecognizer *)recognizer;
- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
- (IBAction)handleRotationFrom:(UIRotationGestureRecognizer *)recognizer;

#pragma mark -
#pragma mark - Overlay Menu
- (void)unfoldMenuWithAnimationDuration:(float)duration;
- (void)foldMenuWithAnimationDuration:(float)duration;

@end
