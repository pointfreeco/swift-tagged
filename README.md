# 🏷 Tagged
MacOS [![CircleCI](https://circleci.com/gh/pointfreeco/swift-tagged.svg?style=svg)](https://circleci.com/gh/pointfreeco/swift-tagged) Linux [![Build Status](https://travis-ci.org/pointfreeco/swift-tagged.svg?branch=master)](https://travis-ci.org/pointfreeco/swift-tagged)

A library for safer types.

## Table of Contents

  - [Introduction](#introduction)
  - [The Problem](#the-problem)
  - [The Solution](#the-solution)
      - [Handling Tag Collisions](#handling-tag-collisions)
      - [Accessing Raw Values](#accessing-raw-values)
  - [Features](#features)
  - [Installation](#installation)
  - [Learn More](#learn-more)
  - [License](#license)

## Introduction

We often work with types that are far too general or hold far too many values than what is necessary for our domain. Sometimes we just want to differentiate between two seemingly equivalent values at the type level.

An email address is nothing but a `String`, but it should be restricted in the ways in which it can be used. And while a `User` id may be represented with an `Int`, it should be distinguishable from an `Int`-based `Subscription` id.

Tagged can help solve serious runtime bugs at compile time by wrapping basic types in more specific contexts with ease.

## The Problem

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

We're modeling user and subscription ids using the same type, but our app logic shouldn't treat these values interchangeably. We might write a function to fetch a subscription:

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

## The Solution

Luckily, we can use Tagged to succinctly differentiate these types.

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

Tagged depends on a generic "tag" parameter to make each type unique. Here we've use the parent type to uniquely tag each id.

We can now update `fetchSubscription` to take a `Subscription.Id` where it previously took any `Int`.

``` swift
func fetchSubscription(byId id: Subscription.Id) -> Subscription? {
  return subscriptions.first(where: { $0.id == id })
}
```

And there's no chance we'll accidentally pass a `User` id where we expect a `Subscription` id.

``` swift
let subscription = fetchSubscription(byId: user.id)
```

> Cannot convert value of type 'User.Id' (aka 'Tagged<User, Int>') to expected argument type 'Subscription.Id' (aka 'Tagged<Subscription, Int>')

We've prevented a couple serious bugs at compile time!

There's another bug lurking in these types. We've written a function with the following signature:

``` swift
sendWelcomeEmail(toAddress address: String)
```

It contains logic that sends a specific email to an email address. Unfortunately, it takes _any_ string as input.

``` swift
sendWelcomeEmail(toAddress: user.address)
```

This compiles and runs, but `user.address` refers to our user's billing address, _not_ their email! None of our users are getting welcome emails! Worse yet, calling this function with invalid data may cause server churn and crashes.

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

We update our `sendWelcomeEmail` signature and have another compile time guarantee.

``` swift
sendWelcomeEmail(toAddress address: Email)
```

``` swift
sendWelcomeEmail(toAddress: user.address)
```

> Cannot convert value of type 'String' to expected argument type 'Email' (aka 'Tagged<EmailTag, String>')

### Handling Tag Collisions

Alright, but what if we want to tag our user's address?

``` swift
struct User {
  let id: Id
  let email: Email
  let address: Address
  let subscriptionId: Subscription.Id?

  typealias Id = Tagged<User, Int>
  typealias Email = Tagged<User, String>
  typealias Address = Tagged<???, String>
}
```

We shouldn't reuse `Tagged<User, String>`, because then the compiler would treat `Email` and `Address` as the same type! We need a new tag, which means we need a new type. We can use anything, but an uninhabited enum is nestable and uninstantiable, making it pretty perfect.

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

We've now distinguished `User.Email` and `User.Address` at the cost of an extra line and type, but things are documented very explicitly.

If we want to save a line, we can take advantage of the fact that tuple labels are encoded in the type system and can be used to differentiate two seemingly equivalent tuple types.

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

This may look a bit strange with the dangling `()`, but it's nice and succinct, and the type safety we get is more than worth it.

### Accessing Raw Values

Inevitably, you're going to need the raw value _somewhere_ in your code. Luckily, the interface is familiar. Tagged uses the same interface as `RawRepresentable`.

``` swift
user.id.rawValue     // Int
User.Id(rawValue: 1) // User.Id
```

## Features

Tagged relies on conditional conformance to be practical: if the raw values are encodable or decodable, equatable, hashable, or comparable, the tagged values follow suit.

### Equatable

We took advantage of this in our example, above.

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

### Numeric

Numeric tagged types get mathematical operations for free!

``` swift
struct Product {
  let amount: Cents

  typealias Cents = Tagged<Payment, Int>
}
```
``` swift
let totalCents = products.reduce(0) { $0.amount + $1.amount }
```

### ExpressiblyBy–Literal

Tagged types also inherit any literal expressibility. This is helpful for working with constants, like instantiating test data.

``` swift
User(
  id: 1,
  email: "blob@pointfree.co",
  address: "1 Blob Ln"
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

## Learn More

These concepts (and more) are explored thoroughly in [Point-Free](https://www.pointfree.co), a video series exploring functional programming and Swift.

## License

All modules are released under the MIT license. See [LICENSE](LICENSE) for details.
