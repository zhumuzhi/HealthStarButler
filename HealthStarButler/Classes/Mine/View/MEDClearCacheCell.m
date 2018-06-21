//
//  MEDClearCacheCell.m
//  健康之星管家
//
//  Created by 朱慕之 on 2017/7/18.
//  Copyright © 2017年 Meridian. All rights reserved.
//

#import "MEDClearCacheCell.h"
#import "SDImageCache.h"

#define MEDCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"]


@interface MEDClearCacheCell ()

@property (nonatomic, weak) UILabel *titleLbl;
@property (nonatomic, weak) UILabel *numLbl;

@end

@implementation MEDClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 预留cell右边的指示器
        // UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        // [loadingView startAnimating];
        // self.accessoryView = loadingView;
        
//        UILabel *titleLbl = [[UILabel alloc] init];
//        titleLbl.font = sysFont(16);
//        titleLbl.textColor = MEDGray;
//        [self.contentView addSubview:titleLbl];
//        titleLbl.frame = CGRectMake(0, 0, self.width/3 , self.height);
        
        self.titleLbl = self.textLabel;
        self.titleLbl.text = @"计算缓存...";
        self.titleLbl.font = MEDSYSFont(16);
        self.titleLbl.textColor = MEDGrayColor(40);
        
        UILabel *numLbl = [[UILabel alloc] init];
        numLbl.font = MEDSYSFont(16);
        numLbl.textColor = MEDGrayColor(40);
        numLbl.textAlignment = NSTextAlignmentRight;
        numLbl.frame = CGRectMake(0, 0, self.width/3, self.height);
        numLbl.right = SCREEN_WIDTH - 20;
        
        self.numLbl = numLbl;
        [self.contentView addSubview:numLbl];
        
        //MYLog(@"测试*SCREEN_WIDTH:%f *self.width/3:%f", SCREEN_WIDTH , self.contentView.right);
        
        self.userInteractionEnabled = NO;
        
        __weak typeof(self) weakSelf = self;
        //        NSUInteger size = [[SDImageCache sharedImageCache] getSize];
        //        MYLog(@"SD获取的缓存为:%lud",(unsigned long) size);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            // 获得缓存文件夹路径
            unsigned long long size = MEDCacheFile.fileSize;
            //MYLog(@"拼接完的路径测试:%@", MEDCacheFile);
            //MYLog(@"路径中获取的缓存为:%ld", (unsigned long)size);
            
            if (weakSelf == nil) return;
            
            NSString *sizeText = nil;
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%lluB", size];
            }
            
            NSString *text = [NSString stringWithFormat:@"清除缓存"];
            
            NSString *numText = [NSString stringWithFormat:@"%@", sizeText];
            
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            //NSLog(@"paths :%@", paths);

            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.titleLbl.text = text;
                weakSelf.numLbl.text = numText;
                //                weakSelf.accessoryView = nil;
                //                weakSelf.accessoryType = UITableViewCellAccessoryNone;
                
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
                
                weakSelf.userInteractionEnabled = YES;
            });
        });
    }
    return self;
}





/**
 *  清除缓存
 */
- (void)clearCache
{

    __weak typeof(self) weakSelf = self;
    // 弹出指示器
    [MEDProgressHUD showHUDStatusTitle:@"正在清除缓存..."];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [[NSURLCache sharedURLCache] removeAllCachedResponses]; //清除AFN缓存
    }];
    //删除自定义的缓存
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:MEDCacheFile error:nil];
        [mgr createDirectoryAtPath:MEDCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
  
        // 所有的缓存都清除完毕
        dispatch_async(dispatch_get_main_queue(), ^{
            // 隐藏指示器
            [MEDProgressHUD dismissHUD];
       
            // 设置文字
            weakSelf.titleLbl.text = @"清除缓存";
            weakSelf.titleLbl.textColor = MEDGrayColor(40);
            weakSelf.numLbl.text = @"0B";
        });
    });

}

/**
 *  当cell重新显示到屏幕上时, 也会调用一次layoutSubviews
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // cell重新显示的时候, 继续转圈圈
//    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
//    [loadingView startAnimating];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
