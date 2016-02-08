//
//  RFMMediatorDFP.m
//  RFMAdSDK
//
//  Created by Rubicon Project on 10/22/15.
//  Copyright © 2015 Rubicon Project. All rights reserved.
//

#import "RFMMediatorAdmDFPBanner.h"
#import <RFMAdSDk/RFMAdSDK.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface RFMMediatorAdmDFPBanner() <GADBannerViewDelegate>

@property (strong, nonatomic) DFPBannerView *bannerView;

@end

@implementation RFMMediatorAdmDFPBanner

#pragma mark - RFMPartnerMediatorProtocol methods

// override
- (void)requestAdWithSize:(CGSize)size
                   adInfo:(NSDictionary*)adInfo
{
    NSString *adUnitId = adInfo[RFM_AD_MEDIATION_INFO_KEY][RFM_AD_MEDIATION_INFO_ADUNIT_ID_KEY];
    GADAdSize customAdSize = GADAdSizeFromCGSize(size);
    self.bannerView = [[DFPBannerView alloc] initWithAdSize:customAdSize];
//    self.bannerView.adUnitID = @"/6499/example/banner";
    self.bannerView.adUnitID = adUnitId;
    self.bannerView.rootViewController = [self.delegate viewControllerForPresentingModalView];
    self.bannerView.delegate = self;
    [self.bannerView loadRequest:[DFPRequest request]];
}

- (void)cancelRequest
{
    if(!self.bannerView)
        return;
    self.bannerView.rootViewController = nil;
    self.bannerView.delegate = nil;
    [self.bannerView removeFromSuperview];
    self.bannerView = nil;
}

#pragma mark - GADBannerViewDelegate methods

- (void)adViewDidReceiveAd:(DFPBannerView *)bannerView
{
    [self.delegate didFinishLoadingAd:bannerView];
}

- (void)adView:(DFPBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    [self.delegate didFailToLoadAdWithReason:[error localizedDescription]];
}

- (void)adViewWillPresentScreen:(DFPBannerView *)bannerView
{
    [self.delegate willPresentFullScreenModal];
}

- (void)adViewDidDismissScreen:(DFPBannerView *)bannerView
{
    [self.delegate didDismissFullScreenModal];
}

- (void)adViewWillDismissScreen:(DFPBannerView *)bannerView
{
    [self.delegate willDismissFullScreenModal];
}

- (void)adViewWillLeaveApplication:(DFPBannerView *)bannerView
{

}

@end
