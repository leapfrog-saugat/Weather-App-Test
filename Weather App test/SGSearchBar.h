//
//  SGSearchBar.h
//  Weather App test
//
//  Created by Saugat Gautam on 3/11/15.
//  Copyright (c) 2015 Saugat Gautam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGSearchBar : UIView

@property (nonatomic, weak) UITextField *txtSearchBar;
@property (nonatomic, unsafe_unretained) CGSize *size;
@property (nonatomic, weak) UIImage *imgSearchImage;

- (instancetype) initWithImage;
- (instancetype) initWithSize;

@end
