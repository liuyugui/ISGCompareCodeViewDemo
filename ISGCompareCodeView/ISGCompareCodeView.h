//
//  ISGCompareCodeView.h
//
//  Created by isaac on 16/8/3.
//  Copyright © 2016年 isaac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISGCompareCodeView : UIView

/*! @brief  是否限制点击更换验证码 */
@property (nonatomic, assign) BOOL isNoTouch;
/*! @brief  验证码 */
@property (nonatomic, strong, readonly) NSString *compareCode;

/**
 *  更换验证码
 */
- (void)changeCompareCode;

/**
 *  不区分大小写对比验证码
 *
 *  @param string 输入的验证码
 *
 *  @return 是否相同
 */
- (BOOL)compareResult:(NSString *)string;
@end
