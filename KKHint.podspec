

Pod::Spec.new do |s|

  s.name         = "KKHint"

  s.version      = "1.0.0"

  s.summary      = "KKHint -> custom hint view"

  s.description  = <<-DESC
  make a hint on a view.(depend on MBProgressHUD -> 0.9.2)
  will custom hint view, other than depend MBProgressHUD
                   DESC

  s.homepage     = "https://github.com/TieShanWang/SMJRAlertView"

  s.license      = "MIT"

  s.author             = { "wangtieshan" => "15003836653@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/TieShanWang/KKHint.git", :tag => s.version }

  s.framework  = "UIKit"

s.dependency 'MBProgressHUD', '~> 0.9.2'

  s.source_files  = "KKHint/KKHint/**/*.{swift}"

end
