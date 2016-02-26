//
//  RFMMediatorFBANInterstitial.m
//  RFMSample
//
//  Created by Dean Chang on 12/21/15.
//  Copyright © 2015 Rubicon Project. All rights reserved.
//

#import "RFMMediatorFBANInterstitial.h"
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface RFMMediatorFBANInterstitial () <FBInterstitialAdDelegate>

@property (nonatomic, strong) FBInterstitialAd* interstitial;

@end

@implementation RFMMediatorFBANInterstitial

#pragma mark - RFMPartnerMediatorProtocol methods

// override
- (void)requestAdWithSize:(CGSize)size
                   adInfo:(NSDictionary*)adInfo
{
    NSString *adUnitId = adInfo[RFM_AD_MEDIATION_INFO_KEY][RFM_AD_MEDIATION_INFO_PLACEMENT_ID_KEY];
    self.interstitial = [[FBInterstitialAd alloc] initWithPlacementID:adUnitId];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

- (void)cancelRequest
{
    if(!self.interstitial)
        return;
    self.interstitial.delegate = nil;
    self.interstitial = nil;
}

#pragma mark - FBInterstitialAdDelegate methods

- (void)interstitialAdDidLoad:(FBInterstitialAd *)interstitialAd
{
    [self.delegate didFinishLoadingAd:nil];
    [self.interstitial showAdFromRootViewController:[self.delegate viewControllerForPresentingModalView]];
}

- (void)interstitialAd:(FBInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    [self.delegate didFailToLoadAdWithReason:[error localizedDescription]];
    [self cancelRequest];
    
}

- (void)interstitialAdDidClick:(FBInterstitialAd *)interstitialAd
{
    // Use this function as indication for a user's click on the ad.
    [self.delegate willPresentFullScreenModal];
}

- (void)interstitialAdWillClose:(FBInterstitialAd *)interstitialAd
{
    [self.delegate willDismissInterstitial];
}

- (void)interstitialAdDidClose:(FBInterstitialAd *)interstitialAd
{
    [self.delegate didDismissInterstitial];
}

@end
