//
//  LLSTableViewImageCell.h
//  Harmonious
//
//  Created by luolisheng on 15/4/21.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSTableViewImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

- (void)configCellWithImageName:(NSString *)imageName;

@end
