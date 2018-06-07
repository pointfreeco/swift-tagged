
public struct Tagged<Tag, RawValue> {
  public var rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }

  public func map<B>(_ f: (RawValue) -> B) -> Tagged<Tag, B> {
    return .init(rawValue: f(self.rawValue))
  }
}

extension Tagged: CustomStringConvertible {
  public var description: String {
    return String(describing: self.rawValue)
  }
}

extension Tagged: RawRepresentable {
}

extension Tagged: CustomPlaygroundDisplayConvertible {
  public var playgroundDescription: Any {
    return self.rawValue
  }
}

// MARK: - Conditional Conformances

extension Tagged: Comparable where RawValue: Comparable {
  public static func < (lhs: Tagged, rhs: Tagged) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}

extension Tagged: Decodable where RawValue: Decodable {
  public init(from decoder: Decoder) throws {
    self.init(rawValue: try decoder.singleValueContainer().decode(RawValue.self))
  }
}

extension Tagged: Encodable where RawValue: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(self.rawValue)
  }
}

extension Tagged: Equatable where RawValue: Equatable {
  public static func == (lhs: Tagged, rhs: Tagged) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}

extension Tagged: Error where RawValue: Error {
}

extension Tagged: ExpressibleByBooleanLiteral where RawValue: ExpressibleByBooleanLiteral {
  public typealias BooleanLiteralType = RawValue.BooleanLiteralType

  public init(booleanLiteral value: RawValue.BooleanLiteralType) {
    self.init(rawValue: RawValue(booleanLiteral: value))
  }
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
  public typealias ExtendedGraphemeClusterLiteralType = RawValue.ExtendedGraphemeClusterLiteralType

  public init(extendedGraphemeClusterLiteral: ExtendedGraphemeClusterLiteralType) {
    self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: extendedGraphemeClusterLiteral))
  }
}

extension Tagged: ExpressibleByFloatLiteral where RawValue: ExpressibleByFloatLiteral {
  public typealias FloatLiteralType = RawValue.FloatLiteralType

  public init(floatLiteral: FloatLiteralType) {
    self.init(rawValue: RawValue(floatLiteral: floatLiteral))
  }
}

extension Tagged: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
  public typealias IntegerLiteralType = RawValue.IntegerLiteralType

  public init(integerLiteral: IntegerLiteralType) {
    self.init(rawValue: RawValue(integerLiteral: integerLiteral))
  }
}

extension Tagged: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
  public typealias StringLiteralType = RawValue.StringLiteralType

  public init(stringLiteral: StringLiteralType) {
    self.init(rawValue: RawValue(stringLiteral: stringLiteral))
  }
}

extension Tagged: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
  public typealias UnicodeScalarLiteralType = RawValue.UnicodeScalarLiteralType

  public init(unicodeScalarLiteral: UnicodeScalarLiteralType) {
    self.init(rawValue: RawValue(unicodeScalarLiteral: unicodeScalarLiteral))
  }
}

extension Tagged: LosslessStringConvertible where RawValue: LosslessStringConvertible {
  public init?(_ description: String) {
    guard let rawValue = RawValue(description) else { return nil }
    self.init(rawValue: rawValue)
  }
}

extension Tagged: Numeric where RawValue: Numeric {
  public typealias Magnitude = RawValue.Magnitude

  public init?<T>(exactly source: T) where T: BinaryInteger {
    guard let rawValue = RawValue(exactly: source) else { return nil }
    self.init(rawValue: rawValue)
  }

  public var magnitude: RawValue.Magnitude {
    return self.rawValue.magnitude
  }

  public static func + (lhs: Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) -> Tagged<Tag, RawValue> {
    return self.init(rawValue: lhs.rawValue + rhs.rawValue)
  }

  public static func += (lhs: inout Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) {
    lhs.rawValue += rhs.rawValue
  }

  public static func * (lhs: Tagged, rhs: Tagged) -> Tagged {
    return self.init(rawValue: lhs.rawValue * rhs.rawValue)
  }

  public static func *= (lhs: inout Tagged, rhs: Tagged) {
    lhs.rawValue *= rhs.rawValue
  }

  public static func - (lhs: Tagged, rhs: Tagged) -> Tagged<Tag, RawValue> {
    return self.init(rawValue: lhs.rawValue - rhs.rawValue)
  }

  public static func -= (lhs: inout Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) {
    lhs.rawValue -= rhs.rawValue
  }
}

extension Tagged: Hashable where RawValue: Hashable {
  public var hashValue: Int {
    return self.rawValue.hashValue
  }
}

extension Tagged: SignedNumeric where RawValue: SignedNumeric {
}

// Commenting these out for Joe.
//
// https://twitter.com/jckarter/status/985375396601282560
//
//extension Tagged: ExpressibleByArrayLiteral where RawValue: ExpressibleByArrayLiteral {
//  public typealias ArrayLiteralElement = RawValue.ArrayLiteralElement
//
//  public init(arrayLiteral elements: ArrayLiteralElement...) {
//    let f = unsafeBitCast(
//      RawValue.init(arrayLiteral:) as (ArrayLiteralElement...) -> RawValue,
//      to: (([ArrayLiteralElement]) -> RawValue).self
//    )
//
//    self.init(rawValue: f(elements))
//  }
//}
//
//extension Tagged: ExpressibleByDictionaryLiteral where RawValue: ExpressibleByDictionaryLiteral {
//  public typealias Key = RawValue.Key
//  public typealias Value = RawValue.Value
//
//  public init(dictionaryLiteral elements: (Key, Value)...) {
//    let f = unsafeBitCast(
//      RawValue.init(dictionaryLiteral:) as ((Key, Value)...) -> RawValue,
//      to: (([(Key, Value)]) -> RawValue).self
//    )
//
//    self.init(rawValue: f(elements))
//  }
//}
