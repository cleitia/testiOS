//
//  ViewController.m
//  ImgProcApp_v1
//
//  Created by ICTWAY on 2016. 1. 21..
//  Copyright © 2016년 ICTWAY. All rights reserved.
//

#import "ViewController.h"
#import "ImageProcessing.h"
#include "EdgeDetect.hpp"
#include "SIFTbyHess.h"
#include "testFileIO.hpp"

@interface ViewController ()

@end

@implementation ViewController
@synthesize pImageProcInfoViewController;
@synthesize pELCModalViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    pImageProcessing = [[ImageProcessing alloc] init];
    printf("test\n");
    originImage = [UIImage imageNamed:@"cat.jpeg"];
    if (originImage == nil)
        NSLog(@"input image loading failed");
    CSIFT test;
    IplImage *testIplImg = 0;
    if (!testIplImg)
        NSLog(@"IplImage is NULL");
//    saveTXTFileUserPath();
    FILE *fin1 = fopen("/Users/ictway/Desktop/test.txt", "w");
    if (!fin1)
        printf("%s is NULL!\n", "test.txt");
    fprintf(fin1, "test File IO2222\n");
    fclose(fin1);
//    saveTXTFile("testFileIO.txt");

    
//    test.ExtractFeatures(testIplImg);
    [pImageView setImage:originImage];
    [super viewDidLoad];
}

- (IBAction) PushSetupClick // 앱 정보 화면 모달
{
    // ImageProcInfoViewController.xib를 로드해서 객체를 생성합니다.
    if(self.pImageProcInfoViewController == nil){
        ImageProcInfoViewController *viewController = [[ImageProcInfoViewController alloc]initWithNibName:@"ImageProcInfoViewController" bundle:nil];
        self.pImageProcInfoViewController = viewController;
    }
    
    [self presentViewController:self.pImageProcInfoViewController animated:NO completion:nil];
}

- (IBAction)PushELCModalView:(id)sender {
    // ELCModalViewController.xib 를 로드해서 객체를 생성합니다.
    if(self.pELCModalViewController == nil){
        ELCModalViewController *viewController = [[ELCModalViewController alloc]initWithNibName:@"ELCModalViewController" bundle:nil];
        self.pELCModalViewController = viewController;
    }
    
    [self presentViewController:self.pELCModalViewController animated:NO completion:nil];
}

- (IBAction)runGeneralPicker // 사진앨범에서 이미지 선택
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //사용할 소스를 설정합니다.
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}



- (IBAction)saveImage // 현재 사진을 카메라 롤에 저장합니다.
{
    UIImage *image = pImageView.image;
    UIImageWriteToSavedPhotosAlbum(image, self,
                                   @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

// 저장한 이후에 실행 될 메소드
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        NSLog(@"saved");
    }
}

- (void)finishedPicker // 이미지 피커 화면을 닫습니다.
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 사진을 선택했을 경우 호출됩니다.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    //선택한 이미지를 가져옵니다.
    originImage = nil;
    originImage = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    [self finishedPicker];
    
    [pImageView setImage:originImage];
}

// 사진 선택을 취소했을 경우 호출됩니다.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    printf("test cancle\n");
    [self finishedPicker];
}

// 그레이 스케일 변환을 합니다.
- (IBAction)WhiteBlackImage
{
    pImageView.image = [[[pImageProcessing setImage:originImage] getGrayImage] getImage];
}

// 이미지를 반전하여 처리합니다.
- (IBAction)inverseImage
{
    pImageView.image = [[[pImageProcessing setImage:originImage] getInverseImage] getImage];
}

// 이미지 윤관선을 추출합니다.
- (IBAction)TrackingImage
{
    pImageView.image = [[pImageProcessing setImage: originImage] getTrackingImage];
}

// C++ STL OpenCV Canny 함수를 호출합니다.
- (IBAction)OpenCVCanny
{
    // get cv::Mat type image from UIImage
    cv::Mat inputMat = [self cvMatFromUIImage: pImageView.image];
    
    // make cv::Mat type result image
    cv::Mat outputMat;
    
    // call c++ static library using OpenCV for iOS
    outputMat = detectEdge(inputMat);
    
    // final result is converted to UIImage for display
    UIImage *resultUIImage = [self UIImageFromCVMat:outputMat];
    // put into the screen
    pImageView.image = resultUIImage;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// -------------------------------------------------------------------------------
//            openCV Interface: UIImage <-> cv::Mat
// -------------------------------------------------------------------------------

- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels, BGRA
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    return cvMat;
}

- (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC1); // 8 bits per component, 1 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    return cvMat;
}

-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}

@end
