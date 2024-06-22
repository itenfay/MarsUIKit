# MarsUIKit

[![Version](https://img.shields.io/cocoapods/v/MarsUIKit.svg?style=flat)](https://cocoapods.org/pods/MarsUIKit)
[![License](https://img.shields.io/cocoapods/l/MarsUIKit.svg?style=flat)](https://cocoapods.org/pods/MarsUIKit)
[![Platform](https://img.shields.io/cocoapods/p/MarsUIKit.svg?style=flat)](https://cocoapods.org/pods/MarsUIKit)

`MarsUIKit` wraps some commonly used UI components.

## Example

To use this library, please go to **[here](https://github.com/itenfay/FireKylin.git)**!.

## Requirements

* Xcode 14.0+, iOS 11.0, tvOS 11.0

## Installation

`MarsUIKit` is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
# MarsUIKit
pod 'MarsUIKit'
# EmptyDataSet
pod 'MarsUIKit/EmptyDataSet'
# RxEmptyDataSet
pod 'MarsUIKit/RxEmptyDataSet'
# RxMJRefresh
pod 'MarsUIKit/RxMJRefresh'
# RxKafkaRefresh
pod 'MarsUIKit/RxKafkaRefresh'
# OverlayView
pod 'MarsUIKit/OverlayView'
# Messages
pod 'MarsUIKit/Messages'
# Toast
pod 'MarsUIKit/Toast'
# SVGA
pod 'MarsUIKit/SVGA'
```

## Handling Error

if `SVGAPlayer` library occurs this error：

```
Conflicting types for 'OSAtomicCompareAndSwapPtrBarrier'
Implicit declaration of function 'OSAtomicCompareAndSwapPtrBarrier' is invalid in C99
```

> if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
>    [worker release];
> }

Add the header in `Svga.pbobjc.m` or `Svga.pbobjc.h`.

```
#import <libkern/OSAtomic.h>
```

## License

MarsUIKit is available under the MIT license. See the LICENSE file for more info.

## Feedback is welcome

If you notice any issue to create an issue. I will be happy to help you.
