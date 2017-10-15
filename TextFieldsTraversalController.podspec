#
# Be sure to run `pod lib lint TextFieldsTraversalController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TextFieldsTraversalController'
  s.version          = '1.0.0'
  s.summary          = 'A controller to manage the traversal of a collection of textields.'

  s.homepage         = 'https://github.com/danielinoa/TextFieldsTraversalController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'danielinoa' => 'danielinoa@gmail.com' }
  s.source           = { :git => 'https://github.com/danielinoa/TextFieldsTraversalController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielinoa_'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Classes/**/*'
  
  # s.resource_bundles = {
  #   'TextFieldsTraversalController' => ['TextFieldsTraversalController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
