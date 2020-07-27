

Pod::Spec.new do |s|

  s.name         = "KKHint"

  s.version      = "5.0.0"

  s.summary      = "custom hint view, support 5.0.0 from version 5.0.0"

  s.description  = <<-DESC
  custom hint view, support 5.0.0 from version 5.0.0
                   DESC

  s.homepage     = "https://github.com/onetys/KKHint"

  s.license      = "MIT"

  s.author             = { "wangtieshan" => "15003836653@163.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/onetys/KKHint.git", :tag => s.version }

  s.framework  = "UIKit"

  s.source_files  = "KKHint/KKHint/**/*.{swift}"

  s.resource     = "KKHint/KKHint/resource.bundle"

  if spec.respond_to? 'swift_version'
    s.swift_version = "5.0"
  end

end
