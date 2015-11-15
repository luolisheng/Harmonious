//
//  LLSCollectionCell.h
//  Harmonious
//
//  Created by luolisheng on 15/4/22.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LLSProduct.h"

typedef void(^DeleteButtonPressedBlock)(NSInteger productId);

@interface LLSCollectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (void)configCellWithProduct:(LLSProduct *)product;

- (void)setDeleteButtonPressedBlock:(DeleteButtonPressedBlock)block;

- (IBAction)deleteButtonPressed:(id)sender;

@end
