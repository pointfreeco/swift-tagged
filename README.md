# 🏷 Tagged

[![Swift 4.1](https://img.shields.io/badge/swift-4.1-ED523F.svg?style=flat)](https://swift.org/download/)
[![iOS/macOS CI](https://img.shields.io/circleci/project/github/pointfreeco/swift-tagged/master.svg?label=ios/macos)](https://circleci.com/gh/pointfreeco/swift-tagged)
[![Linux CI](https://img.shields.io/travis/pointfreeco/swift-tagged/master.svg?label=linux)](https://travis-ci.org/pointfreeco/swift-tagged)
[![@pointfreeco](https://img.shields.io/badge/contact-@pointfreeco-5AA9E7.svg?style=flat)](https://twitter.com/pointfreeco)

A wrapper type for safer, expressive code.

## Table of Contents

  - [Motivation](#motivation)
  - [The problem](#the-problem)
  - [The solution](#the-solution)
      - [Handling tag collisions](#handling-tag-collisions)
      - [Accessing raw values](#accessing-raw-values)
  - [Features](#features)
  - [FAQ](#faq)
  - [Installation](#installation)
  - [Interested in learning more?](#interested-in-learning-more)
  - [License](#license)

## Motivation

We often work with types that are far too general or hold far too many values than what is necessary for our domain. Sometimes we just want to differentiate between two seemingly equivalent values at the type level.

An email address is nothing but a `String`, but it should be restricted in the ways in which it can be used. And while a `User` id may be represented with an `Int`, it should be distinguishable from an `Int`-based `Subscription` id.

Tagged can help solve serious runtime bugs at compile time by wrapping basic types in more specific contexts with ease.

## The problem

Swift has an incredibly powerful type system, yet it's still common to model most data like this:

``` swift
struct User {
  let id: Int
  let email: String
  let address: String
  let subscriptionId: Int?
}

struct Subscription {
  let id: Int
}
```

We're modeling user and subscription ids using _the same type_, but our app logic shouldn't treat these values interchangeably! We might write a function to fetch a subscription:

``` swift
func fetchSubscription(byId id: Int) -> Subscription? {
  return subscriptions.first(where: { $0.id == id })
}
```

Code like this is super common, but it allows for serious runtime bugs and security issues! The following compiles, runs, and even reads reasonably at a glance:

``` swift
let subscription = fetchSubscription(byId: user.id)
```

This code will fail to find a user's subscription. Worse yet, if a user id and subscription id overlap, it will display the _wrong_ subscription to the _wrong_ user! It may even surface sensitive data like billing details!

## The solution

We can use Tagged to succinctly differentiate types.

``` swift
import Tagged

struct User {
  let id: Id
  let email: String
  let address: String
  let subscriptionId: Subscription.Id?

  typealias Id = Tagged<User, Int>
}

struct Subscription {
  let id: Id

  typealias Id = Tagged<Subscription, Int>
}
```

Tagged depends on a generic "tag" parameter to make each type unique. Here we've used the container type to uniquely tag each id.

We can now update `fetchSubscription` to take a `Subscription.Id` where it previously took any `Int`.

``` swift
func fetchSubscription(byId id: Subscription.Id) -> Subscription? {
  return subscriptions.first(where: { $0.id == id })
}
```

And there's no chance we'll accidentally pass a user id where we expect a subscription id.

``` swift
let subscription = fetchSubscription(byId: user.id)
```

> 🛑 Cannot convert value of type 'User.Id' (aka 'Tagged<User, Int>') to expected argument type 'Subscription.Id' (aka 'Tagged<Subscription, Int>')

We've prevented a couple serious bugs at compile time!

There's another bug lurking in these types. We've written a function with the following signature:

``` swift
sendWelcomeEmail(toAddress address: String)
```

It contains logic that sends an email to an email address. Unfortunately, it takes _any_ string as input.

``` swift
sendWelcomeEmail(toAddress: user.address)
```

This compiles and runs, but `user.address` refers to our user's _billing_ address, _not_ their email! None of our users are getting welcome emails! Worse yet, calling this function with invalid data may cause server churn and crashes.

Tagged again can save the day.

``` swift
struct User {
  let id: Id
  let email: Email
  let address: String
  let subscriptionId: Subscription.Id?

  typealias Id = Tagged<User, Int>
  typealias Email = Tagged<User, String>
}
```

We can now update `sendWelcomeEmail` and have another compile time guarantee.

``` swift
sendWelcomeEmail(toAddress address: Email)
```

``` swift
sendWelcomeEmail(toAddress: user.address)
```

> 🛑 Cannot convert value of type 'String' to expected argument type 'Email' (aka 'Tagged<EmailTag, String>')

### Handling Tag Collisions

What if we want to tag two string values within the same type?

``` swift
struct User {
  let id: Id
  let email: Email
  let address: Address
  let subscriptionId: Subscription.Id?

  typealias Id = Tagged<User, Int>
  typealias Email = Tagged<User, String>
  typealias Address = Tagged</* What goes here? */, String>
}
```

We shouldn't reuse `Tagged<User, String>` because the compiler would treat `Email` and `Address` as the same type! We need a new tag, which means we need a new type. We can use any type, but an uninhabited enum is nestable and uninstantiable, which is perfect here.

``` swift
struct User {
  let id: Id
  let email: Email
  let address: Address
  let subscriptionId: Subscription.Id?

  typealias Id = Tagged<User, Int>
  enum EmailTag {}
  typealias Email = Tagged<EmailTag, String>
  enum AddressTag {}
  typealias Address = Tagged<AddressTag, String>
}
```

We've now distinguished `User.Email` and `User.Address` at the cost of an extra line per type, but things are documented very explicitly.

If we want to save this extra line, we could instead take advantage of the fact that tuple labels are encoded in the type system and can be used to differentiate two seemingly equivalent tuple types.

``` swift
struct User {
  let id: Id
  let email: Email
  let address: Address
  let subscriptionId: Subscription.Id?

  typealias Id = Tagged<User, Int>
  typealias Email = Tagged<(User, email: ()), String>
  typealias Address = Tagged<(User, address: ()), String>
}
```

This may look a bit strange with the dangling `()`, but it's otherwise nice and succinct, and the type safety we get is more than worth it.

### Accessing Raw Values

Tagged uses the same interface as `RawRepresentable` to expose its raw values, _via_ a `rawValue` property:

``` swift
user.id.rawValue // Int
```

You can also manually instantiate tagged types using `init(rawValue:)`, though you can often avoid this using the [`Decodable`](#codable) and [`ExpressibleBy`-`Literal`](#expressibleby-literal) family of protocols.

## Features

Tagged uses [conditional conformance](https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md), so you don't have to sacrifice expressiveness for safety. If the raw values are encodable or decodable, equatable, hashable, comparable, or expressible by literals, the tagged values follow suit. This means we can often avoid unnecessary (and potentially dangerous) [wrapping and unwrapping](#accessing-raw-values).

### Equatable

A tagged type is automatically equatable if its raw value is equatable. We took advantage of this in [our example](#the-problem), above.

``` swift
subscriptions.first(where: { $0.id == user.subscriptionId })
```

### Hashable

We can use underlying hashability to create a set or lookup dictionary.

``` swift
var userIds: Set<User.Id> = []
var users: [User.Id: User] = [:]
```

### Comparable

We can sort directly on a comparable tagged type.

``` swift
userIds.sorted(by: <)
users.values.sorted(by: { $0.email < $1.email })
```

### Codable

Tagged types are as encodable and decodable as the types they wrap.

``` swift
struct User: Decodable {
  let id: Id
  let email: Email
  let address: Address
  let subscriptionId: Subscription.Id?

  typealias Id = Tagged<User, Int>
  typealias Email = Tagged<(User, email: ()), String>
  typealias Address = Tagged<(User, address: ()), String>
}

JSONDecoder().decode(User.self, from: Data("""
{
  "id": 1,
  "email": "blob@pointfree.co",
  "address": "1 Blob Ln",
  "subscriptionId": null
}
""".utf8)
```

### ExpressiblyBy-Literal

Tagged types inherit literal expressibility. This is helpful for working with constants, like instantiating test data.

``` swift
User(
  id: 1,
  email: "blob@pointfree.co",
  address: "1 Blob Ln",
  subscriptionId: 1
)

// vs.

User(
  id: User.Id(rawValue: 1),
  email: User.Email(rawValue: "blob@pointfree.co"),
  address: User.Address(rawValue: "1 Blob Ln"),
  subscriptionId: Subscription.Id(rawValue: 1)
)
```

### Numeric

Numeric tagged types get mathematical operations for free!

``` swift
struct Product {
  let amount: Cents

  typealias Cents = Tagged<Product, Int>
}
```
``` swift
let totalCents = products.reduce(0) { $0.amount + $1.amount }
```

## FAQ

  - **Why not use a type alias?**

    Type aliases are just that: aliases. A type alias can be used interchangeably with the original type and offers no additional safety or guarantees.

  - **Why not use `RawRepresentable`, or some other protocol?**

    Protocols like `RawRepresentable` are useful, but they can't be extended conditionally, so you miss out on all of Tagged's free [features](#features). Using a protocol means you need to manually opt each type into synthesizing `Equatable`, `Hashable`, `Decodable` and `Encodable`, and to achieve the same level of expressiveness as Tagged, you need to manually conform to other protocols, like `Comparable`, the `ExpressibleBy`-`Literal` family of protocols, and `Numeric`. That's a _lot_ of boilerplate you need to write or generate, but Tagged gives it to you for free!

## Installation

### Carthage

If you use [Carthage](https://github.com/Carthage/Carthage), you can add the following dependency to your `Cartfile`:

``` ruby
github "pointfreeco/swift-tagged" ~> 0.1
```

### CocoaPods

If your project uses [CocoaPods](https://cocoapods.org), just add the following to your `Podfile`:

``` ruby
pod 'Tagged', '~> 0.1'
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

These concepts (and more) are explored thoroughly in [Point-Free](https://www.pointfree.co), a video series exploring functional programming and Swift hosted by [Brandon Williams](https://github.com/mbrandonw) and [Stephen Celis](https://github.com/stephencelis).

Tagged was first explored in [Episode #12](https://www.pointfree.co/episodes/ep12-tagged):

<a href="https://www.pointfree.co/episodes/ep12-tagged">
  <img alt="video poster image" src="https://d1hf1soyumxcgv.cloudfront.net/0012-tagged/0012-poster.jpg" width="480">
</a>

## License

All modules are released under the MIT license. See [LICENSE](LICENSE) for details.
