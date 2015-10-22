#
# Be sure to run `pod lib lint LolayInvestigo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name              = 'LolayInvestigo'
    s.version           = '1.0.1'
    s.summary           = 'Tracking Library for Flurry, Omniture, Segment.IO, etc.'
    s.homepage          = 'https://github.com/Lolay/Investigo'
    s.license           = { :type => 'Apache', :file => 'LICENSE' }
    s.author            = { 'Lolay' => 'support@lolay.com' }
    s.source            = { :git => 'https://github.com/TheClimateCorporation/investigo.git', :tag => s.version.to_s }
    s.source_files      = 'LolayInvestigo/LolayInvestigo.h',
                          'LolayInvestigo/LolayAnalyticsTracker.*',
                          'LolayInvestigo/LolayBaseTracker.*',
                          'LolayInvestigo/LolayFlurryTracker.*',
                          'LolayInvestigo/LolayLocaleTracker.*',
                          'LolayInvestigo/LolayMultipleTracker.*',
                          'LolayInvestigo/LolayNSLogTracker.*',
                          'LolayInvestigo/LolayNoTracker.*',
                          'LolayInvestigo/LolayTracker.*',
                          'LolayInvestigo/LolayTrackerGender.*',
                          'LolayInvestigo/LolayInvestigoGlobals.*'
    s.public_header_files = 'LolayInvestigo/LolayInvestigo.h',
                        'LolayInvestigo/LolayAnalyticsTracker.h',
                        'LolayInvestigo/LolayBaseTracker.h',
                        'LolayInvestigo/LolayFlurryTracker.h',
                        'LolayInvestigo/LolayLocaleTracker.h',
                        'LolayInvestigo/LolayMultipleTracker.h',
                        'LolayInvestigo/LolayNSLogTracker.h',
                        'LolayInvestigo/LolayNoTracker.h',
                        'LolayInvestigo/LolayTracker.h',
                        'LolayInvestigo/LolayTrackerGender.h',
                        'LolayInvestigo/LolayInvestigoGlobals.h'
    s.module_name       = 'LolayInvestigo'
    s.requires_arc      = true
    s.frameworks = 'CoreData','Security','SystemConfiguration','CoreTelephony','QuartzCore','AdSupport'
    s.library = 'z','sqlite3'
    s.ios.deployment_target = '8.0'
    s.dependency 'Analytics/Segmentio', '~>2.0'
    s.dependency 'Flurry-iOS-SDK/FlurrySDK', '~>7.0'
end

