//
//  TreeNode.m
//  binaryTree
//
//  Created by weizhou on 6/13/15.
//  Copyright © 2015 weizhou. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

- (instancetype)init {
    self = [self initWithData:0 leftNode:nil rightNode:nil];
    return self;
}

- (instancetype)initWithData:(NSInteger)data {
    self = [self initWithData:data leftNode:nil rightNode:nil];
    return self;
}

- (instancetype)initWithData:(NSInteger)data leftNode:(TreeNode *)left rightNode:(TreeNode *)right {
    self = [super init];
    if (self == nil) return nil;
    _data = data;
    _left = left;
    _right = right;
    return self;
}

@end
