//
//  TAutoScrollerView.m
//  AutoScroller
//
//  Created by eeesysmini2 on 2018/8/23.
//

#import "TAutoScrollerView.h"

@interface TAutoScrollerView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollerView;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *middleImageView;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, assign) NSInteger currentScrollCount;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TAutoScrollerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setImageArr:(NSArray *)imageArr{

    _imageArr = imageArr;
    [self setCustomeSubViews];
    
    _imageArr.count >= 3 ? [self startTimerAction] : NULL;
   
}

- (void)startTimerAction{
    
    [self invalidateTime];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerSwitchImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerSwitchImage{
    
     [self.mainScrollerView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame)*2, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:YES];
}

- (void)invalidateTime{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setCustomeSubViews{
    
    NSInteger imageCount = self.imageArr.count;
    
    for (NSInteger i = 0; i < (imageCount >= 3 ? 3 : imageCount); i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * i, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        if (imageCount >= 3) {
            if (i == 0) {
                self.leftImageView = imageView;
                self.leftImageView.image = self.imageArr[self.imageArr.count - 1];
            }else if (i == 1){
                self.middleImageView = imageView;
                self.middleImageView.image = self.imageArr[0];
            }else if (i == 2){
                self.rightImageView = imageView;
                self.rightImageView.image = self.imageArr[1];
            }
        }else{
            imageView.image = self.imageArr[i];
        }
        
        
        
        [self.mainScrollerView addSubview:imageView];
    }
    
}

- (UIScrollView *)mainScrollerView{
    
    if (!_mainScrollerView) {
        _mainScrollerView = [[UIScrollView alloc]initWithFrame:self.frame];
        _mainScrollerView.backgroundColor = [UIColor whiteColor];
        _mainScrollerView.showsHorizontalScrollIndicator = NO;
        _mainScrollerView.showsVerticalScrollIndicator = NO;
        _mainScrollerView.pagingEnabled = YES;
        _mainScrollerView.bounces = NO;
        _mainScrollerView.delegate = self;
        if (self.imageArr.count >= 3) {
            [_mainScrollerView setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * 3, CGRectGetHeight(self.frame))];
            [_mainScrollerView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:YES];
        }else{
            [_mainScrollerView setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * self.imageArr.count, CGRectGetHeight(self.frame))];
        }
       
        [self addSubview:_mainScrollerView];
    }
    return _mainScrollerView;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offSetX = scrollView.contentOffset.x;
    if (self.imageArr.count >= 3) {
        if (offSetX == CGRectGetWidth(self.frame) * 2) {
            self.currentScrollCount ++;
            [self autoSwitchImage];
            
        }else if (offSetX == 0){
            self.currentScrollCount = self.currentScrollCount + self.imageArr.count;
            self.currentScrollCount --;
            [self autoSwitchImage];
        }
    }
    
   
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
     CGFloat offSetX = scrollView.contentOffset.x;
    if (self.imageArr.count >= 3) {
        if (offSetX == CGRectGetWidth(self.frame) * 2) {
            
            self.currentScrollCount ++;
            [self autoSwitchImage];
            
            
        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.imageArr.count >= 3 ?  [self invalidateTime] : NULL;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.imageArr.count >= 3 ? [self startTimerAction] : NULL;
}

- (void)autoSwitchImage{
    
    self.leftImageView.image = self.imageArr[(_currentScrollCount - 1)%self.imageArr.count];
    
    self.middleImageView.image = self.imageArr[_currentScrollCount % self.imageArr.count];
    
    self.rightImageView.image = self.imageArr[(_currentScrollCount + 1) % self.imageArr.count];
    
    [self.mainScrollerView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0)];
    
}

@end
