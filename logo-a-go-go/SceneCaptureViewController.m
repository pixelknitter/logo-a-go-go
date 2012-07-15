//
//  SceneCaptureViewController.m
//  testpic
//
//  Created by Vijay Selvaraj on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneCaptureViewController.h"

@interface SceneCaptureViewController ()

@end

@implementation SceneCaptureViewController
@synthesize imageView;

bool imageSelected;
bool cameraPicker;

- (void)viewDidLoad
{
    [super viewDidLoad];    
    imageSelected = false;
    cameraPicker = true;
	// Do any additional setup after loading the view, typically from a nib.    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    if(imageSelected) return;
    
    if(cameraPicker)
    {
        [self loadCamera];    
    } else {
        [self useCameraRoll];
    }
    
}

-(void)loadCamera
{
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
        
    imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate=self;
    imagePickController.allowsEditing=NO;
    imagePickController.showsCameraControls=YES;    
    [self presentModalViewController:imagePickController animated:YES];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //set the position of the button
    button.frame = CGRectMake(300, 450, 320, 480);    
    //set the button's title
    [button setTitle:@"Click Me!" forState:UIControlStateNormal];        
    [button addTarget:self action:@selector(buttonPressed) 
    forControlEvents:UIControlEventTouchUpInside];
    [imagePickController.view addSubview:button];

}




- (void) useCameraRoll
{      
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = 
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        //set the position of the button
        button.frame = CGRectMake(300, 450, 320, 480);    
        //set the button's title
        [button setTitle:@"Click Me!" forState:UIControlStateNormal];        
        [button addTarget:self action:@selector(buttonPressed) 
         forControlEvents:UIControlEventTouchUpInside];
        [imagePicker.view addSubview:button];

    }        
}



-(void)buttonPressed {
    if(cameraPicker==false)
        cameraPicker = true;
    else {
        cameraPicker = false;
    }
    [self dismissModalViewControllerAnimated:YES];
}





-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage=[info objectForKey:UIImagePickerControllerOriginalImage];

    imageView.image=originalImage;
    
    [imageView setImage:originalImage];
    imageSelected = true;
    
    
    [self dismissModalViewControllerAnimated:YES];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

@end
