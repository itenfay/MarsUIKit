# MarsUIKit

[![Version](https://img.shields.io/cocoapods/v/MarsUIKit.svg?style=flat)](https://cocoapods.org/pods/MarsUIKit)
[![License](https://img.shields.io/cocoapods/l/MarsUIKit.svg?style=flat)](https://cocoapods.org/pods/MarsUIKit)
[![Platform](https://img.shields.io/cocoapods/p/MarsUIKit.svg?style=flat)](https://cocoapods.org/pods/MarsUIKit)

`MarsUIKit` wraps some commonly used UI components.

## Example

To use this pod, please see [CXSwiftKit_Example](https://github.com/chenxing640/CXSwiftKit.git).

## Requirements

* Xcode 13.0+, iOS 10.0

## Installation

`MarsUIKit` is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MarsUIKit'
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

## Author

chenxing, chenxing640@foxmail.com

## License

MarsUIKit is available under the MIT license. See the LICENSE file for more info.
