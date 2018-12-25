platform :ios, '12.0'

target 'Globe' do
  use_frameworks!
  inhibit_all_warnings!

  pod 'ReactiveCocoa', '~> 8.0'
  pod 'GoogleMaps', '~> 2.7'

  # Development Tools
  pod 'Sourcery', '~> 0.15'
  pod 'SwiftLint', '~> 0.29', :configuration => ['Debug']

  target 'GlobeTests' do
    inherit! :search_paths
  end
end
