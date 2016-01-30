//
//  Heap.swift
//  SortAlgorithms
//
//  Created by 纬洲 冯 on 1/28/16.
//  Copyright © 2016 dopcn. All rights reserved.
//

import Foundation

enum HeapError: ErrorType {
    case HeapUnderflow
    case HeapOperationError(message: String)
}

protocol HeapType {
    func parent(i: Int) -> Int
    func left(i: Int) -> Int
    func right(i: Int) -> Int
}

extension HeapType {
    func parent(i: Int) -> Int {
        return i/2
    }
    
    func left(i: Int) -> Int {
        return i*2
    }
    
    func right(i: Int) -> Int {
        return i*2 + 1
    }
}

struct MaxHeap<T: Comparable>: HeapType, CustomStringConvertible {
    var items: [T]
    var heapSize: Int
    
    var maxValue: T {
        return items[0]
    }
    
    var description: String {
        return items.description
    }
    
    private mutating func maxHeapify(i: Int) {
        let l = left(i), r = right(i)
        var largest = -1
        if l < heapSize && items[l] > items[i] {
            largest = l
        } else {
            largest = i
        }
        if r < heapSize && items[r] > items[largest] {
            largest = r
        }
        if largest != i {
            (items[largest], items[i]) = (items[i], items[largest])
            maxHeapify(largest)
        }
    }
    
    init(items: [T]) {
        self.items = items
        heapSize = items.count
        var i = items.count/2
        while i >= 0 {
            maxHeapify(i)
            i-=1
        }
    }
    
    mutating func extractMax() throws -> T {
        if heapSize < 1 {
            throw HeapError.HeapUnderflow
        }
        let max = items[0]
        (items[0], items[heapSize-1]) = (items[heapSize-1], items[0])
        items.removeLast()
        heapSize -= 1
        maxHeapify(0)
        return max
    }
    
    mutating func increase(location: Int, withKey key: T) throws {
        if key < items[location] {
            throw HeapError.HeapOperationError(message: "new key is less than original key")
        }
        items[location] = key
        var i = location
        while i > 0 && items[parent(i)] < items[i] {
            (items[parent(i)], items[i]) = (items[i], items[parent(i)])
            i = parent(i)
        }
    }
    
    mutating func insert(key: T) {
        heapSize += 1
        items.append(key)
        try! increase(items.count-1, withKey: key)
    }
    
}

struct MinHeap<T: Comparable>: HeapType {
    var heap: CFBinaryHeap
    
    init(items: [T]) {
        var callbacks = CFBinaryHeapCallBacks()
        //fail!!
        callbacks.compare = { (a,b,unused) in
            let a: T = UnsafePointer<T>(a).memory
            let b: T = UnsafePointer<T>(b).memory
            
            if ( a == b ) { return CFComparisonResult.CompareEqualTo }
            if ( a > b ) { return CFComparisonResult.CompareGreaterThan }
            return CFComparisonResult.CompareLessThan
        }
//        let callbackPointer = UnsafeMutablePointer<CFBinaryHeapCallBacks>.alloc(1)
//        callbackPointer.initialize(callbacks)
        heap = CFBinaryHeapCreate(kCFAllocatorDefault, 0, &callbacks, nil)
        for item in items {
            let pointer = UnsafeMutablePointer<T>.alloc(1)
            pointer.initialize(item)
            CFBinaryHeapAddValue(heap, pointer)
        }
    }
    
    var minValue: T {
        let min = UnsafePointer<T>(CFBinaryHeapGetMinimum(heap))
        return min.memory
    }
    
}

