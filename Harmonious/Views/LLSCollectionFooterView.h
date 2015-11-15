//
//  LLSCollectionFooterView.h
//  Harmonious
//
//  Created by luolisheng on 15/8/6.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LLSCollectionCell.h"

typedef void(^CollectionPressedBlock)(LLSProduct *product);

@interface LLSCollectionFooterView : UIView

@property (nonatomic, strong) NSMutableArray *collections;

- (void)setDeleteButtonPressedBlock:(DeleteButtonPressedBlock)block;

- (void)setCollectionPressedBlock:(CollectionPressedBlock)block;

@end
