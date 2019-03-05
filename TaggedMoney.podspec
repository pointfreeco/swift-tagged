Pod::Spec.new do |s|
  s.name = "TaggedMoney"
  s.version = "0.2.0"
  s.summary = "A library for safer dollars and cents types."

  s.description = <<-DESC
  We often work with types that are far too general or hold far too many values
  than what is necessary for our domain. Sometimes we just want to
  differentiate between two seemingly equivalent values at the type level.

  Tagged lets us wrap basic types in more specific contexts with ease, and
  TaggedMoney provides two completely different types for differentiating
  between whole dollars and cents, regardless of currency.
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
    :tag => s.version
  }

  s.dependency = "Tagged", "~> 0.2.0"

  s.swift_version = "4.2"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"

  s.source_files = "Sources/TaggedMoney/**/*.swift"
end
