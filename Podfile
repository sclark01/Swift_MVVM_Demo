workspace 'MVVM_Demo'
project 'MVVM_Demo.xcodeproj'
platform :ios, '10.2'

use_frameworks!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'OHHTTPStubs'
  pod 'OHHTTPStubs/Swift'
end

def networking_pods 
  pod 'Alamofire'
end

pod 'ReactiveCocoa', '~> 5.0.0'
pod 'SwiftyJSON'

target 'MVVM_Demo' do
  networking_pods
end

target 'MVVM_DemoTests' do
  networking_pods
  testing_pods
end
