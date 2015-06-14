//
//  TreeNode.h
//  binaryTree
//
//  Created by weizhou on 6/13/15.
//  Copyright © 2015 weizhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger data;
@property (nonatomic, strong, nullable) TreeNode *left;
@property (nonatomic, strong, nullable) TreeNode *right;

- (nonnull instancetype)initWithData:(NSInteger)data;

- (nonnull instancetype)initWithData:(NSInteger)data
                            leftNode:(nullable TreeNode *)left
                           rightNode:(nullable TreeNode *)right NS_DESIGNATED_INITIALIZER;

@end
