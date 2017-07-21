Pod::Spec.new do |s|
  s.name         = "TEncryption"
  s.version      = "1.0.1"

  s.summary      = "md5, DES, AES, GTMBase64等加密方式"

  s.homepage     = "https://github.com/Fmyz/TEncryption"
  s.license      = "MIT"
  s.author       = { "Fmyz" => "https://github.com/Fmyz/TEncryption" }

  s.platform     = :ios,'7.0'
  s.source       = { :git => "https://github.com/Fmyz/TEncryption.git", :tag => "#{s.version}" }

  s.source_files = "TEncryption/*.{h,m}"

  s.dependency 'AESCrypt', '~> 0.0.1'
  s.dependency 'GTMBase64', '~> 1.0.0'

  s.requires_arc = true

end
