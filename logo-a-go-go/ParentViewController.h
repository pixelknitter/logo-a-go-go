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
#import "PuttyView.h"
#import "Facebook.h"

@interface ParentViewController : UIViewController <UIGestureRecognizerDelegate,
                                                            SceneCaptureDelegate,
                                                            AFPhotoEditorControllerDelegate,
                                                            UIImagePickerControllerDelegate,
                                                            UINavigationControllerDelegate,
                                                            FBSessionDelegate,
                                                            FBRequestDelegate> 

@property (nonatomic, retain) Facebook *facebook;

@property (nonatomic, weak) AFPhotoEditorController *afPhotoEditorController;

@property (nonatomic, strong) IBOutlet UIView *stampMenu;
@property (nonatomic, strong) IBOutlet UIScrollView *stampScrollView;
@property (nonatomic, weak) IBOutlet UIImageView *stampArrow;
@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UIButton *stampButton;
@property (nonatomic, weak) IBOutlet UIButton *shareButton;
@property (nonatomic, weak) UIImage *activeStampImage;
@property (nonatomic, weak) UIImage *sceneImage;
@property (nonatomic, strong) NSMutableArray *stampImages;
@property (nonatomic) BOOL unfolded;
@property (nonatomic, retain) UIImage *compositeImage;

#pragma mark -
#pragma mark - Gesture Delegate
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *swipeRightRecognizer;

- (IBAction)handleTapFrom:(UITapGestureRecognizer *)recognizer;
- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
- (IBAction)handleRotationFrom:(UIRotationGestureRecognizer *)recognizer;

#pragma mark -
#pragma mark - Other Actions
- (IBAction)stampImage:(id)sender;
- (IBAction)shareImage:(id)sender;
- (IBAction)returnToEditor:(id)sender;

#pragma mark -
#pragma mark - Overlay Menu
- (void)unfoldMenuWithAnimationDuration:(float)duration;
- (void)foldMenuWithAnimationDuration:(float)duration;
- (void)setupHorizontalScrollView;

#pragma mark - 
#pragma mark - Support Methods
- (void) captureImage;
- (void) editImage;


@end
