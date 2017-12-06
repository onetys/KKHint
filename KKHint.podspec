

Pod::Spec.new do |s|

  s.name         = "KKHint"

  s.version      = "1.1.2"

  s.summary      = "KKHint -> custom hint view"

  s.description  = <<-DESC
  make a hint on a view. extension for UIView
                   DESC

  s.homepage     = "https://github.com/TieShanWang/KKHint"

  s.license      = "MIT"

  s.author             = { "wangtieshan" => "15003836653@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/TieShanWang/KKHint.git", :tag => s.version }

  s.framework  = "UIKit"

  s.source_files  = "KKHint/KKHint/**/*.{swift}"

  s.resource     = "KKHint/KKHint/resource.bundle"

end
