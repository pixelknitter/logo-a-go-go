//
//  SceneCaptureViewController.h
//  testpic
//
//  Created by Vijay Selvaraj on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SceneCaptureDelegate
- (void)imageCaptured:(UIImage *)image;
- (void)imageCaptureFailed;
@end

@interface SceneCaptureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIViewController *delegate;
}

@property(nonatomic,retain)IBOutlet UIImageView *imageView;

@property(nonatomic, retain) UIViewController *delegate;

-(IBAction)showCameraAction:(id)sender;


@end
