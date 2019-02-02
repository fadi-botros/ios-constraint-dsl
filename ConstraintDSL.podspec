Pod::Spec.new do |s|
  s.name             = 'ConstraintDSL'
  s.version          = '0.2.0'
  s.summary          = 'A small DSL library to make the constraints more descriptive'

  s.description      = <<-DESC
  This is a small library that turns writing constraints into something more descriptive:
  just small equations, as it is in Apple's representation.

  Something like:

      oneView.topConstraint ==== otherView.topConstraint + 16
      oneView.width ==== (otherView.width * 0.5) - 16

                       DESC

  s.homepage         = 'https://bitbucket.org/botros_fadi/ios-constraint-dsl'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fadi-botros' => 'botros_fadi@yahoo.com' }
  s.source           = { :git => 'https://bitbucket.org/botros_fadi/ios-constraint-dsl.git', :tag => s.version.to_s }
  s.swift_version = '4.2'

  s.ios.deployment_target = '9.3'

  s.source_files = 'ConstraintDSL/Classes/**/*'
  
end
