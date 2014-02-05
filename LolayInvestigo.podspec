Pod::Spec.new do |s|

    s.name              = 'LolayInvestigo'
    s.version           = '0.5.0'
    s.summary           = 'Tracking Library for Flurry, Omniture, etc.'
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
        :tag => "0.5.0"
    }
    s.source_files      = 'LolayInvestigo/*.*','LolayInvestigoTests/*.*'
	s.dependency 'OCMock', '~> 2.2'
    s.requires_arc      = true
	s.frameworks = 'XCTest','UIKit','Foundation'
	s.ios.deployment_target = '7.0'
end
