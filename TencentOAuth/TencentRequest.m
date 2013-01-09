
#import "TencentRequest.h"
//#import "JSON.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static NSString* kUserAgent = @"TencentConnect";
static NSString* kStringBoundary = @"od2ER5ioefd682HE14eh2n82n9M7rEu2nH85XQY1";  //3i2ndDfv2rTHiSisAbouNdArYfORhtTPEefj3q2f
static const int kGeneralErrorCode = 10000;
static const NSTimeInterval kTimeoutInterval = 180.0;

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TencentRequest

@synthesize delegate = _delegate,
url = _url,
httpMethod = _httpMethod,
params = _params,
connection = _connection,
responseText = _responseText;

//////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (TencentRequest *)getRequestWithParams:(NSMutableDictionary *) params
                         httpMethod:(NSString *) httpMethod
                           delegate:(id<TencentRequestDelegate>) delegate
                         requestURL:(NSString *) url {
	
	TencentRequest* request = [[[TencentRequest alloc] init] autorelease];
	request.delegate = delegate;
	request.url = url;
	request.httpMethod = httpMethod;
	request.params = params;
	request.connection = nil;
	request.responseText = nil;
	
	return request;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

+ (NSString *)serializeURL:(NSString *)baseUrl
					params:(NSDictionary *)params {
	return [self serializeURL:baseUrl params:params httpMethod:@"GET"];
}

/**
 * Generate get URL
 */
+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params
               httpMethod:(NSString *)httpMethod {
	
	NSURL* parsedURL = [NSURL URLWithString:baseUrl];
	NSString* queryPrefix = parsedURL.query ? @"&" : @"?";
	
	NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [params keyEnumerator]) {
		if (([[params valueForKey:key] isKindOfClass:[UIImage class]])
			||([[params valueForKey:key] isKindOfClass:[NSData class]])) {
			if ([httpMethod isEqualToString:@"GET"]) {
				NSLog(@"can not use GET to upload a file");
			}
			continue;
		}
		
		NSString* escaped_value = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																					  NULL, /* allocator */
																					  (CFStringRef)[params objectForKey:key],
																					  NULL, /* charactersToLeaveUnescaped */
																					  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																					  kCFStringEncodingUTF8);
		
		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
		[escaped_value release];
	}
	NSString* query = [pairs componentsJoinedByString:@"&"];
	
	return [NSString stringWithFormat:@"%@%@%@", baseUrl, queryPrefix, query];
}

/**
 * Body append for POST method
 */
- (void)utfAppendBody:(NSMutableData *)body data:(NSString *)data {
	[body appendData:[data dataUsingEncoding:NSUTF8StringEncoding]];
}

/**
 * Generate body for POST method
 */
- (NSMutableData *)generatePostBody {
	NSMutableData *body = [NSMutableData data];
	NSString *endLine = [NSString stringWithFormat:@"\r\n--%@\r\n", kStringBoundary];
	NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionary];
	
	[self utfAppendBody:body data:[NSString stringWithFormat:@"--%@\r\n", kStringBoundary]];
	
	for (id key in [_params keyEnumerator]) {
		
		if (([[_params valueForKey:key] isKindOfClass:[UIImage class]])
			||([[_params valueForKey:key] isKindOfClass:[NSData class]])) {
			
			[dataDictionary setObject:[_params valueForKey:key] forKey:key];
			continue;
			
		}
		
		[self utfAppendBody:body
					   data:[NSString
							 stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",
							 key]];
		[self utfAppendBody:body data:[_params valueForKey:key]];
		
		[self utfAppendBody:body data:endLine];
	}
	
	if ([dataDictionary count] > 0) {
		for (id key in dataDictionary) {
			NSObject *dataParam = [dataDictionary valueForKey:key];
			if ([dataParam isKindOfClass:[UIImage class]]) {
				NSData* imageData = UIImagePNGRepresentation((UIImage*)dataParam);
				[self utfAppendBody:body
							   data:[NSString stringWithFormat:
									 @"Content-Disposition: form-data; filename=\"%@\"\r\n", key]];
				[self utfAppendBody:body
							   data:@"Content-Type: image/png\r\n\r\n"];
				[body appendData:imageData];
			} else {
				NSAssert([dataParam isKindOfClass:[NSData class]],
						 @"dataParam must be a UIImage or NSData");
				[self utfAppendBody:body
							   data:[NSString stringWithFormat:
									 @"Content-Disposition: form-data; filename=\"%@\"\r\n", key]];
				[self utfAppendBody:body
							   data:@"Content-Type: content/unknown\r\n\r\n"];
				[body appendData:(NSData*)dataParam];
			}
			[self utfAppendBody:body data:endLine];
			
		}
	}
//	NSString *strtr=[[NSString alloc]initWithData:body encoding:NSUTF8StringEncoding];

	return body;
}

/**
 * Generate body for OtherPOST method
 */
- (NSData *)generateOtherPostBody {
	NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [_params keyEnumerator]) {
		
		
		NSString* escaped_value = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																					  NULL, /* allocator */
																					  (CFStringRef)[_params objectForKey:key],
																					  NULL, /* charactersToLeaveUnescaped */
																					  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																					  kCFStringEncodingUTF8);
		
		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
		[escaped_value release];
	}
	NSString* query = [pairs componentsJoinedByString:@"&"];
	

	NSData *body = [query dataUsingEncoding:NSUTF8StringEncoding];
	
	
	
	//NSString *strtr=[[NSString alloc]initWithData:body encoding:NSUTF8StringEncoding];
	//NSLog(@"body体:%@",strtr);
	return body;
}

/**
 * Formulate the NSError
 */
- (id)formError:(NSInteger)code userInfo:(NSDictionary *) errorData {
	return [NSError errorWithDomain:@"tencentErrDomain" code:code userInfo:errorData];
	
}

/**
 * parse the response data
 */
- (id)parseJsonResponse:(NSData *)data error:(NSError **)error {
	
	//NSData returnData ；
	//char* bu=[data bytes];
	//for (int i=0; i<[returnData  length];i++){
	//	NSLog(@"打印数据：%d"，bu[i]);
	//}
	
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	
	NSString* responseString = [[[NSString alloc] initWithData:data
													  encoding:NSUTF8StringEncoding]
								autorelease];
	
	if (!responseString) {
		responseString=[[NSString alloc]initWithData:data encoding:enc];
	}
	NSLog(@"%@",[[NSString alloc]initWithData:data encoding:enc]);
	
	NSLog(@"%@",responseString);
//	SBJSON *jsonParser = [[SBJSON new] autorelease];
    JSONDecoder *jsonParser = [[JSONDecoder alloc] init];
	if ([responseString isEqualToString:@"true"]) {
		return [NSDictionary dictionaryWithObject:@"true" forKey:@"result"];
	} else if ([responseString isEqualToString:@"false"]) {
		if (error != nil) {
			*error = [self formError:kGeneralErrorCode
							userInfo:[NSDictionary
									  dictionaryWithObject:@"This operation can not be completed"
									  forKey:@"error_msg"]];
		}
		return nil;
	}
	
	
	id result = [jsonParser objectWithData:data];
	
	
	if (![result isKindOfClass:[NSArray class]]) {
		if ([result objectForKey:@"error"] != nil) {
			if (error != nil) {
				*error = [self formError:kGeneralErrorCode
								userInfo:result];
			}
			return nil;
		}
		
		if ([result objectForKey:@"error_code"] != nil) {
			if (error != nil) {
				*error = [self formError:[[result objectForKey:@"error_code"] intValue] userInfo:result];
			}
			return nil;
		}
		
		if ([result objectForKey:@"error_msg"] != nil) {
			if (error != nil) {
				*error = [self formError:kGeneralErrorCode userInfo:result];
			}
		}
		
		if ([result objectForKey:@"error_reason"] != nil) {
			if (error != nil) {
				*error = [self formError:kGeneralErrorCode userInfo:result];
			}
		}
	}
	
	return result;
	
}

/*
 * private helper function: call the delegate function when the request
 *                          fails with error
 */
- (void)failWithError:(NSError *)error {
	if ([_delegate respondsToSelector:@selector(request:didFailWithError:)]) {
		[_delegate request:self didFailWithError:error];
	}
}

/*
 * private helper function: handle the response data
 */
- (void)handleResponseData:(NSData *)data {
	if ([_delegate respondsToSelector:
		 @selector(request:didLoadRawResponse:)]) {
		[_delegate request:self didLoadRawResponse:data];
	}
	
	if ([_delegate respondsToSelector:@selector(request:didLoad:)] ||
		[_delegate respondsToSelector:
		 @selector(request:didFailWithError:)]) {
			NSError* error = nil;
			id result = [self parseJsonResponse:data error:&error];
			
			if (error) {
				[self failWithError:error];
			} else if ([_delegate respondsToSelector:
						@selector(request:didLoad:dat:)]) {
				[_delegate request:self didLoad:(result == nil ? data : result) dat:data];
			}
			
		}
	
}



//////////////////////////////////////////////////////////////////////////////////////////////////
// public

/**
 * @return boolean - whether this request is processing
 */
- (BOOL)loading {
	return !!_connection;
}

/**
 * make the request
 */
- (void)connect {
	
	if ([_delegate respondsToSelector:@selector(requestLoading:)]) {
		[_delegate requestLoading:self];
	}
	NSLog(@"%@",_httpMethod);
	NSString* url=_url;
	if ([_httpMethod isEqualToString:@"GET"]) {
	
	 url = [[self class] serializeURL:_url params:_params httpMethod:_httpMethod];
	}
	NSLog(@"%@",url);
	NSMutableURLRequest* request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                        timeoutInterval:kTimeoutInterval];
	[request setValue:kUserAgent forHTTPHeaderField:@"User-Agent"];
	
	
	[request setHTTPMethod:self.httpMethod];
	if ([self.httpMethod isEqualToString: @"POST"]) {
		NSRange range = [url rangeOfString:@"upload_pic"];
		int location = range.location;
	
		if(location<[url length]){
		NSString* contentType = [NSString
								 stringWithFormat:@"multipart/form-data; boundary=%@", kStringBoundary];
		[request setValue:contentType forHTTPHeaderField:@"Content-Type"];
		
		[request setHTTPBody:[self generatePostBody]];
		}
		else {
		[request setHTTPBody:[self generateOtherPostBody]];
		}

		
	}
	
	_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
}

/**
 * Free internal structure
 */
- (void)dealloc {
	[_connection cancel];
	[_connection release];
	[_responseText release];
	[_url release];
	[_httpMethod release];
	[_params release];
	[super dealloc];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
// NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	_responseText = [[NSMutableData alloc] init];
	
	NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
	if ([_delegate respondsToSelector:
		 @selector(request:didReceiveResponse:)]) {
		[_delegate request:self didReceiveResponse:httpResponse];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_responseText appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[self handleResponseData:_responseText];
	
	[_responseText release];
	_responseText = nil;
	[_connection release];
	_connection = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[self failWithError:error];
	
	[_responseText release];
	_responseText = nil;
	[_connection release];
	_connection = nil;
}

@end
