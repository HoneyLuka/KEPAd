#
# Be sure to run `pod lib lint KEPAd.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KEPAd'
  s.version          = '0.1.0'
  s.summary          = 'KEPAd.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'desc'

  s.homepage         = 'https://github.com/HoneyLuka/KEPAd'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luka' => '' }
  s.source           = { :git => 'https://github.com/HoneyLuka/KEPAd.git', :tag => s.version.to_s }

  s.static_framework = true
  s.ios.deployment_target = '9.0'

  s.source_files = 'KEPAd/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KEPAd' => ['KEPAd/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Firebase/Analytics'
  s.dependency 'Firebase/AdMob'
end