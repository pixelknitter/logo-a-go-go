//
//  ParentViewController.m
//  logo-a-go-go
//
//  Created by Eddie Freeman on 7/14/12.
//  Copyright (c) 2012 NinjaSudo Inc. All rights reserved.
//

#import "ParentViewController.h"

@implementation ParentViewController

@synthesize stampMenu, stampArrow, stampScrollView,     // Stamp Menu
unfolded, tapRecognizer, swipeLeftRecognizer,           // Gesture Recognition
activeStampImage, stampImages,                          // Stamp Images
sceneCaptureController, delegate;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Present the modal for scene capture
    self.sceneCaptureController.delegate = self;
    NSLog(@"Loading Modal...");
    [self presentModalViewController:sceneCaptureController animated:YES];
    
    self.unfolded = FALSE;
    [self.view addGestureRecognizer:self.swipeLeftRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.stampScrollView = nil;
    self.stampMenu = nil;
    self.tapRecognizer = nil;
	self.swipeLeftRecognizer = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(IBAction) crashPressed:(id) sender {
    [NSException raise:NSInvalidArgumentException
                format:@"Foo must not be nil"];
}

#pragma mark -
#pragma mark - Overlay Stamp Menu

-(IBAction) stampSelectorPressed:(id) sender {
    // TODO animate selector view to screen screen width.
    // Adjust the view and scroll view to the size of the screen real estate.
}

/*
 In response to a tap gesture, show the image view appropriately then make it fade out in place.
 */
- (IBAction)handleTapFrom:(UITapGestureRecognizer *)recognizer {
	
//	CGPoint location = [recognizer locationInView:self.view];
//	[self showImageWithText:@"tap" atPoint:location];
}

/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
 */
- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Handling Gesture");
	CGPoint location = [recognizer locationInView:self.stampArrow];
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft && !unfolded)
    {
        NSLog(@"Left Swipe");
        [self unfoldMenuWithAnimationDuration: 0.75];
    }
    else if (unfolded)
    {
        NSLog(@"Right Swipe");
        [self foldMenuWithAnimationDuration: 0.75];
    }
}

/*
 In response to a rotation gesture, show the image view at the rotation given by the recognizer, then make it fade out in place while rotating back to horizontal.
 */
- (IBAction)handleRotationFrom:(UIRotationGestureRecognizer *)recognizer {
	
	//CGPoint location = [recognizer locationInView:self.view];
    
//    CGAffineTransform transform = CGAffineTransformMakeRotation([recognizer rotation]);
//    self.imageView.transform = transform;
//	[self showImageWithText:@"rotation" atPoint:location];
}

- (void)unfoldMenuWithAnimationDuration:(float)duration
{
    // Animate with duration
    NSLog(@"We are unfolding menu!");
    // Rotate arrow
    
    [UIView animateWithDuration:duration animations:^{
        NSLog(@"Animated unfolding");
        CGPoint newCenter;
        newCenter.x = (self.stampMenu.center.x)*0.40;
        newCenter.y = self.stampMenu.center.y;
        self.stampMenu.center = newCenter;
        self.unfolded = YES;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            CGPoint newCenter;
            NSLog(@"Animating unfolding");
            newCenter.x = (self.stampMenu.center.x)*0.90;
            newCenter.y = self.stampMenu.center.y;
            self.stampMenu.center = newCenter;
        }];
        // Cache logos     
    }];
}

- (void)foldMenuWithAnimationDuration:(float)duration
{
    NSLog(@"We are folding menu!");
    [UIView animateWithDuration:duration animations:^{
        NSLog(@"We are animating the fold!");
        CGPoint newCenter;
        newCenter.x = (self.stampMenu.center.x + self.view.bounds.size.width)*0.75;
        newCenter.y = self.stampMenu.center.y;
        self.stampMenu.center = newCenter;
        self.unfolded = NO;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            CGPoint newCenter;
            newCenter.x = self.stampMenu.center.x - 30 + self.view.bounds.size.width;
            newCenter.y = self.stampMenu.center.y;
            self.stampMenu.center = newCenter;
        }];
        // Uncache logos
    }];
}

#pragma mark -
#pragma mark - AFPhotoEditorControllerDelegate

- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    // Handle the result image here
    UIImage *image2 = self.activeStampImage;
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    [image2 drawInRect:CGRectMake(10,10,image2.size.width,image2.size.height)
             blendMode:kCGBlendModeNormal alpha:1.0];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Pass new image to shared modal
    UIViewController *shareViewController; // TEMP
    [self presentModalViewController:shareViewController animated:YES];
//    // Get the session
//    AFPhotoEditorSession *session = [editor session];
//    // Instantiate the context
//    AFPhotoEditorContext *context = [session createContextWithSize:CGSizeMake(1500, 1500)];
//    
//    [context renderInputImage:image completion:^(UIImage *result) {
//        // Handle the result image here.
//    }];
    
    // Composite the stamp with the scene image
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    // Handle cancelation here
    // Load sceneCamera/scenePicker modal
    [self presentModalViewController:sceneCaptureController animated:YES];
}

#pragma mark -
#pragma mark - SceneCaptureDelegate Methods

- (void)imageCaptured:(UIImage *)image
{
    [self initWithImage:image];
    // Cache some logos in the stampScrollView
    
}

- (void)imageCaptureFailed
{
    // reload modal view
    [self presentModalViewController:sceneCaptureController animated:YES];
}

@end
