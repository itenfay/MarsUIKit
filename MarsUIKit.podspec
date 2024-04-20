#
# Be sure to run `pod lib lint MarsUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MarsUIKit'
  s.version          = '2.0.5'
  s.summary          = 'MarsUIKit wraps some commonly used UI components.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: MarsUIKit wraps some commonly used UI components.
  DESC
  
  s.homepage         = 'https://github.com/chenxing640/MarsUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Teng Fei' => 'hansen981@126.com' }
  s.source           = { :git => 'https://github.com/chenxing640/MarsUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'
  
  s.swift_versions = ['4.2', '5.0']
  s.requires_arc = true
  s.default_subspecs = 'Base', 'BaseUI'
  
  #s.source_files = 'MarsUIKit/Classes/**/*.{swift}'
  # s.resource_bundles = {
  #   'MarsUIKit' => ['MarsUIKit/Assets/*.png']
  # }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.subspec "Base" do |base|
    base.source_files = 'MarsUIKit/Classes/Base/*.{swift}'
  end
  
  s.subspec "BaseUI" do |bui|
    bui.source_files = 'MarsUIKit/Classes/BaseUI/*.{swift}'
    bui.dependency 'MarsUIKit/Base'
    bui.dependency 'RxSwift', '~> 6.6.0'
    bui.dependency 'RxCocoa', '~> 6.6.0'
    bui.dependency 'Kingfisher', '~> 6.3.1'
    bui.dependency 'SVProgressHUD', '~> 2.2.5'
  end
  
  s.subspec "EmptyDataSet" do |eds|
    eds.source_files = 'MarsUIKit/Classes/EmptyDataSet/*.{swift}'
    eds.ios.deployment_target = '11.0'
    eds.dependency 'MarsUIKit/Base'
    eds.dependency 'DZNEmptyDataSet', '~> 1.8.1'
  end
  
  s.subspec "RxEmptyDataSet" do |rxeds|
    rxeds.source_files = 'MarsUIKit/Classes/RxEmptyDataSet/*.{swift}'
    rxeds.ios.deployment_target = '11.0'
    rxeds.dependency 'MarsUIKit/EmptyDataSet'
    rxeds.dependency 'RxSwift', '~> 6.6.0'
    rxeds.dependency 'RxCocoa', '~> 6.6.0'
  end
  
  s.subspec "RxMJRefresh" do |rxmjr|
    rxmjr.source_files = 'MarsUIKit/Classes/RxMJRefresh/*.{swift}'
    rxmjr.ios.deployment_target = '11.0'
    rxmjr.dependency 'RxSwift', '~> 6.6.0'
    rxmjr.dependency 'RxCocoa', '~> 6.6.0'
    rxmjr.dependency 'MJRefresh', '~> 3.7.6'
  end
  
  s.subspec "RxKafkaRefresh" do |rxkafkar|
    rxkafkar.source_files = 'MarsUIKit/Classes/RxKafkaRefresh/*.{swift}'
    rxkafkar.ios.deployment_target = '11.0'
    rxkafkar.dependency 'RxSwift', '~> 6.6.0'
    rxkafkar.dependency 'RxCocoa', '~> 6.6.0'
    rxkafkar.dependency 'KafkaRefresh', '~> 1.7.0'
  end
  
  s.subspec "OverlayView" do |olv|
    olv.source_files = 'MarsUIKit/Classes/OverlayView/*.{swift}'
    olv.ios.deployment_target = '11.0'
    olv.dependency 'MarsUIKit/Base'
    olv.dependency 'OverlayController', '~> 1.0.1'
  end
  
  s.subspec "Messages" do |msg|
    msg.source_files = 'MarsUIKit/Classes/Messages/*.{swift}'
    msg.ios.deployment_target = '11.0'
    msg.dependency 'MarsUIKit/Base'
    msg.dependency 'SwiftMessages', '<= 9.0.6' # Support ios 9.0+
  end
  
  s.subspec "Toast" do |toast|
    toast.source_files = 'MarsUIKit/Classes/Toast/*.{swift}'
    toast.ios.deployment_target = '11.0'
    toast.dependency 'MarsUIKit/Base'
    toast.dependency 'Toaster', '~> 2.3.0'
    toast.dependency 'Toast-Swift', '~> 5.0.1'
  end
  
  s.subspec "SVGA" do |svgap|
    svgap.source_files = 'MarsUIKit/Classes/SVGA/*.{swift}'
    svgap.ios.deployment_target = '11.0'
    svgap.dependency 'SSZipArchive', '~> 2.4.3'
    svgap.dependency 'Protobuf', '~> 3.26.1'
    svgap.vendored_frameworks = 'MarsUIKit/Assets/SVGAPlayerXFWK/SVGAPlayer.xcframework' # SVGAPlayer
  end
  
end
