Pod::Spec.new do |s|
  s.name         = "LxGridView"
  s.version      = "1.0.0"
  s.summary      = "Imitate Apple iOS system Desktop icons arrangement and interaction by inheriting UICollectionView!"
  s.homepage     = "https://github.com/DeveloperLx/LxGridView"
  s.license      = 'Apache'
  s.authors      = { 'DeveloperLx' => 'developerlx@yeah.com' }
  s.platform     = :ios, "6.0"
  s.ios.deployment_target = "6.0"
  s.source       = { :git => "https://github.com/DeveloperLx/LxGridView.git", :tag => s.version}
  s.source_files = 'LxGridView/*'
  s.requires_arc = true
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
end
