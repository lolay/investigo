#if DEBUG
#	define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#	define NSLog(...) NSLog(__VA_ARGS__)
#else
#	define DLog(fmt, ...) {}
#	define NSLog(...) {}
#endif
