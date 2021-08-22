# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SimpleMVVMExample' do
  # Comment the next line if you don't want to use dynamic frameworks
    inherit! :search_paths
    use_frameworks!

    pod 'PromiseKit'
    pod 'Alamofire'

  # Pods for SimpleMVVMExample

  target 'SimpleMVVMExampleTests' do
    # Pods for Unittesting
    inherit! :search_paths
    pod 'SnapshotTesting'
  end

  target 'SimpleMVVMExampleUITests' do
    # Pods for UItesting
    inherit! :search_paths
    pod 'SnapshotTesting'
  end

end

#post_install do |pi|
#   pi.pods_project.targets.each do |t|
#       t.build_configurations.each do |bc|
#          bc.build_settings['ARCHS[sdk=iphonesimulator*]'] =  `uname -m`
#       end
#   end
#end
