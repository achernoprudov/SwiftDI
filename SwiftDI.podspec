
Pod::Spec.new do |s|
  s.name         = "SwiftDI"
  s.version      = "1.0.0"
  s.summary      = "SwiftDI is a dependency manager for Swift projects."
  s.description  = <<-DESC
                  SwiftDI is a dependency manager for Swift projects.
                   DESC

  s.homepage     = "https://github.com/achernoprudov/SwiftDI"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author = { "Andrey Chernoprudov" => "dinloq@gmail.com" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/achernoprudov/SwiftDI.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "Source/**/*.{swift}"
end
