//
//  ViewController.m
//  logo-a-go-go
//
//  Created by Eddie Freeman on 7/14/12.
//  Copyright (c) 2012 NinjaSudo Inc. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize stampMenu, stampArrow, stampScrollView,     // Stamp Menu
unfolded, tapRecognizer, swipeLeftRecognizer,           // Gesture Recognition
activeStampImage, stampImages;                          // Stamp Images

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.unfolded = FALSE;
    [self.view addGestureRecognizer:self.swipeLeftRecognizer];
//    self.stampScrollView
    // Cache some logos in the stampScrollView
    
	// Do any additional setup after loading the view, typically from a nib.
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
        [self unfoldMenuWithAnimationDuration: 0.5];
    }
    else if (unfolded)
    {
        NSLog(@"Right Swipe");
        [self foldMenuWithAnimationDuration: 0.5];
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
        newCenter.x = self.stampMenu.center.x + 30 - self.view.bounds.size.width;
        newCenter.y = self.stampMenu.center.y;
        self.stampMenu.center = newCenter;
//        [UIView animateWithDuration:1.0 animations:^{
//            CGPoint newCenter;
//            NSLog(@"Animating unfolding");
//            newCenter.x = self.stampMenu.center.x - self.view.bounds.size.width/2;
//            newCenter.y = self.stampMenu.center.y;
//            [self.stampMenu setCenter:newCenter];
//        }];
         self.unfolded = YES;
    } completion:^(BOOL finished) {
        // Cache logos
                
    }];
}

- (void)foldMenuWithAnimationDuration:(float)duration
{
    NSLog(@"We are folding menu!");
    [UIView animateWithDuration:duration animations:^{
        NSLog(@"We are animating the fold!");
        CGPoint newCenter;
        newCenter.x = self.stampMenu.center.x - 30 + self.view.bounds.size.width;
        newCenter.y = self.stampMenu.center.y;
        [self.stampMenu setCenter:newCenter];
//        [UIView animateWithDuration:1.0 animations:^{
//            CGPoint newCenter;
//            newCenter.x = self.stampMenu.center.x + self.view.bounds.size.width/2;
//            newCenter.y = self.stampMenu.center.y;
//            [self.stampMenu setCenter:newCenter];
//        }];
        self.unfolded = NO;
    } completion:^(BOOL finished) {
        // Uncache logos
    }];
}

@end
