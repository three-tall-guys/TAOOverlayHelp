#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "TAOOverlayHelp"
  s.version          = "0.1.0"
  s.summary          = "An overlay view for presenting a help tip to the user"
  s.description      = <<-DESC
                       An optional longer description of TAOOverlayHelp

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://threetallguys.com/"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Three Tall Guys" => "or@threetallguys.com" }
  s.source           = { :git => "https://github.com/three-tall-guys/TAOOverlayHelp.git", :tag => s.version.to_s }

  # s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes'
  
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'QuartzCore'
end
