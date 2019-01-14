// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "Tagged",
  products: [
    .library(
      name: "Tagged",
      targets: ["Tagged"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Tagged",
      dependencies: []),
    .testTarget(
      name: "TaggedTests",
      dependencies: ["Tagged"]),
  ]
)
