//
//  testFileIO.cpp
//  ImgProcApp_v1
//
//  Created by ICTWAY on 2016. 1. 25..
//  Copyright © 2016년 ICTWAY. All rights reserved.
//

#include "testFileIO.hpp"

void saveTXTFile(char *fileName)
{
    FILE *fin1 = fopen(fileName, "w");
    if (!fin1)
        printf("%s is NULL!\n", fileName);
//    fprintf(fin1, "test File IO\n");
    fclose(fin1);
}

void saveTXTFileUserPath()
{
    
}
