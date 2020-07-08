#
# Be sure to run `pod lib lint OCHttpUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OCHttpUtils'
  s.version          = '0.1.0.Binary'
  s.summary          = 'ANFNetworking与YYModel的封装.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/seasonZhu/OCHttpUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'seasonZhu' => 'zhujilong2007@sina.com' }
  s.source           = { :git => 'https://github.com/seasonZhu/OCHttpUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  if s.version.to_s.include?'Binary'
      puts '-------------------------------------------------------------------'
      puts 'Notice:OCHttpUtils is binary now'
      puts '-------------------------------------------------------------------'
      s.prepare_command = '/bin/bash build_lib.sh'
      s.source_files = 'Pod/Products/include/**'
      s.ios.vendored_libraries = 'Pod/Products/lib/*.a'
      s.public_header_files = 'Pod/Products/include/*.h'
    else
      puts '-------------------------------------------------------------------'
      puts 'Notice:OCHttpUtils is source code now'
      puts '-------------------------------------------------------------------'
      s.source_files = 'OCHttpUtils/Classes/**/*'
    end
  
  # s.resource_bundles = {
  #   'OCHttpUtils' => ['OCHttpUtils/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 4.0.1'
  s.dependency 'YYModel'
end
