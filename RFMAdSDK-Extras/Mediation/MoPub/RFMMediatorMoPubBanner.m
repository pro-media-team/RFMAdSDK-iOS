//
//  RFMMediatorMoPubBanner.m
//  RFMSample
//
//  Created by Dean Chang on 12/17/15.
//  Copyright © 2015 Rubicon Project. All rights reserved.
//

#import "RFMMediatorMoPubBanner.h"
#import "MPAdView.h"

@interface RFMMediatorMoPubBanner() <MPAdViewDelegate>

@property (nonatomic, strong) MPAdView *bannerView;

@end

@implementation RFMMediatorMoPubBanner

#pragma mark - RFMPartnerMediatorProtocol methods

// override
- (void)requestAdWithSize:(CGSize)size
                   adInfo:(NSDictionary*)adInfo
{
    NSString *adUnitId = adInfo[RFM_AD_MEDIATION_INFO_KEY][RFM_AD_MEDIATION_INFO_ADUNIT_ID_KEY];
    
    self.bannerView = [[MPAdView alloc] initWithAdUnitId:adUnitId
                                                    size:size];
    self.bannerView.delegate = self;
    self.bannerView.accessibilityLabel = @"banner";
    self.bannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.bannerView loadAd];
}

- (void)cancelRequest
{
    if(!self.bannerView)
        return;
    [self.bannerView stopAutomaticallyRefreshingContents];
    self.bannerView.delegate = nil;
    [self.bannerView removeFromSuperview];
    self.bannerView = nil;
}

#pragma mark - MPAdViewDelegate methods

//- (UIViewController *)viewControllerForPresentingModalView
//{
//    return [self.delegate viewControllerForPresentingModalView];
//}

- (void)adViewDidLoadAd:(MPAdView *)view
{
    [self.delegate didFinishLoadingAd:view];
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view
{
    [self.delegate didFailToLoadAdWithReason:nil];
}

- (void)willPresentModalViewForAd:(MPAdView *)view
{
    [self.delegate willPresentFullScreenModal];
}

- (void)didDismissModalViewForAd:(MPAdView *)view
{
    [self.delegate didDismissFullScreenModal];
}

- (void)willLeaveApplicationFromAd:(MPAdView *)view
{
    
}

@end
