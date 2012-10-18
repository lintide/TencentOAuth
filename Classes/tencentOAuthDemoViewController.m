//
//  tencentOAuthDemoViewController.m
//  tencentOAuthDemo
//
//  Created by wanglin on 11-11-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "tencentOAuthDemoViewController.h"

@implementation tencentOAuthDemoViewController


/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	_oauthButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 40)];
	[_oauthButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_oauthButton setTitle:@"OAuth登陆" forState:UIControlStateNormal];
	[_oauthButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_oauthButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_oauthButton addTarget:self action:@selector(onClickTencentOAuth) forControlEvents:UIControlEventTouchUpInside];
	[_oauthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_oauthButton];
	
	_getUserInfoButton = [[UIButton alloc] initWithFrame:CGRectMake(20,65, 100, 40)];
	[_getUserInfoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_getUserInfoButton setTitle:@"获取用户信息" forState:UIControlStateNormal];
	[_getUserInfoButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_getUserInfoButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_getUserInfoButton addTarget:self action:@selector(onClickGetUserInfo) forControlEvents:UIControlEventTouchUpInside];
	[_getUserInfoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_getUserInfoButton];
	_getUserInfoButton.enabled = NO;
	
	_addShareButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 110, 100, 40)];
	[_addShareButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_addShareButton setTitle:@"分享" forState:UIControlStateNormal];
	[_addShareButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_addShareButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_addShareButton addTarget:self action:@selector(onClickAddShare) forControlEvents:UIControlEventTouchUpInside];
	[_addShareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_addShareButton];
	_addShareButton.enabled = NO;
	
	_uploadPicButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 155, 100, 40)];
	[_uploadPicButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_uploadPicButton setTitle:@"上传图片" forState:UIControlStateNormal];
	[_uploadPicButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_uploadPicButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_uploadPicButton addTarget:self action:@selector(onClickUploadPic) forControlEvents:UIControlEventTouchUpInside];
	[_uploadPicButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_uploadPicButton];
	_uploadPicButton.enabled = NO;
	
	
	_listalbumButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 100, 40)];
	[_listalbumButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_listalbumButton setTitle:@"获取相册列表" forState:UIControlStateNormal];
	[_listalbumButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_listalbumButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_listalbumButton addTarget:self action:@selector(onClickListalbum) forControlEvents:UIControlEventTouchUpInside];
	[_listalbumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_listalbumButton];
	_listalbumButton.enabled = NO;
	
	
	_topicButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 245, 100, 40)];
	[_topicButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_topicButton setTitle:@"发表说说" forState:UIControlStateNormal];
	[_topicButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_topicButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_topicButton addTarget:self action:@selector(onClickTopic) forControlEvents:UIControlEventTouchUpInside];
	[_topicButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_topicButton];
	_topicButton.enabled = NO;
	
	
	_listphotoButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 290, 100, 40)];
	[_listphotoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_listphotoButton setTitle:@"获取照片列表" forState:UIControlStateNormal];
	[_listphotoButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_listphotoButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_listphotoButton addTarget:self action:@selector(onClickListPhoto) forControlEvents:UIControlEventTouchUpInside];
	[_listphotoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_listphotoButton];
	_listphotoButton.enabled = NO;
	
	_checkfansButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 335, 100, 40)];
	[_checkfansButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_checkfansButton setTitle:@"验证空间粉丝" forState:UIControlStateNormal];
	[_checkfansButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_checkfansButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_checkfansButton addTarget:self action:@selector(onClickCheckFans) forControlEvents:UIControlEventTouchUpInside];
	[_checkfansButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_checkfansButton];
	_checkfansButton.enabled = NO;
	
	_addalbumButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 380, 100, 40)];
	[_addalbumButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_addalbumButton setTitle:@"创建空间相册" forState:UIControlStateNormal];
	[_addalbumButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_addalbumButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_addalbumButton addTarget:self action:@selector(onClickAddAlbum) forControlEvents:UIControlEventTouchUpInside];
	[_addalbumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_addalbumButton];
	_addalbumButton.enabled = NO;
	
	_addblogButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 425, 100, 40)];
	[_addblogButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
	[_addblogButton setTitle:@"发表日志" forState:UIControlStateNormal];
	[_addblogButton setBackgroundImage:[[UIImage imageNamed:@"buttonnormal.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateNormal];
	[_addblogButton setBackgroundImage:[[UIImage imageNamed:@"buttonhover.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:21] forState:UIControlStateHighlighted];
	[_addblogButton addTarget:self action:@selector(onClickAddBlog) forControlEvents:UIControlEventTouchUpInside];
	[_addblogButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_addblogButton];
	_addblogButton.enabled = NO;
	
	
	
	
	
	
	_labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 200, 15)];
	[self.view addSubview:_labelTitle];
	[_labelTitle setFont:[UIFont systemFontOfSize:15.0f]];
	[_labelTitle setBackgroundColor:[UIColor clearColor]];
	
	_labelNickName = [[UILabel alloc] initWithFrame:CGRectMake(130, 75, 200, 15)];
	[self.view addSubview:_labelNickName];
	[_labelNickName setFont:[UIFont systemFontOfSize:15.0f]];
	[_labelNickName setBackgroundColor:[UIColor clearColor]];
	//[_labelNickName setTextColor:RGBCOLOR(85, 85, 85)];
	
	_labelAddShare = [[UILabel alloc] initWithFrame:CGRectMake(130, 120, 200, 15)];
	[self.view addSubview:_labelAddShare];
	[_labelAddShare setFont:[UIFont systemFontOfSize:15.0f]];
	[_labelAddShare setBackgroundColor:[UIColor clearColor]];
	
	_labelUploadPic = [[UILabel alloc] initWithFrame:CGRectMake(130, 165, 200, 15)];
	[self.view addSubview:_labelUploadPic];
	[_labelUploadPic setFont:[UIFont systemFontOfSize:15.0f]];
	[_labelUploadPic setBackgroundColor:[UIColor clearColor]];
	
	
	_labellistalbum = [[UILabel alloc] initWithFrame:CGRectMake(130, 210, 200, 15)];
	[self.view addSubview:_labellistalbum];
	[_labellistalbum setFont:[UIFont systemFontOfSize:15.0f]];
	[_labellistalbum setBackgroundColor:[UIColor clearColor]];
	
	
	_labeltopic = [[UILabel alloc] initWithFrame:CGRectMake(130, 255, 200, 15)];
	[self.view addSubview:_labeltopic];
	[_labeltopic setFont:[UIFont systemFontOfSize:15.0f]];
	[_labeltopic setBackgroundColor:[UIColor clearColor]];
	
	_labellistphoto= [[UILabel alloc] initWithFrame:CGRectMake(130, 300, 200, 15)];
	[self.view addSubview:_labellistphoto];
	[_labellistphoto setFont:[UIFont systemFontOfSize:15.0f]];
	[_labellistphoto setBackgroundColor:[UIColor clearColor]];
	
	
	_labelcheckfans= [[UILabel alloc] initWithFrame:CGRectMake(130, 345, 200, 15)];
	[self.view addSubview:_labelcheckfans];
	[_labelcheckfans setFont:[UIFont systemFontOfSize:15.0f]];
	[_labelcheckfans setBackgroundColor:[UIColor clearColor]];
	
	_labeladdalbum= [[UILabel alloc] initWithFrame:CGRectMake(130, 390, 200, 15)];
	[self.view addSubview:_labeladdalbum];
	[_labeladdalbum setFont:[UIFont systemFontOfSize:15.0f]];
	[_labeladdalbum setBackgroundColor:[UIColor clearColor]];
	
	
	_labeladdblog= [[UILabel alloc] initWithFrame:CGRectMake(130, 435, 200, 15)];
	[self.view addSubview:_labeladdblog];
	[_labeladdblog setFont:[UIFont systemFontOfSize:15.0f]];
	[_labeladdblog setBackgroundColor:[UIColor clearColor]];
	
	
	_permissions =  [[NSArray arrayWithObjects:
					  @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album", 
					  @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
	
	
	_tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"222222"
											andDelegate:self];
	_tencentOAuth.redirectURI = @"www.qq.com";
	
	
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/**
 * tencentOAuth
 */
- (void)onClickTencentOAuth {
	_labelTitle.text = @"开始获取token";
	[_tencentOAuth authorize:_permissions inSafari:NO];
}
/**
 * Get user info.
 */
- (void)onClickGetUserInfo {
	_labelNickName.text = @"开始获取用户基本信息";
	[_tencentOAuth getUserInfo];
}
/**
 * add Share.
 */
- (void)onClickAddShare {
	_labelAddShare.text = @"开始分享";
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"腾讯内部addShare接口测试", @"title",
								   @"http://www.qq.com", @"url",
								   @"风云乔帮主",@"comment",
								   @"乔布斯被认为是计算机与娱乐业界的标志性人物，同时人们也把他视作麦金塔计算机、iPod、iTunes、iPad、iPhone等知名数字产品的缔造者，这些风靡全球亿万人的电子产品，深刻地改变了现代通讯、娱乐乃至生活的方式。",@"summary",
								   @"http://img1.gtimg.com/tech/pics/hv1/95/153/847/55115285.jpg",@"images",
								   @"4",@"source",
								   nil];
	
	[_tencentOAuth addShareWithParams:params];
}
/**
 * uploadPic
 */
- (void)onClickUploadPic {
	_uploadPicButton.enabled = NO;
	_labelUploadPic.text = @"开始上传图片";
	NSString *path = @"http://img1.gtimg.com/tech/pics/hv1/95/153/847/55115285.jpg";
	NSURL *url = [NSURL URLWithString:path];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *img  = [[UIImage alloc] initWithData:data];
	
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   img, @"picture",
								   _labeladdalbum.text,@"albumid",
								   @"风云乔布斯",@"title",
								   @"比天皇巨星还天皇巨星的天皇巨星",@"photodesc",
	 							   nil];
	
	[_tencentOAuth uploadPicWithParams:params];
	
	[img release];
	
}
/**
 * Get list album.
 */
- (void)onClickListalbum{
	
	_labellistalbum.text = @"开始获取相册列表";
	[_tencentOAuth getListAlbum];
}


/**
 * Add Album.
 */
- (void)onClickAddAlbum{
	
	_labeladdalbum.text = @"开始创建空间相册";
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"iosSDK接口测试相册", @"albumname",
								   @"我的测试相册",@"albumdesc",
								   @"1",@"priv",
								   nil];
	
	[_tencentOAuth addAlbumWithParams:params];
}
/**
 * Add Blog.
 */
- (void)onClickAddBlog{
	
	_labeladdblog.text = @"开始发表空间日志";
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"iosSDK日志测试", @"title",
								   @"哈哈,测试成功", @"content",
								   
								   nil];
	[_tencentOAuth addOneBlogWithParams:params];
}

/**
 * upTopic.
 */
-(void)onClickTopic{
	
	_labeltopic.text = @"正在发表";
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"腾讯addtopic接口测试--失控小警察视频参数", @"con",
								   @"3",@"richtype",
								   @"http://www.tudou.com/programs/view/C0FuB0FTv50/",@"richval",
								   @"广东省深圳市南山区高新科技园腾讯大厦",@"lbs_nm",
								   @"2",@"third_source",
								   
								   nil];
	
	[_tencentOAuth addTopicWithParams:params];
}
/**
 * Get List Photo.
 */
-(void)onClickListPhoto{
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   _labeladdalbum.text, @"albumid",
								   nil];
	_labellistphoto.text = @"开始获取照片列表";
	
	[_tencentOAuth getListPhotoWithParams:params];
}
/**
 * Check Fans.
 */
-(void) onClickCheckFans{
	_labelcheckfans.text = @"正在验证空间粉丝";
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"973751360", @"page_id",
								   nil];
	
	[_tencentOAuth checkPageFansWithParams:params];
	
}

/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin {
	// 登录成功
	_labelTitle.text = @"token获取成功";
	_getUserInfoButton.enabled = YES;
	_addShareButton.enabled = YES;
	_uploadPicButton.enabled = NO;
	_listalbumButton.enabled = YES;
	_topicButton.enabled = YES;
	_listphotoButton.enabled = NO;
	_checkfansButton.enabled = YES;
	_addalbumButton.enabled = YES;
	_addblogButton.enabled = YES;
	
	
	_labelNickName.text=@"";
	_labelAddShare.text=@"";
	_labelUploadPic.text=@"";
	_labellistalbum.text=@"";
	_labeltopic.text=@"";
	_labellistphoto.text=@"";
	_labelcheckfans.text=@"";
	_labeladdalbum.text=@"";
	_labeladdblog.text=@"";	
	
	
}


/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	if (cancelled){
		_labelTitle.text = @"用户取消登录";
	}
	else {
		_labelTitle.text = @"登录失败";
	}
	
}

/**
 * Called when the notNewWork.
 */
-(void)tencentDidNotNetWork
{
	_labelTitle.text=@"无网络连接，请设置网络";
}
/**
 * Called when the get_user_info has response.
 */
- (void)getUserInfoResponse:(APIResponse*) response {
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];		
		for (id key in response.jsonResponse) {			
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	_labelNickName.text=@"获取个人信息完成";
}

/**
 * Called when the add_share has response.
 */
- (void)addShareResponse:(APIResponse*) response {
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];		
		for (id key in response.jsonResponse) {			
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles:nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
	_labelAddShare.text=@"分享完成";
	
}
/**
 * Called when the uploadPic has response.
 */
- (void)uploadPicResponse:(APIResponse*) response {
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];		
		for (id key in response.jsonResponse) {			
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	_uploadPicButton.enabled = YES;
	_labelUploadPic.text=@"操作完成";
	
}
/**
 * Called when the getListAlbum has response.
 */
-(void)getListAlbumResponse:(APIResponse*) response {
	NSMutableString *str=[NSMutableString stringWithFormat:@""];		
	for (id key in response.jsonResponse) {			
		[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
	}
	
	
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[[NSString stringWithFormat:@"%@",str] decodeUnicode]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
	_labellistalbum.text=@"获取相册列表完成";
	
}
/**
 * Called when the getListPhoto has response.
 */
-(void)getListPhotoResponse:(APIResponse*) response {
	NSMutableString *str=[NSMutableString stringWithFormat:@""];		
	for (id key in response.jsonResponse) {			
		[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
	}
	
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[[NSString stringWithFormat:@"%@",str] decodeUnicode]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
	_labellistphoto.text=@"获取照片列表完成";
	
}
/**
 * Called when the addTopic has response.
 */
-(void)addTopicResponse:(APIResponse*) response {
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];		
		for (id key in response.jsonResponse) {			
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
	_labeltopic.text=@"发表说说完成";
	
}

/**
 * Called when the checkPageFans has response.
 */
-(void)checkPageFansResponse:(APIResponse*) response {
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];		
		for (id key in response.jsonResponse) {			
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		if ([[NSString stringWithFormat:@"%@",[response.jsonResponse objectForKey:@"isfans"]] isEqualToString:@"1"]) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您是冷兔的粉丝" message:[NSString stringWithFormat:@"%@",str]
								  
														   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
			[alert show];
			
			_labelcheckfans.text=@"您是冷兔的粉丝";
			
		}
		else {
			
			
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您不是冷兔的粉丝" message:[NSString stringWithFormat:@"%@",str]
								  
														   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
			[alert show];
			_labelcheckfans.text=@"您不是冷兔的粉丝";
		}
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
}
/**
 * Called when the addAlbum has response.
 */


- (void)addAlbumResponse:(APIResponse*) response{
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];		
		for (id key in response.jsonResponse) {			
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		_labeladdalbum.text=[NSString stringWithFormat:@"%@",[response.jsonResponse objectForKey:@"albumid"]];
		
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		_listphotoButton.enabled=YES;
		_uploadPicButton.enabled = YES;
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
}

/**
 * Called when the addOneBlog has response.
 */
- (void)addOneBlogResponse:(APIResponse*) response{
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];		
		for (id key in response.jsonResponse) {			
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
	_labeladdblog.text=@"发表日志完成";
}



- (void)dealloc {
	[_oauthButton release];
	[_permissions release];
	[_tencentOAuth release];
	[_labelNickName release];
	[_getUserInfoButton release];
	[_addShareButton release];
	[_uploadPicButton release];
	[_labelTitle release];
	[_labelAddShare release];
	[_labelUploadPic release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

//TencentRequestDelegate

/**
 * Handle the auth.ExpireSession api call failure
 */
- (void)request:(TencentRequest*)request didFailWithError:(NSError*)error{
	//NSString *errorInfo = [error localizedDescription];
	NSLog(@"Failed to expire the session");
}

- (void)request:(TencentRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"received response");
}



/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(TencentRequest *)request didLoad:(id)result dat:(NSData *)data{
	if ([result isKindOfClass:[NSDictionary class]]) {
		NSDictionary *root = (NSDictionary *)result;
		if ([[root allKeys] count] == 0) {
			NSLog(@"received didLoad error");
			return;
		}
	}
};

@end
