#
# Be sure to run `pod lib lint DCCJMessageCenter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DCCJMessageCenter'
  s.version          = '0.2.8'
  s.summary          = 'A module mainly to handle message send and verify'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A module mainly to handle message send and verify Used by DCCJ
                       DESC

  s.homepage         = 'https://github.com/Ghstart/DCCJMessageCenter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ghstart' => 'gonghuan2020@gmail.com' }
  s.source           = { :git => 'https://github.com/Ghstart/DCCJMessageCenter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'DCCJMessageCenter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DCCJMessageCenter' => ['DCCJMessageCenter/Assets/*.png']
  # }
  s.resource_bundles = {
      'DCCJMessageCenter' => ['DCCJMessageCenter/Classes/**/*.{png,jpeg,jpg,storyboard,xib}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'DCCJNetwork', '~> 0.4.1'
end
