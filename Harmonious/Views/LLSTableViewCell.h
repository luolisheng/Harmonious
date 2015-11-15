//
//  LLSTableViewCell.h
//  Harmonious
//
//  Created by luolisheng on 15/4/14.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LLSPithyCourt.h"
#import "LLSSpeakEtiquette.h"

typedef void(^ProductTapedBlock)(NSInteger Id);

@interface LLSTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *productOne;
@property (weak, nonatomic) IBOutlet UIImageView *productTwo;
@property (weak, nonatomic) IBOutlet UIImageView *productThree;

- (void)configCellWithObject:(id)object;

- (void)setProductTapedBlock:(ProductTapedBlock)block;

@end
