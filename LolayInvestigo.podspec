Pod::Spec.new do |s|

    s.name              = 'LolayInvestigo'
    s.version           = '1'
    s.summary           = 'Tracking Library for Flurry, Omniture, Segment.IO, etc.'
    s.homepage          = 'https://github.com/Lolay/Investigo'
    s.license           = {
        :type => 'Apache',
        :file => 'LICENSE'
    }
    s.author            = {
        'Lolay' => 'support@lolay.com'
    }
    s.source            = {
        :git => 'https://github.com/lolay/investigo.git',
        :tag => "1"
    }
    s.source_files      = 'LolayInvestigo/LolayAnalyticsTracker.*','LolayInvestigo/LolayBaseTracker.*','LolayInvestigo/LolayFlurryTracker.*','LolayInvestigo/LolayLocaleTracker.*','LolayInvestigo/LolayMultipleTracker.*','LolayInvestigo/LolayNSLogTracker.*','LolayInvestigo/LolayNoTracker.*','LolayInvestigo/LolayTracker.*','LolayInvestigo/LolayTrackerGender.*','LolayInvestigo/LolayInvestigoGlobals.*'
    s.requires_arc      = true
	s.frameworks = 'XCTest','UIKit','Foundation','CoreData','Security','SystemConfiguration','CoreTelephony','UIKit','QuartzCore','AdSupport'
	s.library = 'z','sqllite3'
	s.ios.deployment_target = '7.0'
	s.xcconfig        = { 'OTHER_LDFLAGS' => '-ObjC', 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/Analytics"' }
end
