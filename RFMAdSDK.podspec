Pod::Spec.new do |s|
  s.name         = "RFMAdSDK"
  s.version      = "6.2.0"
  s.summary      = "Rubicon Project Mobile Ads SDK for iOS"
  s.description  = <<-DESC
	Maximize the monetization of your app inventory. The Rubicon Project mobile SDK lets you access Rubicon Project’s extensive network of advertising brands and effective optimization tools to maximize the monetization of your network’s iOS and Android app inventory.
                   DESC

  s.homepage     = "http://sdk.rubiconproject.com/"
  s.license      = { :type => "Copyright", :text => "Copyright 2012-2016 Rubicon Project. All Rights Reserved" }
  s.author       = { "Rubicon Project" => "mobileappdev@rubiconproject.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/rubicon-project/RFMAdSDK-iOS.git", :tag => "6.2.0" }
  s.source_files  = "RFMAdSDK/RFMAdSDK.framework/Versions/A/Headers/*.h"
	s.vendored_frameworks = "RFMAdSDK/RFMAdSDK.framework"
	s.resource_bundle = { "RFMAdSDK" => "RFMAdSDK/RFMAdSDK.bundle/**/*.{png,plist,js,strings,xsd}"	}
  s.frameworks = "AdSupport" , "AudioToolbox" , "AVFoundation", "CoreGraphics", "CoreMedia", "CoreTelephony", "Foundation", "MediaPlayer", "MessageUI", "SafariServices", "StoreKit", "SystemConfiguration", "UIKit", "WebKit"
  s.library   = "xml2"
  s.requires_arc = true
  s.xcconfig = {"FRAMEWORK_SEARCH_PATHS" => "$(PODS_ROOT)/RFMAdSDK" }
end
