#include <hx/CFFI.h>
#import "../include/iOSNative.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IOSNativeCb : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
@end

 @implementation IOSNativeCb
     - (void)imagePickerController:(UIImagePickerController *)picker 
                      didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [picker dismissViewControllerAnimated:YES completion:^{[self dismissViewControllerAnimated:YES completion:nil];}];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
    [window makeKeyAndVisible];
     NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage],1.0);
   UIImage *tmpImage = [UIImage imageWithData:imageData];
   NSString* path = [NSSearchPathForDirectoriesInDomains(
                    NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingString:@"/tmp/tmpFile.jpg"];              
   [imageData writeToFile:path atomically:YES];
        NSString* imgOrientation = @"0";
   switch (tmpImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            imgOrientation = [imgOrientation stringByAppendingString:@"180"];
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            imgOrientation = [imgOrientation stringByAppendingString:@"90"];
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            imgOrientation = [imgOrientation stringByAppendingString:@"-90"];
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    path = [path stringByAppendingString:@";"];
    path = [path stringByAppendingString:imgOrientation];
   const char *cfilename=[path UTF8String];
   iosnative::call_callback(cfilename);
      }
     - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [picker dismissViewControllerAnimated:YES completion:^{[self dismissViewControllerAnimated:YES completion:nil];}];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
    [window makeKeyAndVisible];
    

    }
     @end
     
 @interface IOSNativeCb2 : UIPopoverController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

//@property (nonatomic) UIPopoverController popover;
@end

 @implementation IOSNativeCb2
     - (void)imagePickerController:(UIImagePickerController *)picker 
                      didFinishPickingMediaWithInfo:(NSDictionary *)info {

   [picker dismissModalViewControllerAnimated:YES];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self dismissPopoverAnimated:YES];
    [window makeKeyAndVisible];
     NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage],1.0);
   UIImage *tmpImage = [UIImage imageWithData:imageData];
   NSString* path = [NSSearchPathForDirectoriesInDomains(
                    NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingString:@"/tmp/tmpFile.jpg"];              
   [imageData writeToFile:path atomically:YES];
         NSString* imgOrientation = @"0";
   switch (tmpImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            imgOrientation = [imgOrientation stringByAppendingString:@"180"];
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            imgOrientation = [imgOrientation stringByAppendingString:@"90"];
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            imgOrientation = [imgOrientation stringByAppendingString:@"-90"];
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    path = [path stringByAppendingString:@";"];
    path = [path stringByAppendingString:imgOrientation];
   const char *cfilename=[path UTF8String];
   iosnative::call_callback(cfilename);
      }
     - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [picker dismissViewControllerAnimated:YES completion:^{[self dismissPopoverAnimated:YES];}];
    [window makeKeyAndVisible];
    

    }
     @end    
     
     @interface IOSNativeCamera : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
@end

 @implementation IOSNativeCamera
     - (void)imagePickerController:(UIImagePickerController *)picker 
                      didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [picker dismissViewControllerAnimated:YES completion:^{[self dismissViewControllerAnimated:YES completion:nil];}];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
    [window makeKeyAndVisible];
   NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage],1.0);
   UIImage *tmpImage = [UIImage imageWithData:imageData];
   NSString* path = [NSSearchPathForDirectoriesInDomains(
                    NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingString:@"/tmp/tmpFile.jpg"];              
   [imageData writeToFile:path atomically:YES];
         NSString* imgOrientation = @"0";
   switch (tmpImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            imgOrientation = [imgOrientation stringByAppendingString:@"180"];
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            imgOrientation = [imgOrientation stringByAppendingString:@"90"];
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            imgOrientation = [imgOrientation stringByAppendingString:@"-90"];
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    path = [path stringByAppendingString:@";"];
    path = [path stringByAppendingString:imgOrientation];
   const char *cfilename=[path UTF8String];
   iosnative::call_callback(cfilename);
      }
     - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [picker dismissViewControllerAnimated:YES completion:^{[self dismissViewControllerAnimated:YES completion:nil];}];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
    [window makeKeyAndVisible];
    

    }
     @end

namespace iosnative 
{ // Start namespace iosNative.
	
	value *function_callback = NULL;
	
	const void call_callback(const char* strdir){
	val_call1(*function_callback,alloc_string(strdir));
	     //iosnative::iOSNative_make_callback(strdir);
	    //
	}
	
	
	const char* getAppDir () 
	{ 
	NSString* path = [NSSearchPathForDirectoriesInDomains(
                    NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        const char *cfilename=[path UTF8String];           
                    return cfilename;
     }
     
      const void initAppCamera(value f){
      val_check_function(f,1);
    function_callback = alloc_root();
    *function_callback = f;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    IOSNativeCamera *wn = [[IOSNativeCamera alloc] init];
    [window addSubview: wn.view];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;    
    picker.delegate = wn;
    [wn presentModalViewController:picker animated:YES];
    [picker release];
     }
     const void initAppGallery(value f){
     val_check_function(f,1);
    function_callback = alloc_root();
    *function_callback = f;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if([[UIDevice currentDevice].model isEqual:@"iPad"]){
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    IOSNativeCb2 *wn = [[IOSNativeCb2 alloc] initWithContentViewController:picker];
    picker.delegate = wn;
    [wn presentPopoverFromRect:CGRectMake(0.0,0.0,400.0,400.0) inView:window permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [picker release];
    [window makeKeyAndVisible];
    }else{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; 
    IOSNativeCb *wn = [[IOSNativeCb alloc] init];
    picker.delegate = wn;
    [window addSubview: wn.view];
    [wn presentModalViewController:picker animated:YES];
    [picker release];
    }  
    
    
     }
     
     const bool checkAppDirectory(){
    NSString* path = [NSSearchPathForDirectoriesInDomains(
                    NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingString:@"/"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[path stringByAppendingString:@"tmp"]];
    NSString *filePathAndDirectory;
    NSError *error;
    if (fileExists == TRUE) {
    NSLog(@"already exists folder tmp");
    } else {
    NSLog(@"tmp folder doesn't exist, trying to create it");
    filePathAndDirectory = [path stringByAppendingString:@"tmp"];

    if (![[NSFileManager defaultManager] createDirectoryAtPath:filePathAndDirectory
                                   withIntermediateDirectories:NO
                                                    attributes:nil
                                                         error:&error])
    {
        NSLog(@"Create directory error: %@", error);
    return false;    
    }
    }
     
    return true; 
   
	}
     

} // End namespace ios_Native.


