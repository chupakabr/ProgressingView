#
# Be sure to run `pod lib lint ProgressingView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ProgressingView'
  s.version          = '1.0'
  s.summary          = 'Drop-in component that allows fancy progress views with gradients fully designable in right in the storyboard.'
  s.description      = <<-DESC
This is a drop-in component that implements a progress view with fancy gradients or plain old solid colors.
It allows the user to visually pick the colors for both background and foreground
gradients within the Storyboard. Just drop a view into your storyboard, set the
class to ProgressingView and you are ready to play with colors.
                       DESC
  s.homepage         = 'https://github.com/chupakabr/ProgressingView'
  s.license          = {
      :type => 'MIT',
      :file => 'LICENSE'
  }
  s.authors          = {
      'Alex Kremer' => 'godexsoft@gmail.com',
      'Valera Chevtaev' => 'myltik@gmail.com'
  }
  s.source           = {
      :git => 'https://github.com/chupakabr/ProgressingView.git',
      :tag => s.version.to_s
  }
  s.ios.deployment_target = '10.0'
  s.source_files = 'ProgressingView/Classes/**/*'
  s.frameworks = 'UIKit'
end
