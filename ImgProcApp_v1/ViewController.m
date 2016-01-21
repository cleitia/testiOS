//
//  ViewController.m
//  ImgProcApp_v1
//
//  Created by ICTWAY on 2016. 1. 21..
//  Copyright © 2016년 ICTWAY. All rights reserved.
//

#import "ViewController.h"
#import "ImageProcessing.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize pImageProcInfoViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    pImageProcessing = [[ImageProcessing alloc] init];
    printf("test\n");
    originImage = [UIImage imageNamed:@"cat.jpeg"];
    if (originImage == nil)
        NSLog(@"input image loading failed");
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
