

#import <Foundation/Foundation.h>

#define QF_SAFELY_RELEASE(__POINTER) { if (nil != (__POINTER)) { [__POINTER release]; __POINTER = nil;} }


@interface NSString (QFExtend)
- (NSString *)trim;

- (NSString *)encodeUnicode;
- (NSString *)decodeUnicode;

@end




