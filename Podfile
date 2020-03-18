# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'SwiftLint'

  target 'TestTests' do
    inherit! :search_paths
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
    pod 'iOSSnapshotTestCase'
  end

  target 'TestUITests' do
    # Pods for testing
  end

end
