source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.0'
use_frameworks!

target 'TelematicsSDK' do
  pod 'TelematicsSDK', '7.0.0'
  pod 'UICountingLabel', '1.2.0'
  pod 'PNChart', '0.8.9'

end

post_install do |installer|
     installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
           config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
   end
end
