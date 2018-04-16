# 🏷 Tagged
MacOS [![CircleCI](https://circleci.com/gh/pointfreeco/swift-tagged.svg?style=svg)](https://circleci.com/gh/pointfreeco/swift-tagged) Linux [![Build Status](https://travis-ci.org/pointfreeco/swift-tagged.svg?branch=master)](https://travis-ci.org/pointfreeco/swift-tagged)

A library for safer types.

## Introduction

We often work with types that are far too general or hold far too many values than what is necessary for our domain. Sometimes we just want to differentiate between two seemingly equivalent values at the type level.

For example, an email address is nothing but a `String`, but it should be restricted in the ways in which it can be used. And while a `User` id may be represented with an `Int`, it should be distinguishable from an `Int`-based `Subscription` id.

## Examples

Tagged lets us wrap basic types in more specific contexts with ease. Given the following JSON representing a user:

``` json
{
  "id": 1,
  "email": "blob@pointfree.co",
  "subscriptionId": 1
}
```

We may be tempted to model it simply:

``` swift
struct User: Decodable {
  let id: Int
  let email: String
  let subscriptionId: Int?
}

struct Subscription: Decodable {
  let id: Int
}
```

It's easy to model user and subscription ids using the same type, but our app logic shouldn't treat these values interchangeably: doing so could lead to runtime bugs and security issues!

Luckily, we can use Tagged to differentiate these types.

``` swift
import Tagged

struct User: Decodable {
  typealias Id = Tagged<User, Int>

  let id: Id
  let email: String
  let subscriptionId: Subscription.Id?
}

struct Subscription: Decodable {
  typealias Id = Tagged<Subscription, Int>

  let id: Id
}
```

Now there's no chance we'll accidentally pass a `User` id where we expect a `Subscription` id.

Tagged depends on a generic "tag" parameter to make each type unique. In these cases, we use the parent type to tag each `Id` type.

What if there's no parent type? Let's say we want to constrain an `Email` type that wraps a string.

``` swift
typealias Email = Tagged<_, String>
```

We can tag `Email` by defining an uninhabited `EmailTag` enum.

``` swift
enum EmailTag {}
typealias Email = Tagged<EmailTag, String>
```

Now our `User` can be even more type-safe.

``` swift
struct User: Decodable {
  typealias Id = Tagged<User, Int>

  let id: Id
  let email: Email
  let subscriptionId: Subscription.Id?
}
```

Tagged relies on conditional conformance to be practical: if the raw values are encodable or decodable, equatable, hashable, or comparable, the tagged values follow suit.

Tagged types also inherit any literal expressibility. Our `User` type above can be instantiated simply using the underlying literals.

``` swift
User(
  id: 1,
  email: "blob@pointfree.co",
  subscriptionId: 1
)
```

## Installation

### Carthage

If you use [Carthage](https://github.com/Carthage/Carthage), you can add the following dependency to your `Cartfile`:

``` ruby
github "pointfreeco/swift-tagged" ~> 0.1
```

### CocoaPods

If your project uses [CocoaPods](https://cocoapods.org), just add the following to your `Podfile`:

``` ruby
pod 'Tagged', :git => 'https://github.com/pointfreeco/swift-tagged.git', '~> 0.1'
```

### SwiftPM

If you want to use Tagged in a project that uses [SwiftPM](https://swift.org/package-manager/), it's as simple as adding a `dependencies` clause to your `Package.swift`:

``` swift
dependencies: [
  .package(url: "https://github.com/pointfreeco/swift-tagged.git", from: "0.1.0")
]
```

### Xcode Sub-project

Submodule, clone, or download Tagged, and drag `Tagged.xcodeproj` into your project.

## Interested in learning more?

These concepts (and more) are explored thoroughly in [Point-Free](https://www.pointfree.co).

## License

All modules are released under the MIT license. See [LICENSE](LICENSE) for details.
