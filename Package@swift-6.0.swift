// swift-tools-version: 6.0

import Foundation
import PackageDescription
import CompilerPluginSupport

var package = Package(
  name: "swift-tagged",
  platforms: [.macOS(.v10_15)],
  products: [
    .library(name: "Tagged", targets: ["Tagged"]),
    .library(name: "TaggedMoney", targets: ["TaggedMoney"]),
    .library(name: "TaggedTime", targets: ["TaggedTime"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-macro-testing", from: "0.1.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax", "509.0.0"..<"602.0.0"),
  ],
  targets: [
    .target(name: "Tagged", dependencies: []),
    .testTarget(name: "TaggedTests", dependencies: ["Tagged"]),

    .target(
      name: "TaggedMacro",
      dependencies: [
        "Tagged",
        "TaggedMacroPlugin",
      ]
    ),
    .macro(
      name: "TaggedMacroPlugin",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ]
    ),
    .testTarget(
      name: "TaggedMacroPluginTests",
      dependencies: [
        "TaggedMacro",
        "TaggedMacroPlugin",
        .product(name: "MacroTesting", package: "swift-macro-testing"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ]
    ),

    .target(name: "TaggedMoney", dependencies: ["Tagged"]),
    .testTarget(name: "TaggedMoneyTests", dependencies: ["TaggedMoney"]),

    .target(name: "TaggedTime", dependencies: ["Tagged"]),
    .testTarget(name: "TaggedTimeTests", dependencies: ["TaggedTime"]),
  ],
  swiftLanguageModes: [.v6]
)
