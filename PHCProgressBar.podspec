Pod::Spec.new do |s|
  s.name             = 'PHCProgressBar'
  s.version          = '0.1.0'
  s.summary          = 'A high customized circle + progress bar'
  s.homepage         = 'https://github.com/scottphc/PHCProgressBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'scottphc' => 'scott.ph.chou@gmail.com' }
  s.source           = { :git => 'https://github.com/scottphc/PHCProgressBar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'PHCProgressBar/Classes/**/*'
end
