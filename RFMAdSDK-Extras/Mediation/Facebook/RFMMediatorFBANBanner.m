//
//  RFMMediatorFBANBanner.m
//  RFMSample
//
//  Created by Rubicon Project on 12/21/15.
//  Copyright © 2015 Rubicon Project. All rights reserved.
//

#import "RFMMediatorFBANBanner.h"
#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import <FBAudienceNetwork/FBAdSize.h>

@interface RFMMediatorFBANBanner () <FBAdViewDelegate>

@property (nonatomic, strong) FBAdView *bannerView;


@end

@implementation RFMMediatorFBANBanner

#pragma mark - RFMPartnerMediatorProtocol methods

// override
- (void)requestAdWithSize:(CGSize)size
                   adInfo:(NSDictionary*)adInfo
{
    NSString *adUnitId = adInfo[RFM_AD_MEDIATION_INFO_KEY][RFM_AD_MEDIATION_INFO_PLACEMENT_ID_KEY];
    struct FBAdSize fbSize;
    fbSize.size = size;
    self.bannerView = [[FBAdView alloc] initWithPlacementID:adUnitId
                                                     adSize:fbSize
                                         rootViewController:[self.delegate viewControllerForPresentingModalView]];
    
    self.bannerView.delegate = self;
    [self.bannerView loadAd];
}

- (void)cancelRequest
{
    if(!self.bannerView)
        return;
    [self.bannerView disableAutoRefresh];
    self.bannerView.delegate = nil;
    [self.bannerView removeFromSuperview];
    self.bannerView = nil;
}

#pragma mark - FBAdViewDelegate methods

- (void)adViewDidClick:(FBAdView *)adView
{
    [self.delegate willPresentFullScreenModal];
}

- (void)adViewDidFinishHandlingClick:(FBAdView *)adView
{
    [self.delegate didDismissFullScreenModal];
}

- (void)adViewDidLoad:(FBAdView *)adView
{
    [self.delegate didFinishLoadingAd:adView];
}

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error
{
    [self.delegate didFailToLoadAdWithReason:[error localizedDescription]];
}

@end
