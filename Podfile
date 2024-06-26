# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Copilot' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Copilot
  pod 'SwiftLint'
  pod 'IQKeyboardManagerSwift'
  pod 'netfox'
  pod 'Alamofire'
  pod 'GoogleMaps', '8.3.1'
  pod 'SDWebImage'
  pod 'FSCalendar'
  pod 'Firebase/Core'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == "Alamofire" || target.name == "AlamofireImage" || target.name == "FGRoute" || target.name == "upnpx" || target.name == "ReachabilitySwift" || target.name == "Swifter"
      target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
	target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 15.0
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
            end
         end
  end
end

end