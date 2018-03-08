Pod::Spec.new do |s|
  s.name             = 'PKImageSpark'
  s.version          = '0.1.0'
  s.summary          = 'Show some action on event or action.'
 
  s.description      = <<-DESC
Some cool animations that can be used to show an animation on any event action.
                       DESC
 
  s.homepage         = 'https://github.com/kumarpramod017/PKImageSpark'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pramod Kumar' => 'kumarpramod017@gmail.com' }
  s.source           = { :git => 'https://github.com/kumarpramod017/PKImageSpark.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'PKImageSparkDemo/PKImageSpark/*.swift'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }
end