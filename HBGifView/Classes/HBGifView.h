//
//  HBGifView.h
//  FBSnapshotTestCase
//
//  Created by hongbao.cui on 2019/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBGifView : UIImageView

// 获取gif图片元素的个数
@property(nonatomic,readonly)NSInteger  imageCount;
/**
 根据路径和frame返回HBGifView对象

 @param frame 视图的大小
 @param path gif的路径
 @return HBGifView
 */
- (instancetype)initWithFrame:(CGRect)frame WithGifPath:(NSString *)path;


/**
 返回图片的image

 @param index gif索引
 @return UIImage
 */

- (UIImage *)getImageAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
