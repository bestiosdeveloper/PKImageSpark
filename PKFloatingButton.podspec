Pod::Spec.new do |s|
  s.name             = 'PKFloatingButton'
  s.version          = '0.1.0'
  s.summary          = 'Create a floating button in whole application.'
 
  s.description      = <<-DESC
This framework will help you to create a Floating button that will float over the window or specified view!
                       DESC
 
  s.homepage         = 'https://github.com/kumarpramod017/PKFloatingButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pramod Kumar' => 'kumarpramod017@gmail.com' }
  s.source           = { :git => 'https://github.com/kumarpramod017/PKFloatingButton.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'PKFloatingButtonDemo/PKFloatingButton/*.swift'
 s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }
end
