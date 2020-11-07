# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

target 'lets-eat-app-ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for lets-eat-app-ios
  pod 'RSJ', :git => 'https://github.com/rynssnjn/RSJ.git'
  pod 'Astral'
  pod 'BFAstral'
  pod 'Cyanic', :git => 'https://github.com/feilfeilundfeil/Cyanic.git', :branch => 'develop'
  pod 'LayoutKit', :git => 'https://github.com/hooliooo/LayoutKit.git'
  pod 'CommonWidgets', :git => 'git@bitbucket.org:FFUF/ffuf-ios-widgets.git'
end

post_install do |installer|
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-lets-eat-app-ios/Pods-lets-eat-app-ios-acknowledgements.plist', 'Source/Supporting Files/Acknowledgements.plist', :remove_destination => true)
end
