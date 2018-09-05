version = "0.2.0"

Pod::Spec.new do |s|
  s.authors = {
    "Stephen Celis" => "stephen@stephencelis.com",
    "Brandon Williams" => "mbw234@gmail.com"
  }
  s.default_subspec = 'Tagged'
  s.description = <<-DESC
  We often work with types that are far too general or hold far too many values than what is necessary for our domain. Sometimes we just want to differentiate between two seemingly equivalent values at the type level.

  Tagged lets us wrap basic types in more specific contexts with ease, and TaggedTime provides two completely different types for differentiating between seconds and millseconds.
  DESC
  s.homepage = "https://github.com/pointfreeco/swift-tagged"
  s.license = "MIT"
  s.name = "TaggedMoney"
  s.social_media_url = "https://twitter.com/pointfreeco"
  s.source = { :git => "https://github.com/pointfreeco/swift-tagged.git", :tag => version }
  s.summary = "A library for safer seconds and milliseconds types."
  s.version = version

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"

  s.spec 'TaggedTime' do |sub| 
    sub.dependency = 'Tagged'
    sub.source_files = "Sources", "Sources/TaggedTime/*.swift"
  end
end
