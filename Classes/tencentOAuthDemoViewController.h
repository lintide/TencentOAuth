//
//  tencentOAuthDemoViewController.h
//  tencentOAuthDemo
//
//  Created by wanglin on 11-11-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TencentOAuth.h"

@interface tencentOAuthDemoViewController : UIViewController <TencentSessionDelegate> {
	TencentOAuth* _tencentOAuth;
	
    UIWindow *window;
	UIButton *_oauthButton;
	UIButton *_getUserInfoButton;
	UIButton *_addShareButton;
	UIButton *_uploadPicButton;
	UIButton *_listalbumButton;
	UIButton *_topicButton;
	UIButton *_listphotoButton;
	UIButton *_checkfansButton;
	UIButton *_addalbumButton;
	UIButton *_addblogButton;
	
	
	NSMutableArray* _permissions; 
	
	
	UILabel                *_labelTitle;
	UILabel                *_labelNickName;
	UILabel				   *_labelAddShare;
	UILabel				   *_labelUploadPic;
	UILabel				   *_labellistalbum;
	UILabel                *_labeltopic;
	UILabel                *_labellistphoto;
	UILabel                *_labelcheckfans;
	UILabel                *_labeladdalbum;
	UILabel                *_labeladdblog;
}

@end

