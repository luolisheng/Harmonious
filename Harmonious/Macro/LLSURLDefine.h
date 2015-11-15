//
//  LLSURLDefine.h
//  Harmonious
//
//  Created by luolisheng on 15/4/9.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#ifndef Harmonious_LLSURLDefine_h
#define Harmonious_LLSURLDefine_h

#define kScheme             @"http://"

#define kHost               @"123.57.60.33:8080"

#define kPath               @"/Web/Interface/"

#define kPath_Img           @"/FileUploadImgs/"

#define kBaseURL            kScheme kHost kPath
#define kBaseURL_Img        kScheme kHost kPath_Img

#define kURL_VerifCode      kBaseURL@"getcode.ashx"
#define kURL_Login          kBaseURL@"login.ashx"

#define kURL_PithyCourt     kBaseURL@"jingcuiyuan.ashx"
#define kURL_SpeakEtiquette kBaseURL@"yanlitang.ashx"
#define kURL_GeImage        kBaseURL@"geimg.ashx"

#define kURL_Traditional    kBaseURL@"chuantonggongyi.ashx"
#define kURL_ForeignAffairs kBaseURL@"waishijingcui.ashx"
#define kURL_Innovation     kBaseURL@"zhongguochuangxin.ashx"

#define kURL_Collect        kBaseURL@"shoucang.ashx"
#define kURL_CancelCollect  kBaseURL@"qxshoucang.ashx"

#define kURL_GeImg1         kBaseURL@"geimg.ashx"
#define kURL_GeImg2         kBaseURL@"ge1img.ashx"
#define kURL_GeImg3         kBaseURL@"ge2img.ashx"
#define kURL_GeImg4         kBaseURL@"ge3img.ashx"

#endif
