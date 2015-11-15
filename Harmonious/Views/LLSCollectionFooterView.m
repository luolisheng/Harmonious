//
//  LLSCollectionFooterView.m
//  Harmonious
//
//  Created by luolisheng on 15/8/6.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSCollectionFooterView.h"

#import <HexColors/HexColor.h>

static CGFloat const kHeight_Cell = 50.0f;

@interface LLSCollectionFooterView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) DeleteButtonPressedBlock deleteBlock;
@property (nonatomic, copy) CollectionPressedBlock collectionBlock;

@end

@implementation LLSCollectionFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _collections = [NSMutableArray array];
        
        _tableView = [[UITableView alloc] initWithFrame:frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self addSubview:_tableView];
    }
    
    return self;
}

- (void)setCollections:(NSMutableArray *)collections {
    _collections = collections;
    [self.tableView reloadData];
}

- (void)setDeleteButtonPressedBlock:(DeleteButtonPressedBlock)block {
    _deleteBlock = block;
}

- (void)setCollectionPressedBlock:(CollectionPressedBlock)block {
    _collectionBlock = block;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = _collections.count;
    if (count == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:tableView.frame];
        label.text = @"暂无收藏";
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textAlignment = NSTextAlignmentCenter;
        
        _tableView.backgroundView = label;
    } else {
        _tableView.backgroundView = nil;
    }
    return _collections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = NSStringFromClass([LLSCollectionCell class]);
    LLSCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    [cell configCellWithProduct:[_collections objectAtIndex:indexPath.row]];
    [cell setDeleteButtonPressedBlock:^(NSInteger productId) {
        if (_deleteBlock) {
            _deleteBlock(productId);
        }
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView =
    [[UIView alloc] initWithFrame:CGRectMake(.0f, .0f, CGRectGetWidth(_tableView.frame), kHeight_Cell/2)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, .0f, 200.0f, kHeight_Cell/2)];
    label.text = @"个人收藏";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight_Cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kHeight_Cell/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_collectionBlock) {
        _collectionBlock(_collections[indexPath.row]);
    }
}

@end
