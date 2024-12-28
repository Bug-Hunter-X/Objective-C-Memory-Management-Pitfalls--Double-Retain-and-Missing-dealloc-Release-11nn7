In Objective-C, a common yet subtle issue arises when dealing with memory management, specifically with properties declared using `retain` or `copy`.  Consider this scenario:

```objectivec
@interface MyClass : NSObject
@property (retain) NSString *myString;
@end

@implementation MyClass
- (void)someMethod {
    self.myString = [[NSString alloc] initWithString:@"Hello"];
    // ... some code ...
}
@end
```

The problem:  While seemingly correct, this code leads to a memory leak. The `retain` property already increases the retain count of `myString`.  Manually allocating `myString` and assigning it using `self.myString = ...` causes *another* retain, leading to a double retain. When `someMethod` finishes, `myString` won't be released properly.

Another situation is forgetting to release objects in `dealloc`.  Always remember to release retained properties in the `dealloc` method to prevent memory leaks.

```objectivec
- (void)dealloc {
    [myString release];
    [super dealloc];
}
```
In modern Objective-C (ARC), this is handled automatically, but understanding this principle is crucial for working with legacy code or understanding memory management fundamentals.