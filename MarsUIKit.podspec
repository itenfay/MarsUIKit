#
# Be sure to run `pod lib lint MarsUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MarsUIKit'
  s.version          = '1.0.3'
  s.summary          = 'MarsUIKit wraps some commonly used UI components.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       MarsUIKit wraps some commonly used UI components.
                       DESC

  s.homepage         = 'https://github.com/chenxing640/MarsUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenxing' => 'chenxing640@foxmail.com' }
  s.source           = { :git => 'https://github.com/chenxing640/MarsUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_versions = ['4.2', '5.0']
  s.requires_arc = true
  
  s.source_files = 'MarsUIKit/Classes/**/*.{swift}'
  
  # s.resource_bundles = {
  #   'MarsUIKit' => ['MarsUIKit/Assets/*.png']
  # }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Toaster'
  s.dependency 'Toast-Swift', '~> 5.0.1'
  s.dependency 'SwiftMessages'
  s.dependency 'SVProgressHUD'
  s.dependency 'OverlayController'
  s.dependency 'RxCocoa'
  s.dependency 'RxSwift'
  s.dependency 'Kingfisher'
  s.dependency 'MJRefresh'
  s.dependency 'KafkaRefresh'
  s.dependency 'DZNEmptyDataSet'
  # SVGAPlayer/Source/pbobjc/Svga.pbobjc.m:1063:14: error: conflicting types for 'OSAtomicCompareAndSwapPtrBarrier'
  #s.dependency 'SVGAPlayer'
  
end
