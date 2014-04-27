Pod::Spec.new do |s|
  s.name             = "TAOOverlayHelp"
  s.version          = "0.1.0"
  s.summary          = "Overlay HUD for showing help tips to controls on screen."
  s.description      = <<-DESC
                       Overlay HUD for showing help tips to controls on screen.
                       
                       The control shows a semi-transparent overlay with a message and an arrow going from the message to a point on screen. The control can be dismissed by code, or by the user tapping the overlay.
                       DESC
  s.homepage         = "https://github.com/three-tall-guys/TAOOverlayHelp"
  s.screenshots      = "https://cloud.githubusercontent.com/assets/99543/2811211/dcff19de-ce0e-11e3-8647-5405014bb594.png"
  s.license          = 'MIT'
  s.author           = { "Three Tall Guys" => "hi@threetallguys.com", "Or Sharir" => "or@threetallguys.com" }
  s.source           = { :git => "https://github.com/three-tall-guys/TAOOverlayHelp.git", :tag => s.version.to_s }

  # s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes'
  
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'QuartzCore'
end
