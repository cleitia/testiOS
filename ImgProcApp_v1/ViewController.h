//
//  ViewController.h
//  ImgProcApp_v1
//
//  Created by ICTWAY on 2016. 1. 21..
//  Copyright © 2016년 ICTWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageProcInfoViewController.h"
#import "ELCModalViewController.h"
#include "EdgeDetect.hpp"


@class ImageProcessing;
@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    ImageProcInfoViewController *pImageProcInfoViewController; // 이미지 정보 뷰 클래스
    ELCModalViewController *pELCModalViewController; // ELC 모달 뷰 클래스
    
    IBOutlet UIButton *infoButton; // 이미지 정보 버튼
    IBOutlet UIBarButtonItem *ELCButton; // ELC 모달 뷰 버튼
    IBOutlet UIImageView *pImageView; // 이미지 뷰
    
    ImageProcessing *pImageProcessing; // 이미지 프로세싱 클래스
    UIImage *originImage; // 원본 이미지
}

-(IBAction)PushSetupClick; // 앱정보
-(IBAction)PushELCModalView; // ELC 모달 뷰 화면 호출
-(IBAction)runGeneralPicker; // 사진 가져오기
-(IBAction)saveImage; // 현재 사진 카메라 롤에 저장하기
-(IBAction)WhiteBlackImage; // 그레이 스케일 변화
-(IBAction)inverseImage; // 이미지 반전
-(IBAction)TrackingImage; // 윤곽선 추출
-(IBAction)OpenCVCanny; // C++ STL OpenCV 함수 호출
@property (strong, nonatomic) ImageProcInfoViewController *pImageProcInfoViewController;
@property (strong, nonatomic) ELCModalViewController *pELCModalViewController;
@end

