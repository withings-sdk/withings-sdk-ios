Pod::Spec.new do |s|
    s.name         = "Withings"
    s.version      = "4.0.6"
    s.summary      = "Withings SDK"
    s.description  = <<-DESC
    Check full documentation here: https://developer.withings.com/sdk/#/ios/doc
    DESC
    s.homepage     = "https://developer.withings.com/sdk/#/ios/doc"
    s.author       = { "Withings" => "support@withings.com" }
    s.source       = { :git => ".", :tag => "#{s.version}" }
    s.vendored_frameworks = "Withings.xcframework"
    s.platform = :ios
    s.swift_version = "4.2"
    s.ios.deployment_target  = '12.0'
end

