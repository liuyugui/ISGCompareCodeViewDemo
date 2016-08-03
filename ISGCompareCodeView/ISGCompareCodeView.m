//
//  ISGCompareCodeView.m
//
//  Created by isaac on 16/8/3.
//  Copyright © 2016年 isaac. All rights reserved.
//

#import "ISGCompareCodeView.h"

#define ISGRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
#define ISGLineCount 6
#define ISGLineWidth 1.0
#define ISGCharCount 4
#define ISGFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]

@interface ISGCompareCodeView()

/*! @brief 字符素材数组 */
@property (nonatomic, strong) NSArray *changeArray;
/*! @brief 验证码的字符串 */
@property (nonatomic, copy) NSMutableString *changeString;

@end

@implementation ISGCompareCodeView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = ISGRandomColor;
        
        //显示一个随机验证码
        [self changeCaptcha];
    }
    
    return self;
}

#pragma mark 绘制界面（1.UIView初始化后自动调用； 2.调用setNeedsDisplay方法时会自动调用）
- (void)drawRect:(CGRect)rect {
    // 重写父类方法，首先要调用父类的方法
    [super drawRect:rect];
    
    //设置随机背景颜色
    self.backgroundColor = ISGRandomColor;
    
    //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    int width = rect.size.width / text.length - cSize.width;
    int height = rect.size.height - cSize.height;
    CGPoint point;
    
    //依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
    float pX, pY;
    for (int i = 0; i < text.length; i++)
    {
        pX = arc4random() % width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:ISGFontSize}];
    }
    
    //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置画线宽度
    CGContextSetLineWidth(context, ISGLineWidth);
    
    //绘制干扰的彩色直线
    for(int i = 0; i < ISGLineCount; i++)
    {
        //设置线的随机颜色
        UIColor *color = ISGRandomColor;
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        //设置线的起点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        //设置线终点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        //画线
        CGContextStrokePath(context);
    }
}

- (void)changeCaptcha {

    //如果能确定最大需要的容量，使用initWithCapacity:来设置，好处是当元素个数不超过容量时，添加元素不需要重新分配内存
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:ISGCharCount];
    self.changeString = [[NSMutableString alloc] initWithCapacity:ISGCharCount];
    
    //随机从数组中选取需要个数的字符，然后拼接为一个字符串
    for(int i = 0; i < ISGCharCount; i++)
    {
        NSInteger index = arc4random() % ([self.changeArray count] - 1);
        getStr = [self.changeArray objectAtIndex:index];
        
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isNoTouch) {
        return;
    }
    //点击界面，切换验证码
    [self changeCaptcha];
    //setNeedsDisplay调用drawRect方法来实现view的绘制
    [self setNeedsDisplay];
}

#pragma mark - Public Method 
- (void)changeCompareCode {
    [self changeCaptcha];
    
    //setNeedsDisplay调用drawRect方法来实现view的绘制
    [self setNeedsDisplay];
}

- (BOOL)compareResult:(NSString *)string {
    return [self.changeString compare:string options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
}
#pragma mark - Setter Getter
- (NSString *)compareCode {
    return [NSString stringWithString:self.changeString];
}

- (NSArray *)changeArray {
    if (nil == _changeArray) {
        _changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    }
    return _changeArray;
}
- (NSMutableString *)changeString {
    if (nil == _changeString) {
        _changeString = [[NSMutableString alloc] init];
    }
    return _changeString;
}
@end
