//
//  RbTreeWrapper.m
//  binaryTree
//
//  Created by 纬洲 冯 on 1/29/16.
//  Copyright © 2016 weizhou. All rights reserved.
//

#import "RbTreeWrapper.h"
@import Darwin;

@implementation RbTreeWrapper {
    rb_tree_t *rbtree;
}

typedef struct RBNode {
    int value;
    struct rb_node rb_node;
} RBNode;

static int compare_nodes(void *context, const void *n1, const void *n2) {
    const struct RBNode *node1 = n1;
    const struct RBNode *node2 = n2;
    
    return (node1->value - node2->value);
}

static int compare_key(void *context, const void *n, const void *key) {
    const struct RBNode *node = n;
    int ofs =  *(const int *)key;
    
    return (node->value - ofs);
}

static const rb_tree_ops_t ops = {
    .rbto_compare_nodes = compare_nodes,
    .rbto_compare_key = compare_key,
    .rbto_node_offset = offsetof(RBNode, rb_node),
    .rbto_context = NULL
};

- (instancetype)init {
    self = [super init];
    if (!self) { return nil; }
    rb_tree_init(rbtree, &ops);
    return self;
}

- (BOOL)lookup: (int)value {
    return rb_tree_find_node(rbtree, &value) != nil;
}



@end
