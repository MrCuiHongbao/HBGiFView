//
//  HBGifView.m
//  FBSnapshotTestCase
//
//  Created by hongbao.cui on 2019/6/6.
//

#import "HBGifView.h"
@interface HBGifView() {
    CGFloat imageWidth,imageHeight;
    CGImageSourceRef source;
}
@property(nonatomic,readwrite)NSInteger  imageCount;
@end

@implementation HBGifView
- (void)dealloc {
    [self.layer removeAllAnimations];
    CFRelease(source);
}
- (instancetype)initWithFrame:(CGRect)frame WithGifPath:(NSString *)path {
    self = [super initWithFrame:frame];
    if (self) {
        [self createGIFWithPath:path];
    }
    return self;
}
- (void)createGIFWithPath:(NSString *)filePath {
    //1.获取gif文件数据
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    source = CGImageSourceCreateWithURL((CFURLRef)fileURL, NULL);
    //2.获取gif文件中图片的个数
    size_t count = CGImageSourceGetCount(source);
    _imageCount = (NSInteger)count;
    //3.定义一个变量记录gif播放一轮的时间
    float allTime = 0;
    //4.定义一个可变数组存放所有图片
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    //5.定义一个可变数组存放每一帧播放的时间
    NSMutableArray *timeArray = [[NSMutableArray alloc] init];
    //设置每一帧的时间占比
    NSMutableArray *times = [[NSMutableArray alloc] init];
    float currentTime = 0;
    for (size_t i=0; i<count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);//此处必须为CGImageRef否则会显示不出来
        [imageArray addObject:(__bridge UIImage *)(image)];
        CGImageRelease(image);
        //获取图片信息
        NSDictionary *info = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        //统计时间
        NSDictionary *timeDic = [info objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        CGFloat time = [[timeDic objectForKey:(__bridge NSString *)kCGImagePropertyGIFUnclampedDelayTime] floatValue];
        if (i == 0) {
            imageWidth =  [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelWidth] floatValue];
            imageHeight =  [[info objectForKey:(__bridge NSString *)kCGImagePropertyPixelHeight] floatValue];
        }
        allTime = allTime+time;
        [timeArray addObject:[NSNumber numberWithFloat:time]];
        [times addObject:[NSNumber numberWithFloat:currentTime/allTime]];
        currentTime +=[timeArray[i] floatValue];
    }
    //添加帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    [animation setKeyTimes:times];
    [animation setValues:imageArray];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    //设置循环
    animation.repeatCount = MAXFLOAT;
    //设置播放总时长
    animation.duration = allTime;
    animation.removedOnCompletion = NO;
    //Layer层添加
    [self.layer addAnimation:animation forKey:@"gifAnimation"];
}

- (UIImage *)getImageAtIndex:(NSInteger)index {
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source,index, NULL);
    return [UIImage imageWithCGImage:imageRef];
}
@end
