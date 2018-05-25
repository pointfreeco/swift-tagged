import Tagged
import Foundation

extension Tagged {
  func map<B>(_ f: @escaping (RawValue) -> B) -> Tagged<Tag, B> {
    return Tagged<Tag, B>(rawValue: f(self.rawValue))
  }
}

protocol OptionalProtocol {
  associatedtype Wrapped
  var some: Wrapped? { get }
  func map<B>(_ f: (Wrapped) throws -> B) rethrows -> B?
}

extension Optional: OptionalProtocol {
  var some: Wrapped? {
    return self
  }
}

extension Tagged where RawValue: OptionalProtocol {
  func mapInto<B>(_ f: @escaping (RawValue.Wrapped) -> B) -> Tagged<Tag, B?> {
    return self.map { $0.map(f) }
  }

  func not(_ tag: Tag.Type) -> RawValue {
    return self.rawValue
  }

  func get(_ tag: Tag.Type) -> RawValue {
    return self.rawValue
  }

  func `is`(_ tag: Tag.Type) -> Bool {
    return self.rawValue == nil
  }
  func isNot(_ tag: Tag.Type) -> Bool {
    return self.rawValue != nil
  }
}

enum Failed {}
typealias Failable<A> = Tagged<Failed, A?>
//extension Tagged where Tag == Failed {
//  var successful: RawValue {
//    return self.rawValue
//  }
//}

enum Canceled {}
typealias Cancelable<A> = Tagged<Canceled, A?>
//extension Tagged where Tag == Canceled {
//  var notCanceled: RawValue {
//    return self.rawValue
//  }
//}

enum NotFound {}
typealias Findable<A> = Tagged<NotFound, A?>
//extension Tagged where Tag == NotFound {
//  var found: RawValue {
//    return self.rawValue
//  }
//}

extension Optional: ExpressibleByIntegerLiteral where Wrapped: ExpressibleByIntegerLiteral {
  public typealias IntegerLiteralType = Wrapped.IntegerLiteralType
  public init(integerLiteral value: Wrapped.IntegerLiteralType) {
    self = .some(.init(integerLiteral: value))
  }
}

//let canceledOrFailedOrSucceeded: Cancelable<Failable<Int>> = .init(rawValue: nil)
//let result2: Cancelable<Failable<Int>> = Cancelable<Failable<Int>>.init(rawValue: Tagged<Failed, Int?>.init(rawValue: nil))
let result3: Cancelable<Failable<Int>> = Cancelable<Failable<Int>>.init(rawValue: Tagged<Failed, Int?>.init(rawValue: 2))
//let result4: Cancelable<Failable<Findable<Int>>> = 2
//
//dump(canceledOrFailedOrSucceeded)
//dump(canceledOrFailedOrSucceeded.notCanceled)
//dump(canceledOrFailedOrSucceeded.notCanceled?.successful)
//dump(result2)
//dump(result2.notCanceled)
//dump(result2.notCanceled?.successful)
//
//result2.notCanceled?.successful
//
////result2.map { $0.map { $0 + 1 } }
//
//let tmp = result3.map { $0.map { $0.map { $0.map { $0 + 1 } } } }
//dump(result3.mapInto { $0.mapInto { $0 + 1 } })
//tmp.notCanceled?.successful
//
//result3
//  ._mapInto(Canceled.self, {
//    $0._mapInto(Failed.self, { $0 })
//  })
////

result3.not(Canceled.self)?.not(Failed.self)

//result3.notCanceled?.successful?.found
