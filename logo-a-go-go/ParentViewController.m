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
activeStampImage, stampImages, sceneImage,              // Stamp Images
sceneCaptureController, afPhotoEditorController;

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
    //self.sceneCaptureController.delegate = self;
    NSLog(@"Loading Modal...");
    @try {
        [self captureImage];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception reason: %@ description: %@", exception.reason, exception.description);
    }
    // [self presentModalViewController:sceneCaptureController animated:YES];
    NSLog(@"Loading Modal... done");
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
#pragma mark - Camera Modal Methods
-(void)captureImage
{
    NSLog(@"capture image.");
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc] init];
    NSLog(@"UI ImpagePicker Controller..");
//    imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate = self;
    imagePickController.allowsEditing = NO;
    imagePickController.showsCameraControls = YES;
    NSLog(@"Time to present the Modal");
    [self presentModalViewController:imagePickController animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = self.sceneImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    AFPhotoEditorController *photoEditor = [[AFPhotoEditorController alloc] initWithImage:image];
    photoEditor.delegate = self;
    [self presentModalViewController:photoEditor animated:TRUE];
//    NSArray sessions = [[NSArray alloc] init];
//    // Capture the user's session and store it in an array
//    __block AFPhotoEditorSession *session = [photoEditor session];
//    [[self sessions] addObject:session];
//    
//    // Create a context with the maximum output resolution
//    AFPhotoEditorContext *context = [session createContext];
//    
//    [context renderInputImage:image completion:^(UIImage *result) {
//        // `result` will be nil if the session is canceled, or non-nil if the session was closed successfully and rendering completed
//        [[self sessions] removeObject:session];
//    }];
//                               
//                               
//    [self dismissModalViewControllerAnimated:YES];
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

- (void)setupHorizontalScrollView
{
//    self.stampScrollView.delegate = self;
    
    //[self.stampScrollView setBackgroundColor:[UIColor blackColor]];
    [stampScrollView setCanCancelContentTouches:NO];
    
    stampScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    stampScrollView.clipsToBounds = NO;
    stampScrollView.scrollEnabled = YES;
    stampScrollView.scrollsToTop = NO;
//    stampScrollView.pagingEnabled = YES;
    
    
//    // Find the files
//    NSFileManager *filemgr;
//    NSString *currentPath;
//    NSArray *filelist;
//    int count;
//    int i;
//    
//    [[NSBundle mainBundle] pathForResource:@"/" ofType:@"png" inDirectory:@"assets/"];
//    
//    // Make sure it's an image
//    NSString *file = @"…"; // path to some file
//    CFStringRef fileExtension = (CFStringRef) [file pathExtension];
//    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
//    
//    if (UTTypeConformsTo(fileUTI, kUTTypeImage)) NSLog(@"This is an image");
//    
//    CFRelease(fileUTI);
//    
//    filemgr =[NSFileManager defaultManager];
//    currentPath = [filemgr currentDirectoryPath];
//    
//    NSString *path = [[NSString alloc] initWithString:@"%d/assets", currentPath];
//    
//    filelist = [filemgr contentsOfDirectoryAtPath:@"/" error:NULL];
//    count = [filelist count];
//    
//    for (i = 0; i < count; i++)
//        NSLog(@"%@", [filelist objectAtIndex: i]);
//    
//    
//    /////////////////////////////// threaded solution just need a file name and iterate
//    
//    // get a data provider referencing the relevant file
//    CGDataProviderRef dataProvider = CGDataProviderCreateWithFilename(filename);
//    
//    // use the data provider to get a CGImage; release the data provider
//    CGImageRef image = CGImageCreateWithPNGDataProvider(dataProvider, NULL, NO, 
//                                                        kCGRenderingIntentDefault);
//    CGDataProviderRelease(dataProvider);
//    
//    // make a bitmap context of a suitable size to draw to, forcing decode
//    size_t width = CGImageGetWidth(image);
//    size_t height = CGImageGetHeight(image);
//    unsigned char *imageBuffer = (unsigned char *)malloc(width*height*4);
//    
//    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
//    
//    CGContextRef imageContext =
//    CGBitmapContextCreate(imageBuffer, width, height, 8, width*4, colourSpace,
//                          kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
//    
//    CGColorSpaceRelease(colourSpace);
//    
//    // draw the image to the context, release it
//    CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), image);
//    CGImageRelease(image);
//    
//    // now get an image ref from the context
//    CGImageRef outputImage = CGBitmapContextCreateImage(imageContext);
//    
//    // post that off to the main thread, where you might do something like
//    // [UIImage imageWithCGImage:outputImage]
//    [self performSelectorOnMainThread:@selector(haveThisImage:) 
//                           withObject:[NSValue valueWithPointer:outputImage] waitUntilDone:YES];
//    
//    // clean up
//    CGImageRelease(outputImage);
//    CGContextRelease(imageContext);
//    free(imageBuffer);
    
    ///////////////////////////// simple solution for getting images loaded
    
    NSUInteger nimages = 0;
    NSInteger tot=0;
    CGFloat cx = 0;
    for (; ; nimages++) {
        NSString *imageName = [NSString stringWithFormat:@"image%d.png", nimages];
        UIImage *image = [UIImage imageNamed:imageName];
        if (tot==15) {
            break;
        }
        if (4==nimages) {
            nimages=0;
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGRect rect = imageView.frame;
        rect.size.height = 40;
        rect.size.width = 40;
        rect.origin.x = cx;
        rect.origin.y = 0;
        
        imageView.frame = rect;
        
        [stampScrollView addSubview:imageView];
        
        cx += imageView.frame.size.width+5;
        tot++;
    }
    
    [stampScrollView setContentSize:CGSizeMake(cx, [stampScrollView bounds].size.height)];
}

#pragma mark -
#pragma mark - AFPhotoEditorControllerDelegate

- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    self.unfolded = FALSE;
    [self.view addGestureRecognizer:self.swipeLeftRecognizer];
    // Handle the result image here
    self.afPhotoEditorController = editor;
    // Make the overly menu visible
    [self.stampMenu setHidden:FALSE];
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
    
//    [self initWithImage:image];
    
    // Cache some logos in the stampScrollView
    [self setupHorizontalScrollView];
}

- (void)imageCaptureFailed
{
    // reload modal view
    [self presentModalViewController:sceneCaptureController animated:YES];
}

#pragma mark -
#pragma mark - ShareDelegate Methods

- (void)shareImage:(UIImage *) image
{
    UIImage *image2 = self.activeStampImage;
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    [image2 drawInRect:CGRectMake(10,10,image2.size.width,image2.size.height)
             blendMode:kCGBlendModeNormal alpha:1.0];
    UIImage *compositeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    [NSNotificationCenter
    // Open Share modal
    //    UIViewController *shareViewController; // TEMP
    //    [self presentModalViewController:shareViewController animated:YES];
}

@end
