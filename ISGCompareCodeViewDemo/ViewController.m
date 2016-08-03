//
//  ViewController.m
//  ISGCompareCodeViewDemo
//
//  Created by isaac on 16/8/3.
//  Copyright © 2016年 ultrapower. All rights reserved.
//

#import "ViewController.h"
#import "ISGCompareCodeView.h"

@interface ViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

/*! @brief <#name#> */
@property (nonatomic, weak) UITextField *input;

/*! @brief <#name#> */
@property (nonatomic, weak) ISGCompareCodeView *codeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupViews];
}

- (void)setupViews {
    ISGCompareCodeView *codeView = [[ISGCompareCodeView alloc] initWithFrame:CGRectMake(30, 140, 150, 40)];
    // 禁止点击更换图片
    codeView.isNoTouch = YES;
    [self.view addSubview:codeView];
    self.codeView = codeView;
    
    //提示文字
    UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 140, 100, 40)];
    [changeBtn setTitle:@"点击图片换验证码" forState:UIControlStateNormal];
    [changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [changeBtn addTarget:self action:@selector(changeCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    
    //添加输入框
     UITextField *input = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, 150, 40)];
    input.layer.borderColor = [UIColor orangeColor].CGColor;
    input.layer.borderWidth = 1.0;
    input.layer.cornerRadius = 5.0;
    input.font = [UIFont systemFontOfSize:12];
    input.placeholder = @"请输入验证码,区分大小写!";
    input.clearButtonMode = UITextFieldViewModeWhileEditing;
    input.backgroundColor = [UIColor clearColor];
    input.textAlignment = NSTextAlignmentCenter;
    input.returnKeyType = UIReturnKeyDone;
    input.delegate = self;
    [self.view addSubview:input];
    self.input = input;
    
    //添加验证按钮
    UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 40)];
    button.backgroundColor=[UIColor blueColor];
    [button setTitle:@"验证" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    button.layer.borderColor = [UIColor orangeColor].CGColor;
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 5.0;
    [button addTarget:self action:@selector(compare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)changeCode:(id)sender {
    [self.codeView changeCompareCode];
}

- (void)compare:(id)sender {
    if ([self.codeView compareResult:self.input.text]) {
        //正确弹出警告款提示正确
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"恭喜您 ^o^" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview show];
    }
    else
    {
        //验证不匹配，验证码和输入框晃动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [self.codeView.layer addAnimation:anim forKey:nil];
        [self.input.layer addAnimation:anim forKey:nil];
    }

}
@end
