//
//  LLSSettingsViewController.m
//  Harmonious
//
//  Created by luolisheng on 15/4/5.
//  Copyright (c) 2015年 luolisheng. All rights reserved.
//

#import "LLSSettingsViewController.h"
#import "LLSProductViewController.h"

#import "LLSSettingCell.h"
#import "LLSCollectionCell.h"
#import "LLSLoginFooterView.h"
#import "LLSAboutFooterView.h"
#import "LLSCollectionFooterView.h"
#import "LLSProgerssHUD.h"

#import "NSString+LLSString.h"

#import <HexColors/HexColor.h>

static CGFloat const kHeight_Cell = 50.0f;
static CGFloat const kHeight_AboutFooter = 200.0f;

@interface LLSSettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL isLogined;

@property (nonatomic, assign) BOOL loginCellSelected;
@property (nonatomic, assign) BOOL activitiesSelected;
@property (nonatomic, assign) BOOL aboutCellSelected;

@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, copy) NSString *verifCode;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collections;

@end

@implementation LLSSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.titleBar setTitleBarWithTitle:@""
                                  image:[UIImage imageNamed:@"tib_me"] 
                titleButtonPressedBlock:nil
                 moreButtonPressedBlock:nil];
    
    [self.titleBar hideTitle:YES];
    [self.titleBar hideMoreButton:YES];
    
    _dataSource = @[@[@"用户登录"],
                    @[@"关于我们"]];
    
    _loginCellSelected = NO;
    _aboutCellSelected = NO;
    
    [self refreshLoginStatus];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_isLogined) {
        [self fetchCollectiones];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- Login status

- (void)refreshLoginStatus {
    LLSAccount *loginAccount = [self.businessManager loginAccount];
    if (loginAccount) {
        _isLogined = YES;
        _phoneNum = loginAccount.userNick;
        
        _loginCellSelected = YES;
    }
}

#pragma mark -- Fetch collectiones

- (void)fetchCollectiones {
    WSelf(weakSelf)
    [self.businessManager fetchCollectionesWithCompletedHandler:^(id responseObject, NSString *message, NSError *error) {
        SSelf(strongSelf)
        if (!error) {
            if (responseObject) {
                strongSelf.collections = (NSMutableArray *)responseObject;
                [strongSelf.tableView reloadData];
            }
        }
    }];
}

- (void)deleteCollectionWithId:(NSInteger)Id {
    WSelf(weakSelf)
    [self.businessManager deCollectProductWithProductId:Id completedHandler:^(id responseObject, NSString *message, NSError *error) {
        SSelf(strongSelf)
        if (!error) {
            if (responseObject) {
                [strongSelf.collections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    LLSProduct *product = (LLSProduct *)obj;
                    if (product.productId == Id) {
                        [strongSelf.collections removeObject:obj];
                    }
                    *stop = YES;
                }];
            }
            [strongSelf.tableView reloadData];
        }
        [LLSProgerssHUD showHUDAddedTo:weakSelf.view animated:YES withMessage:message];
    }];
}

#pragma mark -- Get VerifCode

- (void)getVerifCodeWithPhoneNum:(NSString *)phoneNum {
    if (![NSString lls_isPhoneNum:phoneNum]) {
        [LLSProgerssHUD showHUDAddedTo:self.view animated:YES withMessage:@"请输入正确的手机号"];
        return;
    }
    
    [self.view endEditing:YES];
    
    [LLSProgerssHUD showLoadingHUDAddedTo:self.view animated:YES];
    
    WSelf(weakSelf)
    [self.businessManager fetchVerifCodeWithPhoneNum:phoneNum
                                    completedHandler:^(id responseObject, NSString *message, NSError *error)
    {
        SSelf(strongSelf)
        strongSelf.phoneNum = phoneNum;
        strongSelf.verifCode = [((NSDictionary *)responseObject)[@"code"] stringValue];
        
        [LLSProgerssHUD showHUDAddedTo:strongSelf.view animated:YES withMessage:message];
    }];
}

#pragma mark -- Login

- (void)loginWithVerifCode:(NSString *)verifCode {
    [self.view endEditing:YES];
    
    if ([NSString lls_isEmpty:_verifCode]) {
        [LLSProgerssHUD showHUDAddedTo:self.view animated:YES withMessage:@"请获取验证码"];
        return;
    }
    if ([NSString lls_isEmpty:verifCode]) {
        [LLSProgerssHUD showHUDAddedTo:self.view animated:YES withMessage:@"请输入验证码"];
        return;
    }
    if (![verifCode isEqualToString:_verifCode]) {
        [LLSProgerssHUD showHUDAddedTo:self.view animated:YES withMessage:@"输入的验证码不正确"];
        return;
    }
    
    [self loginWithUserId:@""
                 userName:[NSString stringWithFormat:@"phone_%@", _phoneNum]
                 nickName:_phoneNum];
}

#pragma mark -- Auth

- (void)authWithShareType:(ShareType)shareType {
    WSelf(weakSelf)
    [self.shareSDKManager loginWithShareType:shareType
                            completedHandler:^(BOOL result, id<ISSPlatformUser> userInfo)
     {
         if (result) {
             SSelf(strongSelf)
             [LLSProgerssHUD showLoadingHUDAddedTo:strongSelf.view animated:YES withMessage:@"授权成功,正在登录"];
             
             NSString *userId = [userInfo uid];
             NSString *nickName = [userInfo nickname];
             [weakSelf loginWithUserId:userId
                              userName:[NSString stringWithFormat:@"%@%@", nickName, userId]
                              nickName:nickName];
         } else {
             [LLSProgerssHUD showHUDAddedTo:weakSelf.view animated:YES withMessage:@"授权失败"];
         }
     }];
}

- (void)loginWithUserId:(NSString *)userId userName:(NSString *)userName nickName:(NSString *)nickName {
    WSelf(weakSelf)
    [self.businessManager loginWithUserId:userId
                                 nickName:nickName
                         completedHandler:^(id responseObject, NSString *message, NSError *error)
    {
        SSelf(strongSelf)
        if (!error) {
            if (responseObject) {
                [strongSelf refreshLoginStatus];
                strongSelf.collections = (NSMutableArray *)responseObject;
                
                [strongSelf.tableView reloadData];
            }
        } else {
            [strongSelf.shareSDKManager logoutWithShareType:ShareTypeQQSpace];
            [strongSelf.shareSDKManager logoutWithShareType:ShareTypeSinaWeibo];
        }
        [LLSProgerssHUD showHUDAddedTo:strongSelf.view animated:YES withMessage:message];
    }];
}

#pragma mark -- Logout

- (void)logout {
    [self.shareSDKManager logoutWithShareType:ShareTypeQQSpace];
    [self.shareSDKManager logoutWithShareType:ShareTypeSinaWeibo];
    
    [self.businessManager logoutWithCompletedHandler:nil];
    
    [self refreshLoginStatus];
    [(NSMutableArray *)(self.dataSource[1]) removeAllObjects];
    
    [self.tableView reloadData];
    
    [LLSProgerssHUD showHUDAddedTo:self.view animated:YES withMessage:@"已退出"];
}

#pragma mark -- Create foorter view

- (UIView *)createFooterViewWithSection:(NSInteger)section {
    UIView *view;
    if (section == 1) {
        if (_aboutCellSelected) {
            view = [[[NSBundle mainBundle] loadNibNamed:@"LLSAboutFooterView" owner:self options:nil] objectAtIndex:0];
        }
    } else {
        WSelf(weakSelf)
        if (!_isLogined && _loginCellSelected) {
            __weak LLSLoginFooterView *footerView =
            [[[NSBundle mainBundle] loadNibNamed:@"LLSLoginFooterView" owner:self options:nil] objectAtIndex:0];
            [footerView setSocialButtonPressedBlock:^(NSInteger tag) {
                SSelf(strongSelf)
                ShareType shareType = -1;
                switch (tag) {
                    case 0:{
                        [strongSelf getVerifCodeWithPhoneNum:footerView.phoneNumTextField.text];
                        return;
                    }
                    case 1: {
                        [strongSelf loginWithVerifCode:footerView.verifCodeTextField.text];
                        return;
                    }
                    case 2:
                        shareType = ShareTypeQQSpace;
                        break;
                    case 3:
                        shareType = ShareTypeSinaWeibo;
                        break;
                    default:
                        break;
                }
                [weakSelf authWithShareType:shareType];
            }];
            
            view = footerView;
        } else {
            if (_loginCellSelected) {
                LLSCollectionFooterView *footerView =
                [[LLSCollectionFooterView alloc] initWithFrame:CGRectMake(.0f, .0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(self.tableView.frame)-2*kHeight_Cell)];
                footerView.collections = self.collections;
                
                [footerView setDeleteButtonPressedBlock:^(NSInteger productId) {
                    SSelf(strongSelf)
                    [strongSelf deleteCollectionWithId:productId];
                }];
                
                [footerView setCollectionPressedBlock:^(LLSProduct *product) {
                    SSelf(strongSelf)
                    LLSProductViewController *productViewController =
                    [[LLSProductViewController alloc] initWithProduct:product
                                                       controllerType:LLSProductViewControllerType_PC];
                    
                    [strongSelf presentViewController: [[UINavigationController alloc] initWithRootViewController:productViewController] animated:YES completion:nil];
                }];
                
                view = footerView;
            }
        }
    }
    
    return view;
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  ((NSArray *)_dataSource[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    LLSSettingCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LLSSettingCell class])];
    if (!cell) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"LLSSettingCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
    }
    if (_isLogined && section == 0) {
        cell.titleLabel.text = _phoneNum;
    } else {
        cell.titleLabel.text = ((NSArray *)_dataSource[section])[row];
    }
    
    if (section == 0) {
        cell.titleLabel.textColor =
        (_loginCellSelected)?[UIColor redColor]:[UIColor colorWithHexString:@"999999"];
    } else if (section == 1) {
        cell.titleLabel.textColor =
        (_aboutCellSelected)?[UIColor redColor]:[UIColor colorWithHexString:@"999999"];
    }
    return cell;
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHeight_Cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = CGFLOAT_MIN;
    if (section != 0) {
        height = 1.0f;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = CGFLOAT_MIN;
    if (section == 0) {
        if (_loginCellSelected) {
            height = CGRectGetHeight(tableView.bounds)-kHeight_Cell*2;
        }
    } else if (section == 1) {
        if (_aboutCellSelected) {
            height = kHeight_AboutFooter;
        }
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self createFooterViewWithSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
            _loginCellSelected = true;
            _aboutCellSelected = false;
            break;
        case 1:
            _aboutCellSelected = true;
            _loginCellSelected = false;
            break;
        default:
            break;
    }
    
    [_tableView reloadData];
}

@end
