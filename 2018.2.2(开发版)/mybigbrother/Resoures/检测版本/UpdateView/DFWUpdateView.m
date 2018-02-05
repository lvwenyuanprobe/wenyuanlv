//
//  DFWUpdateView.m
//  RenRenCiShanJia
//
//  Created by zhoujianfeng on 2017/4/21.
//  Copyright © 2017年 sugarskylove. All rights reserved.
//

#import "DFWUpdateView.h"
#import "Masonry.h"

#define CONTAINER_WIDTH (SCREEN_WIDTH * 0.8)
#define CONTAINER_HEIGHT (SCREEN_HEIGHT * 0.55)

@interface DFWUpdateView ()
@property (nonatomic, copy) void (^tapBlock)(BOOL isUpdate);

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation DFWUpdateView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self prepareUI];
    }
    return self;
}

/**
 准备UI
 */
- (void)prepareUI
{
    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.tipImageView];
    [self.containerView addSubview:self.versionLabel];
    [self.containerView addSubview:self.messageLabel];
    [self.containerView addSubview:self.confirmButton];
    [self.containerView addSubview:self.cancelButton];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(CONTAINER_WIDTH, CONTAINER_HEIGHT));
    }];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(CONTAINER_HEIGHT * 0.25);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.bottom.equalTo(self.tipImageView.mas_bottom).mas_offset(-5);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.equalTo(self.tipImageView.mas_bottom).mas_offset(20);
        make.width.mas_equalTo(CONTAINER_WIDTH - 20);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(CONTAINER_HEIGHT * 0.125);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.cancelButton.mas_top);
        make.height.mas_equalTo(CONTAINER_HEIGHT * 0.125);
    }];
}

/**
 显示升级弹窗

 @param version 版本号
 @param message 升级提示信息
 @param tapBlock 是否升级回调
 */
- (void)showWithVersion:(NSString *)version message:(NSString *)message tapBlock:(void (^)(BOOL isUpdate))tapBlock
{
    self.tapBlock = tapBlock;
    self.versionLabel.text = [NSString stringWithFormat:@"版本号：V%@", version];
    self.messageLabel.text = message;
    
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    self.containerView.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
    
}

/**
 弹窗消失
 */
- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.transform = CGAffineTransformMakeScale(0, 0);
        self.alpha = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/**
 确定升级
 */
- (void)didTappedConfirm
{
    [self dismiss];
    self.tapBlock(YES);
}

/**
 取消升级
 */
- (void)didTappedCancel
{
    [self dismiss];
    self.tapBlock(NO);
}

#pragma mark - 懒加载
- (UIView *)containerView
{
    
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 10;
        _containerView.layer.masksToBounds = YES;
    }
    return _containerView;
}

- (UIImageView *)tipImageView
{
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.image = [UIImage imageNamed:@"UpdateVersion"];
    }
    return _tipImageView;
}

- (UILabel *)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.textColor = [UIColor colorWithRed:0.98 green:0.92 blue:0.91 alpha:1.00];
        _versionLabel.font = [UIFont systemFontOfSize:14];
    }
    return _versionLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor colorWithRed:0.06 green:0.06 blue:0.06 alpha:1.00];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"立即升级" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor colorWithRed:0.98 green:0.26 blue:0.31 alpha:1.00] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _confirmButton.layer.borderColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00].CGColor;
        _confirmButton.layer.borderWidth = 1;
        [_confirmButton addTarget:self action:@selector(didTappedConfirm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"暂不升级" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1.00] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelButton addTarget:self action:@selector(didTappedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

@end
