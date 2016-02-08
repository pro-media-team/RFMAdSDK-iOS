//
//  RFMMediatorDFPInterstitial.m
//  RFMSample
//
//  Created by Rubicon Project on 10/28/15.
//  Copyright © 2015 Rubicon Project. All rights reserved.
//

#import "RFMMediatorAdmDFPInterstitial.h"
#import <RFMAdSDk/RFMAdSDK.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface RFMMediatorAdmDFPInterstitial() <GADInterstitialDelegate>

@property (strong, nonatomic) DFPInterstitial *interstitial;

@end

@implementation RFMMediatorAdmDFPInterstitial

#pragma mark - RFMPartnerMediatorProtocol methods
// override
- (void)requestAdWithSize:(CGSize)size
                   adInfo:(NSDictionary*)adInfo
{
    NSString *adUnitId = adInfo[RFM_AD_MEDIATION_INFO_KEY][RFM_AD_MEDIATION_INFO_ADUNIT_ID_KEY];
//    self.interstitial = [[DFPInterstitial alloc] initWithAdUnitID:@"/6499/example/interstitial"];
    self.interstitial = [[DFPInterstitial alloc] initWithAdUnitID:adUnitId];
    self.interstitial.delegate = self;
    [self.interstitial loadRequest:[DFPRequest request]];
}

- (void)cancelRequest
{
    if(!self.interstitial)
        return;
    self.interstitial.delegate = nil;
    self.interstitial = nil;
}

#pragma mark - GADBInterstitialViewDelegate methods

/// Called when an interstitial ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [self.delegate didFinishLoadingAd:nil];
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:[self.delegate viewControllerForPresentingModalView]];
    }
}

/// Called when an interstitial ad request failed.
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    [self cancelRequest];
    [self.delegate didFailToLoadAdWithReason:[error localizedDescription]];
}

/// Called just before presenting an interstitial.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    [self.delegate willPresentFullScreenModal];
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    [self.delegate willDismissInterstitial];
}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    [self.delegate didDismissInterstitial];
}

/// Called just before the app will background or terminate because the user clicked on an
/// ad that will launch another app (such as the App Store).
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {

}


@end
