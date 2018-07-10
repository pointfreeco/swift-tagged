Pod::Spec.new do |s|
  s.name = "TaggedMoney"
  s.version = "0.1.0"
  s.summary = "A library for safer money."

  s.description = <<-DESC
  TODO
  DESC

  s.homepage = "https://github.com/pointfreeco/swift-tagged"

  s.license = "MIT"

  s.authors = {
    "Stephen Celis" => "stephen@stephencelis.com",
    "Brandon Williams" => "mbw234@gmail.com"
  }
  s.social_media_url = "https://twitter.com/pointfreeco"

  s.source = {
    :git => "https://github.com/pointfreeco/swift-tagged.git",
    :tag => "0.1.0"
  }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"

  s.source_files  = "Sources", "Sources/TaggedMoney/*.swift"
end
