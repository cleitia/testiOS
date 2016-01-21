//
//  ImageProcessing.h
//  ImgProcApp_v1
//
//  Created by ICTWAY on 2016. 1. 21..
//  Copyright © 2016년 ICTWAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageProcessing : NSObject
{
    unsigned char *rawImage; // 이미지의 바이트 단위 데이터
    
    int imageWidth; // 이미지의 가로 길이
    int imageHeight; // 이미지의 세로 길이
}

-(void) AllocMeomoryImage:(int)width Height:(int)height;
-(id) setImage:(UIImage*)Image;
-(UIImage*) getImage;

-(UIImage*) BitmapToUIImage;
-(UIImage*) BitmapToUIImage:(unsigned char *) bitmap BitmapSize:(CGSize)size;
-(void) DataInit; // 초기화
-(id) getGrayImage; // 회색조 처리
-(id) getInverseImage; // 이미지 반전 처리
-(UIImage*) getTrackingImage; // 이미지 윤곽선 추출 처리
@end
