Pod::Spec.new do |s|
  s.name = "Tagged"
  s.version = "0.0.1"
  s.summary = "A library for safer types."

  s.description = <<-DESC
  A library for safer types.
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
    :branch => "master"
  }

  s.source_files  = "Sources", "Sources/**/*.swift"
end
