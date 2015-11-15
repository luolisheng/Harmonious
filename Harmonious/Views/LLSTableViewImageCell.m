//
//  LLSTableViewImageCell.m
//  Harmonious
//
//  Created by luolisheng on 15/4/21.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSTableViewImageCell.h"

#import <XLRemoteImageView/UIImageView+XLProgressIndicator.h>

@implementation LLSTableViewImageCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configCellWithImageName:(NSString *)imageName {
    NSString *imageURLStr = [kBaseURL_Img stringByAppendingPathComponent:imageName];
    [_backgroundImage setImageWithProgressIndicatorAndURL:[NSURL URLWithString:imageURLStr]];
}

@end
