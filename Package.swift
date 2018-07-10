// swift-tools-version:4.0
import PackageDescription

let package = Package(
  name: "Tagged",
  products: [
    .library(name: "Tagged", targets: ["Tagged"]),
    .library(name: "TaggedTime", targets: ["TaggedTime"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(name: "Tagged", dependencies: []),
    .testTarget(name: "TaggedTests", dependencies: ["Tagged"]),

    .target(name: "TaggedTime", dependencies: ["Tagged"]),
    .testTarget(name: "TaggedTimeTests", dependencies: ["TaggedTime"]),
  ]
)
