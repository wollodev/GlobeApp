platform :ios, '11.0'

target 'Globe' do
  use_frameworks!
  inhibit_all_warnings!

  pod 'ReactiveCocoa', '~> 10.0'
  pod 'GoogleMaps', '~> 3.3'
  pod 'R.swift', '~> 5.0'

  # Development Tools
  pod 'Sourcery', '~> 0.16'
  pod 'SwiftLint', '~> 0.29', :configuration => ['Debug']

  target 'GlobeTests' do
    inherit! :search_paths
  end
end
