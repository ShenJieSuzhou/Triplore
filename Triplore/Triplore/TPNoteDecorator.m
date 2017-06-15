//
//  TPNoteDecorator.m
//  Triplore
//
//  Created by 宋 奎熹 on 2017/6/15.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

#import "TPNoteDecorator.h"
#import "TPNoteTitleViewGreen.h"
#import "TPNote.h"
#import "TPNoteTemplate.h"
#import "UIImageView+Decorator.h"

@implementation TPNoteDecorator

//  标题 Label ：Tag = 1

+ (NSArray<UIView *> *)getNoteViews:(TPNote *)note andTemplate:(TPNoteTemplate *)template{
    NSMutableArray<UIView *> *tempViews = [[NSMutableArray alloc] init];
    
    [template.tem_titleView setDate:note.createTime];
    [tempViews addObject:template.tem_titleView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:note.title];
    [titleLabel setFont:template.tem_font];
    [titleLabel sizeToFit];
    [titleLabel setTag:1];
    [tempViews addObject:titleLabel];
    
    for(UIView *view in note.views){
        if([view isKindOfClass:[UILabel class]]){
            UILabel *label = (UILabel *)view;
            [label setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16.0]];
            [tempViews addObject:label];
        }else if([view isKindOfClass:[UIImageView class]]){
            UIImageView *oldView = (UIImageView *)view;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldView.frame];
            [imageView setImage:oldView.image];
            switch (template.tem_num) {
                case TPGreen:
                    [imageView decorateWithGreen];
                    break;
                case TPBrown:
                    [imageView decorateWithBrown];
                default:
                    break;
            }
            [tempViews addObject:imageView];
        }
    }
    
    [tempViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setBackgroundColor:template.tem_color];
    }];
    
    return [NSArray arrayWithArray:tempViews];
}

@end