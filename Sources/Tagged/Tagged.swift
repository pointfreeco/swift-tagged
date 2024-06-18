@dynamicMemberLookup
public struct Tagged<Tag, RawValue> {
  public var rawValue: RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }

  public init(_ rawValue: RawValue) {
    self.rawValue = rawValue
  }

  public subscript<Subject>(dynamicMember keyPath: KeyPath<RawValue, Subject>) -> Subject {
    rawValue[keyPath: keyPath]
  }

  public func map<NewValue>(
    _ transform: (RawValue) throws -> NewValue
  ) rethrows -> Tagged<Tag, NewValue> {
    Tagged<Tag, NewValue>(rawValue: try transform(rawValue))
  }

  public func coerced<NewTag>(to type: NewTag.Type) -> Tagged<NewTag, RawValue> {
    unsafeBitCast(self, to: Tagged<NewTag, RawValue>.self)
  }
}

extension Tagged: CustomStringConvertible {
  public var description: String {
    String(describing: rawValue)
  }
}

extension Tagged: RawRepresentable {}

extension Tagged: CustomPlaygroundDisplayConvertible {
  public var playgroundDescription: Any {
    rawValue
  }
}

// MARK: - Conditional Conformances

extension Tagged: Collection where RawValue: Collection {
  public func index(after i: RawValue.Index) -> RawValue.Index {
    rawValue.index(after: i)
  }

  public subscript(position: RawValue.Index) -> RawValue.Element {
    rawValue[position]
  }

  public var startIndex: RawValue.Index {
    rawValue.startIndex
  }

  public var endIndex: RawValue.Index {
    rawValue.endIndex
  }

  public consuming func makeIterator() -> RawValue.Iterator {
    rawValue.makeIterator()
  }
}

extension Tagged: Comparable where RawValue: Comparable {
  public static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}

extension Tagged: Decodable where RawValue: Decodable {
  public init(from decoder: Decoder) throws {
    do {
      self.init(rawValue: try decoder.singleValueContainer().decode(RawValue.self))
    } catch {
      self.init(rawValue: try RawValue(from: decoder))
    }
  }
}

extension Tagged: Encodable where RawValue: Encodable {
  public func encode(to encoder: Encoder) throws {
    do {
      var container = encoder.singleValueContainer()
      try container.encode(self.rawValue)
    } catch {
      try self.rawValue.encode(to: encoder)
    }
  }
}

@available(macOS 12.3, iOS 15.4, watchOS 8.5, tvOS 15.4, *)
extension Tagged: CodingKeyRepresentable where RawValue: CodingKeyRepresentable {
  public init?(codingKey: some CodingKey) {
    guard let rawValue = RawValue(codingKey: codingKey)
    else { return nil }
    self.init(rawValue: rawValue)
  }

  public var codingKey: CodingKey {
    self.rawValue.codingKey
  }
}

extension Tagged: Equatable where RawValue: Equatable {}

extension Tagged: Error where RawValue: Error {}

extension Tagged: Sendable where RawValue: Sendable {}

extension Tagged: ExpressibleByBooleanLiteral where RawValue: ExpressibleByBooleanLiteral {
  public init(booleanLiteral value: RawValue.BooleanLiteralType) {
    self.init(rawValue: RawValue(booleanLiteral: value))
  }
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral
where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
  public init(extendedGraphemeClusterLiteral: RawValue.ExtendedGraphemeClusterLiteralType) {
    self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: extendedGraphemeClusterLiteral))
  }
}

extension Tagged: ExpressibleByFloatLiteral where RawValue: ExpressibleByFloatLiteral {
  public init(floatLiteral: RawValue.FloatLiteralType) {
    self.init(rawValue: RawValue(floatLiteral: floatLiteral))
  }
}

extension Tagged: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
  public init(integerLiteral: RawValue.IntegerLiteralType) {
    self.init(rawValue: RawValue(integerLiteral: integerLiteral))
  }
}

extension Tagged: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
  public init(stringLiteral: RawValue.StringLiteralType) {
    self.init(rawValue: RawValue(stringLiteral: stringLiteral))
  }
}

extension Tagged: ExpressibleByStringInterpolation
where RawValue: ExpressibleByStringInterpolation {
  public init(stringInterpolation: RawValue.StringInterpolation) {
    self.init(rawValue: RawValue(stringInterpolation: stringInterpolation))
  }
}

extension Tagged: ExpressibleByUnicodeScalarLiteral
where RawValue: ExpressibleByUnicodeScalarLiteral {
  public init(unicodeScalarLiteral: RawValue.UnicodeScalarLiteralType) {
    self.init(rawValue: RawValue(unicodeScalarLiteral: unicodeScalarLiteral))
  }
}

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
extension Tagged: Identifiable where RawValue: Identifiable {
  public var id: RawValue.ID {
    rawValue.id
  }
}

extension Tagged: LosslessStringConvertible where RawValue: LosslessStringConvertible {
  public init?(_ description: String) {
    guard let rawValue = RawValue(description) else { return nil }
    self.init(rawValue: rawValue)
  }
}

extension Tagged: AdditiveArithmetic where RawValue: AdditiveArithmetic {
  public static var zero: Self {
    Self(rawValue: .zero)
  }

  public static func + (lhs: Self, rhs: Self) -> Self {
    Self(rawValue: lhs.rawValue + rhs.rawValue)
  }

  public static func += (lhs: inout Self, rhs: Self) {
    lhs.rawValue += rhs.rawValue
  }

  public static func - (lhs: Self, rhs: Self) -> Self {
    Self(rawValue: lhs.rawValue - rhs.rawValue)
  }

  public static func -= (lhs: inout Self, rhs: Self) {
    lhs.rawValue -= rhs.rawValue
  }
}

extension Tagged: Numeric where RawValue: Numeric {
  public init?(exactly source: some BinaryInteger) {
    guard let rawValue = RawValue(exactly: source) else { return nil }
    self.init(rawValue: rawValue)
  }

  public var magnitude: RawValue.Magnitude {
    rawValue.magnitude
  }

  public static func * (lhs: Self, rhs: Self) -> Self {
    Self(rawValue: lhs.rawValue * rhs.rawValue)
  }

  public static func *= (lhs: inout Self, rhs: Self) {
    lhs.rawValue *= rhs.rawValue
  }
}

extension Tagged: Hashable where RawValue: Hashable {}

extension Tagged: SignedNumeric where RawValue: SignedNumeric {}

extension Tagged: Sequence where RawValue: Sequence {
  public consuming func makeIterator() -> RawValue.Iterator {
    rawValue.makeIterator()
  }
}

extension Tagged: Strideable where RawValue: Strideable {
  public func distance(to other: Self) -> RawValue.Stride {
    rawValue.distance(to: other.rawValue)
  }

  public func advanced(by n: RawValue.Stride) -> Self {
    Tagged(rawValue: rawValue.advanced(by: n))
  }
}

extension Tagged: ExpressibleByArrayLiteral where RawValue: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: RawValue.ArrayLiteralElement...) {
    let f = unsafeBitCast(
      RawValue.init(arrayLiteral:) as (RawValue.ArrayLiteralElement...) -> RawValue,
      to: (([RawValue.ArrayLiteralElement]) -> RawValue).self
    )

    self.init(rawValue: f(elements))
  }
}

extension Tagged: ExpressibleByDictionaryLiteral where RawValue: ExpressibleByDictionaryLiteral {
  public init(dictionaryLiteral elements: (RawValue.Key, RawValue.Value)...) {
    let f = unsafeBitCast(
      RawValue.init(dictionaryLiteral:) as ((RawValue.Key, RawValue.Value)...) -> RawValue,
      to: (([(Key, Value)]) -> RawValue).self
    )

    self.init(rawValue: f(elements))
  }
}

#if canImport(Foundation)
  import Foundation

  extension Tagged: LocalizedError where RawValue: Error {
    public var errorDescription: String? {
      rawValue.localizedDescription
    }

    public var failureReason: String? {
      (rawValue as? LocalizedError)?.failureReason
    }

    public var helpAnchor: String? {
      (rawValue as? LocalizedError)?.helpAnchor
    }

    public var recoverySuggestion: String? {
      (rawValue as? LocalizedError)?.recoverySuggestion
    }
  }
#endif
