//
//  RFMMediatorMoPubInterstitial.m
//  RFMSample
//
//  Created by Rubicon Project on 12/17/15.
//  Copyright © 2015 Rubicon Project. All rights reserved.
//

#import "RFMMediatorMoPubInterstitial.h"
#import "MPInterstitialAdController.h"

@interface RFMMediatorMoPubInterstitial() <MPInterstitialAdControllerDelegate>

@property (nonatomic, strong) MPInterstitialAdController *interstitial;

@end

@implementation RFMMediatorMoPubInterstitial

#pragma mark - RFMPartnerMediatorProtocol methods

// override
- (void)requestAdWithSize:(CGSize)size
                   adInfo:(NSDictionary*)adInfo
{
    NSString *adUnitId = adInfo[RFM_AD_MEDIATION_INFO_KEY][RFM_AD_MEDIATION_INFO_ADUNIT_ID_KEY];
    
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:adUnitId];
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

#pragma mark - MPInterstitialAdControllerDelegate methods

- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial
{
    [self.delegate didFinishLoadingAd:nil];
    if ([self.interstitial ready]) {
        [self.interstitial showFromViewController:[self.delegate viewControllerForPresentingModalView]];
    }
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial
{
    [self cancelRequest];
    [self.delegate didFailToLoadAdWithReason:nil];
}

- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial
{
    // TODO: what is proper expiration behavior?
    [self cancelRequest];
}

- (void)interstitialWillAppear:(MPInterstitialAdController *)interstitial
{
    [self.delegate willPresentFullScreenModal];
}

- (void)interstitialDidAppear:(MPInterstitialAdController *)interstitial
{
    [self.delegate didPresentFullScreenModal];
}

- (void)interstitialWillDisappear:(MPInterstitialAdController *)interstitial
{
    [self.delegate willDismissInterstitial];
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial
{
    [self.delegate didDismissInterstitial];
}

- (void)interstitialDidReceiveTapEvent:(MPInterstitialAdController *)interstitial
{

}

@end
